import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'Constants.dart';

class Utilities {
  static String getImageBase64(String image) {
    final bytes = File(image).readAsBytesSync();
    return base64Encode(bytes);
  }

  static Future<String> uploadImage(FileType type) async {
    return await FilePicker.getFilePath(type: type);
  }

  static Future<String> loadResult() async {
    var resultAsset = AssetImage(AssetsPath.RESULT_OBJECT,
    package: 'fp_business_onboadring_package');
    return await rootBundle.loadString(resultAsset.keyName);
  }
  static Future<String> loadBanks() async {
    var bankAsset = AssetImage(AssetsPath.BANKS,
    package: 'fp_business_onboadring_package');
    return await rootBundle.loadString(bankAsset.keyName);
  }
}