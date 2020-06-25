import 'package:flutter/material.dart';
import 'package:moto_maintenance/src/models/validation/validation_item.dart';

class SignupValidation with ChangeNotifier {

  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _password = ValidationItem(null, null);
  ValidationItem _confirmedPassword = ValidationItem(null, null);

  // getters
  ValidationItem get email => _email;
  ValidationItem get password => _password;
    ValidationItem get confirmedpassword => _confirmedPassword;

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

  void changeConfirmedPassword(String val) {
    if (val == _password.value){
      _confirmedPassword = ValidationItem(val, null);
    } else {
      _confirmedPassword = ValidationItem(null, 'passwords do not match');
    }
    notifyListeners();
  }

  void resetValues() {
    _email = ValidationItem(null, null);
    _password = ValidationItem(null, null);
    _confirmedPassword = ValidationItem(null, null);
    notifyListeners();
  }

  bool isValidated() {
    return (_email.value != null && _password.value != null && _password.value == _confirmedPassword.value) ? true : false;
  }
}