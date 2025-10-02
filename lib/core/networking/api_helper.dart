import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mime/mime.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../database/hive_helper.dart';
import '../helpers/extensions/context_extension.dart';
import '../helpers/data_helper/date_helper.dart';
import '../routes/app_router.dart';

enum ResponseState {
  sleep,
  offline,
  loading,
  pagination,
  complete,
  error,
  unauthorized,
}

class ApiResponse {
  int? statusCode;
  ResponseState? state;
  String? id;
  DateTime? time;
  String? message;
  String? errors;
  dynamic data;
  bool? succeeded;
  int? actionCode;
  int? pageNumber;
  int? totalPages;
  int? totalCount;
  bool? hasPreviousPage;
  bool? hasNextPage;

  ApiResponse({
    this.statusCode,
    required this.state,
    this.id,
    this.time,
    this.message,
    this.errors,
    this.data,
    this.succeeded,
    this.actionCode,
    this.pageNumber,
    this.totalPages,
    this.totalCount,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  ApiResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    time = DateHelper.convertJsonDate(json["DateTime"]);
    succeeded = json['Succeeded'];
    message = json['Message'];
    errors = json['Errors'];
    actionCode = json['ActionCode'];
    if (json['Data'] is Map<String, dynamic>) {
      Map<String, dynamic> d = json['Data'];
      if (d.containsKey('Items')) {
        data = d['Items'];
        pageNumber = d['PageNumber'];
        totalPages = d['TotalPages'];
        totalCount = d['TotalCount'];
        hasPreviousPage = d['HasPreviousPage'];
        hasNextPage = d['HasNextPage'];
      } else {
        data = json['Data'];
      }
    } else {
      data = json['Data'];
    }
  }
}

enum ApiRequestType { get, post, put, delete, patch }

class ApiHelper {
  static ApiHelper? _instance;

  ApiHelper._();

  static ApiHelper get instance {
    _instance ??= ApiHelper._();

    return _instance!;
  }

  MediaType appMediaType(String path) {
    List<String> list = "${lookupMimeType(path)}".split('/');
    return MediaType('${list.firstOrNull}', '${list.lastOrNull}');
  }

  final Dio _dio =
      Dio()
        ..interceptors.addAll(
          kDebugMode
              ? [
                PrettyDioLogger(
                  requestHeader: true,
                  requestBody: true,
                  responseBody: true,
                  responseHeader: false,
                  compact: false,
                  error: true,
                  request: true,
                ),
              ]
              : [],
        );

  Options _options(Map<String, String>? headers, bool hasToken) {
    return Options(
      contentType: 'application/json',
      followRedirects: false,
      validateStatus: (status) {
        return true;
      },
      headers: {
        'Accept': 'application/json',
        'Accept-Language': _getLangFromLocal(),
        if (HiveHelper.getToken() != null && hasToken) ...{
          'Authorization': "Bearer ${HiveHelper.getToken()}",
        },
        ...?headers,
      },
    );
  }

  int _getLangFromLocal() {
    switch (AppRouter.navigatorKey.currentContext!.locale.languageCode) {
      case 'ar':
        if (AppRouter.navigatorKey.currentContext!.locale.countryCode
                ?.toUpperCase() ==
            'EG') {
          return 2;
        } else {
          return 0;
        }
      case 'en':
        return 1;
      default:
        return 0;
    }
  }

  String _offlineMessage() {
    return AppRouter.navigatorKey.currentContext!.apiTr(
      ar: "تأكد من الاتصال بالإنترنت",
      en: "Make sure you are connected to the internet",
    );
  }

  String _errorMessage() {
    return AppRouter.navigatorKey.currentContext!.apiTr(
      ar: "حدث خطأ",
      en: "An error occurred",
    );
  }

  String _error(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout';
      case DioExceptionType.sendTimeout:
        return 'Send timeout';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout';
      case DioExceptionType.badCertificate:
        return 'Bad certificate';
      case DioExceptionType.badResponse:
        return 'Bad response';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      case DioExceptionType.connectionError:
        return 'Connection error';
      case DioExceptionType.unknown:
        return 'Unknown';
    }
  }

  Future<ApiResponse> apiCall(
    String url, {
    required ApiRequestType requestType,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,

    /// Use when [requestType] is [ApiRequestType.get] , [ApiRequestType.post] , [ApiRequestType.put] or [ApiRequestType.patch]
    void Function(int, int)? onReceiveProgress,

    /// Use when [requestType] is [ApiRequestType.post] , [ApiRequestType.put] or [ApiRequestType.patch]
    void Function(int, int)? onSendProgress,
    bool hasToken = true,
  }) async {
    ApiResponse responseJson;
    if (await hasConnection() == false) {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        message: _offlineMessage(),
      );
      return responseJson;
    }

    try {
      Response<dynamic> response;

      switch (requestType) {
        case ApiRequestType.get:
          response = await _dio.get(
            url,
            queryParameters: queryParameters,
            options: _options(headers, hasToken),
            onReceiveProgress: onReceiveProgress,
          );
          break;
        case ApiRequestType.post:
          response = await _dio.post(
            url,
            queryParameters: queryParameters,
            data: body,
            options: _options(headers, hasToken),
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;
        case ApiRequestType.put:
          response = await _dio.put(
            url,
            queryParameters: queryParameters,
            data: body,
            options: _options(headers, hasToken),
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;
        case ApiRequestType.delete:
          response = await _dio.delete(
            url,
            queryParameters: queryParameters,
            data: body,
            options: _options(headers, hasToken),
          );
          break;
        case ApiRequestType.patch:
          response = await _dio.patch(
            url,
            queryParameters: queryParameters,
            data: body,
            options: _options(headers, hasToken),
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;
      }
      responseJson = _buildResponse(response);
      return responseJson;
    } on DioException catch (e) {
      _error(e);
      responseJson = ApiResponse(
        state: ResponseState.error,
        message: _errorMessage(),
      );
      return responseJson;
    } on SocketException {
      responseJson = ApiResponse(
        state: ResponseState.offline,
        message: _offlineMessage(),
      );
      return responseJson;
    }
  }

  ApiResponse _buildResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = response.data;
        if (responseJson is Map<String, dynamic>) {
          final apiResponse = ApiResponse.fromJson(responseJson);
          apiResponse.statusCode = response.statusCode;
          apiResponse.state = ResponseState.complete;
          return apiResponse;
        } else {
          return ApiResponse(
            state: ResponseState.complete,
            data: responseJson,
            statusCode: response.statusCode,
          );
        }

      case 401:
        var responseJson = response.data;
        final apiResponse = ApiResponse.fromJson(responseJson);
        apiResponse.statusCode = response.statusCode;
        apiResponse.state = ResponseState.unauthorized;
        return apiResponse;
      case 400:
      case 422:
      case 403:
        var responseJson = response.data;
        final apiResponse = ApiResponse.fromJson(responseJson);
        apiResponse.statusCode = response.statusCode;
        apiResponse.state = ResponseState.error;
        return apiResponse;
      case 500:
      default:
        return ApiResponse(
          state: ResponseState.error,
          message: _errorMessage(),
          statusCode: response.statusCode,
        );
    }
  }

  static Future<bool> hasConnection() async {
    bool isConnected = await InternetConnectionChecker.instance.hasConnection;
    if (isConnected) {
      return true;
    } else {
      return false;
    }
  }
}
