import 'package:flutter/material.dart';
import 'package:moto_maintenance/src/models/validation/validation_item.dart';

class SigninValidation with ChangeNotifier {

  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);

  // getters
  ValidationItem get email => _email;
  ValidationItem get password => _password;

  // setters
  void changeEmail(String val) {
    String emailRegExp = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(emailRegExp);
    if (regExp.hasMatch(val)){
      _email = ValidationItem(val, null);
    } else {
      _email = ValidationItem(null, 'invalid email');
    }
    notifyListeners();
  }

  void changePassword(String val) {
    if (val.length >= 6){
      _password = ValidationItem(val, null);
    } else {
      _password = ValidationItem(null, 'Must be at least 6 characters');
    }
    notifyListeners();
  }

  void resetValues() {
    _email = ValidationItem(null, null);
    _password = ValidationItem(null, null);
    notifyListeners();
  }

  bool isValidated() {
    return (_email.value != null && _password.value != null) ? true : false;
  }
}