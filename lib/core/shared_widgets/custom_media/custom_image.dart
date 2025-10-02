import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/images/app_images.dart';
import '../custom_loading/custom_loading.dart';

class CustomImage extends StatefulWidget {
  /// image can be [String] for (network, asset, file path) or [Uint8List] for bytes
  final dynamic image;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit? fit;
  final bool hasZoom;
  final Widget? errorWidget;
  final Color? color;
  const CustomImage({
    super.key,
    this.image,
    this.width,
    this.height,
    this.radius = 0,
    this.fit,
    this.hasZoom = false,
    this.errorWidget,
    this.color,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.hasZoom ? () {} : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius),
        child: switch (getImageSourceType()) {
          null =>
            widget.errorWidget ??
                ErrorImg(height: widget.height, width: widget.width),
          _ImageType.network => _NetworkImg(
            image: widget.image,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            errorWidget: widget.errorWidget,
            color: widget.color,
          ),
          _ImageType.asset => _AssetImg(
            image: widget.image,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            errorWidget: widget.errorWidget,
            color: widget.color,
          ),
          _ImageType.file => _FileImg(
            image: widget.image,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            errorWidget: widget.errorWidget,
            color: widget.color,
          ),
          _ImageType.bytes => _MemoryImg(
            image: widget.image,
            width: widget.width,
            height: widget.height,
            fit: widget.fit,
            errorWidget: widget.errorWidget,
            color: widget.color,
          ),
        },
      ),
    );
  }

  _ImageType? getImageSourceType() {
    if (widget.image is Uint8List) {
      log('Image Type => bytes');
      return _ImageType.bytes;
    } else if (widget.image is String) {
      String img = widget.image;
      if (img.startsWith("http://") || img.startsWith("https://")) {
        log('Image Type => network');
        return _ImageType.network;
      } else if (!img.startsWith("/") &&
          !img.contains(":\\") &&
          !img.contains(":/")) {
        log('Image Type => asset');
        return _ImageType.asset;
      } else if (img.startsWith("/") ||
          img.contains(":\\") ||
          img.contains(":/")) {
        log('Image Type => file');
        return _ImageType.file;
      }
    }
    return null;
  }
}

class _NetworkImg extends StatefulWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Color? color;
  const _NetworkImg({
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.color,
  });

  @override
  State<_NetworkImg> createState() => _NetworkImgState();
}

class _NetworkImgState extends State<_NetworkImg> {
  @override
  Widget build(BuildContext context) {
    return switch (getImageFormat()) {
      _ImageFormat.png =>
        kIsWeb
            ? Image(
              image: NetworkImage(widget.image),
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
              color: widget.color,
              errorBuilder:
                  (context, error, stackTrace) =>
                      widget.errorWidget ??
                      ErrorImg(height: widget.height, width: widget.width),
            )
            : CachedNetworkImage(
              imageUrl: widget.image,
              fit: widget.fit,
              width: widget.width,
              height: widget.height,
              color: widget.color,
              placeholder:
                  (context, url) => Center(child: CustomLoading(size: 20)),
              errorWidget:
                  (context, url, error) =>
                      widget.errorWidget ??
                      ErrorImg(height: widget.height, width: widget.width),
            ),
      _ImageFormat.svg => SvgPicture.network(
        widget.image,
        fit: widget.fit ?? BoxFit.contain,
        width: widget.width,
        height: widget.height,
        placeholderBuilder: (context) => Center(child: CustomLoading(size: 20)),
        colorFilter:
            widget.color != null
                ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                : null,
        errorBuilder:
            (context, error, stackTrace) =>
                widget.errorWidget ??
                ErrorImg(height: widget.height, width: widget.width),
      ),
    };
  }

  _ImageFormat getImageFormat() {
    if (widget.image.endsWith(".svg")) {
      log('Image Format => svg');
      return _ImageFormat.svg;
    }
    log('Image Format => png');
    return _ImageFormat.png;
  }
}

class _AssetImg extends StatefulWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Color? color;
  const _AssetImg({
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.color,
  });

  @override
  State<_AssetImg> createState() => _AssetImgState();
}

