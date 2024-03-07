import 'package:flutter/material.dart';

class AdsCallBack extends ChangeNotifier {
  bool dismiss = false;
  bool failed = false;

  setFailed() {
    failed = true;
    notifyListeners();
  }

  setDismiss() {
    dismiss = true;
    notifyListeners();
  }

  Future<String> openAdsOnMessageEvent() async {
    String finalResult = '';
    if (dismiss) {
      finalResult = "Dissmiss";
    } else {
      finalResult = "Failed";
    }
    return finalResult;
  }
}