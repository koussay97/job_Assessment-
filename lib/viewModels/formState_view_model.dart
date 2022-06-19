import 'package:flutter/material.dart';
import '../core/brand/brand_guid.dart';

class FormStateViewModel extends ChangeNotifier {
  Map<String, dynamic> firstNameResult = {"result": false};
  Map<String, dynamic> lastNameResult = {"result": false};
  Color firstNameErrorColor = Colors.grey;
  Color lastNameErrorColor = Colors.grey;
  bool loginBtnEnabled = true;
  bool showSnackBar = false;
  bool routeToMain = false;
  String firstName = '';
  String lastName = '';
  String capitalize(String val) {
    return "${val[0].toUpperCase()}${val.substring(1).toLowerCase()}";
  }
  void setFirstName(String value) {
    firstName = capitalize(value);
    notifyListeners();
  }

  void setLastName(String value) {
    lastName = capitalize(value);
    notifyListeners();
  }

  void setFirstNameResult({required validationResult}) {
    firstNameResult = validationResult;
    notifyListeners();
  }

  void setLastNameResult({required validationResult}) {
    lastNameResult = validationResult;
    notifyListeners();
  }

  bool isFormValid() {
    if (firstNameResult["result"] && lastNameResult["result"] as bool) {
      setSuccessBorderColor();
      return true;
    }
    setErrorBorderColor();
    return false;
  }

  void setErrorBorderColor() {
    if (!firstNameResult["result"]) {
      firstNameErrorColor = Brand.lightRed;
      notifyListeners();
    } else {
      lastNameErrorColor = Brand.lightRed;
      notifyListeners();
    }
  }

  void setSuccessBorderColor() {
    firstNameErrorColor = Brand.customGrey;
    lastNameErrorColor = Brand.customGrey;
    notifyListeners();
  }

  void setLoginBtnEnabled(bool val) {
    loginBtnEnabled = val;
    notifyListeners();
  }

  void setShowSnackBar(bool val) {
    showSnackBar = val;
    notifyListeners();
  }

  void setRouteToMain(bool val) {
    routeToMain = val;
    notifyListeners();
  }
}