class _AssetImgState extends State<_AssetImg> {
  @override
  Widget build(BuildContext context) {
    return switch (getImageFormat()) {
      _ImageFormat.png => Image(
        image: AssetImage(widget.image),
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
        color: widget.color,
        errorBuilder:
            (context, error, stackTrace) =>
                widget.errorWidget ??
                ErrorImg(height: widget.height, width: widget.width),
      ),
      _ImageFormat.svg => SvgPicture.asset(
        widget.image,
        fit: widget.fit ?? BoxFit.contain,
        width: widget.width,
        height: widget.height,
        placeholderBuilder: (context) => Center(child: CustomLoading(size: 20)),
        colorFilter:
            widget.color != null
                ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                : null,
        errorBuilder:
            (context, error, stackTrace) =>
                widget.errorWidget ??
                ErrorImg(height: widget.height, width: widget.width),
      ),
    };
  }

  _ImageFormat getImageFormat() {
    if (widget.image.endsWith(".svg")) {
      log('Image Format => svg');
      return _ImageFormat.svg;
    }
    log('Image Format => png');
    return _ImageFormat.png;
  }
}

class _FileImg extends StatefulWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Color? color;
  const _FileImg({
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.color,
  });

  @override
  State<_FileImg> createState() => _FileImgState();
}

class _FileImgState extends State<_FileImg> {
  @override
  Widget build(BuildContext context) {
    return switch (getImageFormat()) {
      _ImageFormat.png => FutureBuilder(
        future: File(widget.image).readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();
          return Image(
            image: MemoryImage(snapshot.data as Uint8List),
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
            color: widget.color,
            errorBuilder:
                (context, error, stackTrace) =>
                    widget.errorWidget ??
                    ErrorImg(height: widget.height, width: widget.width),
          );
        },
      ),
      _ImageFormat.svg => FutureBuilder(
        future: File(widget.image).readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();
          return SvgPicture.memory(
            snapshot.data as Uint8List,
            fit: widget.fit ?? BoxFit.contain,
            width: widget.width,
            height: widget.height,
            placeholderBuilder:
                (context) => Center(child: CustomLoading(size: 20)),
            colorFilter:
                widget.color != null
                    ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                    : null,
            errorBuilder:
                (context, error, stackTrace) =>
                    widget.errorWidget ??
                    ErrorImg(height: widget.height, width: widget.width),
          );
        },
      ),
    };
  }

  _ImageFormat getImageFormat() {
    if (widget.image.endsWith(".svg")) {
      log('Image Format => svg');
      return _ImageFormat.svg;
    }
    log('Image Format => png');
    return _ImageFormat.png;
  }
}

class _MemoryImg extends StatefulWidget {
  final Uint8List image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Color? color;
  const _MemoryImg({
    required this.image,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
    this.color,
  });

  @override
  State<_MemoryImg> createState() => _MemoryImgState();
}

class _MemoryImgState extends State<_MemoryImg> {
  @override
  Widget build(BuildContext context) {
    return switch (getImageFormat()) {
      _ImageFormat.png => Image(
        image: MemoryImage(widget.image),
        fit: widget.fit,
        width: widget.width,
        height: widget.height,
        color: widget.color,
        errorBuilder:
            (context, error, stackTrace) =>
                widget.errorWidget ??
                ErrorImg(height: widget.height, width: widget.width),
      ),
      _ImageFormat.svg => SvgPicture.memory(
        widget.image,
        fit: widget.fit ?? BoxFit.contain,
        width: widget.width,
        height: widget.height,
        placeholderBuilder: (context) => Center(child: CustomLoading(size: 20)),
        colorFilter:
            widget.color != null
                ? ColorFilter.mode(widget.color!, BlendMode.srcIn)
                : null,
        errorBuilder:
            (context, error, stackTrace) =>
                widget.errorWidget ??
                ErrorImg(height: widget.height, width: widget.width),
      ),
    };
  }

  _ImageFormat getImageFormat() {
    if (isSvgFromBytes(widget.image)) {
      log('Image Format => svg');
      return _ImageFormat.svg;
    }
    log('Image Format => png');
    return _ImageFormat.png;
  }

  bool isSvgFromBytes(Uint8List bytes) {
    try {
      final header = utf8.decode(
        bytes.sublist(0, bytes.length > 100 ? 100 : bytes.length),
      );
      return header.contains("<svg");
    } catch (e) {
      return false;
    }
  }
}

class ErrorImg extends StatelessWidget {
  final double? width;
  final double? height;
  const ErrorImg({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages.appIcon,
      fit: BoxFit.contain,
      width: width,
      height: height,
    );
  }
}

enum _ImageType { network, asset, file, bytes }

enum _ImageFormat { png, svg }
