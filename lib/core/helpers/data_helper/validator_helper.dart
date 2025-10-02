import '../../data/models/countries/countries.dart';

class ValidatorHelper {
  static String? validatePhone(String? phone, {CountryCodeModel? country}) {
    if (phone == null || phone.trim().isEmpty) {
      return "Enter phone number";
    } else if (country != null) {
      if (!_isStartWithNumber(phone, country)) {
        return "Phone number must start with ${country.startDigits}";
      } else if (phone.trim().length < country.numLenFrom! ||
          phone.trim().length > country.numLenTo!) {
        return country.numLenFrom == country.numLenTo
            ? "Phone number length must be ${country.numLenFrom} digits"
            : "Phone number length must be between ${country.numLenFrom} and ${country.numLenTo} digits";
      }
    }
    return null;
  }

  static bool _isStartWithNumber(String? phone, CountryCodeModel country) {
    final element = phone?.trim().substring(0, 1);
    return country.startDigits?.contains(element) ?? false;
  }

  static String? validateEmail(String? value) {
    if (value!.trim().isEmpty) {
      return "Enter email";
    } else if (!_emailValidationStructure(value.trim())) {
      return "Enter valid email";
    }
    return null;
  }

  static bool _emailValidationStructure(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  static String? validatePassword(String? value) {
    if (value!.trim().length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  static String _password = '';
  static String? validateNewPassword(String? value) {
    _password = value!;
    if (value.trim().length < 8) {
      return "Password must be at least 8 characters";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value) {
    if (value!.trim().length < 8) {
      return "Password must be at least 8 characters";
    } else if (_password != value) {
      return "Password doesn't match";
    }
    return null;
  }

  static String? validateEmptyField(String? value, {String? error}) {
    if (value!.trim().isEmpty) {
      return error ?? "This field is required";
    }
    return null;
  }

  static String? validateEmptySingleSelect(dynamic value, {String? error}) {
    if (value == null) {
      return error ?? "Select an option";
    }
    return null;
  }

  static String? validateEmptyMultiSelect(
    List<dynamic>? value, {
    String? error,
  }) {
    if (value == null) {
      return error ?? "Select an option";
    } else if (value.isEmpty) {
      return error ?? "Select an option";
    }
    return null;
  }
}
