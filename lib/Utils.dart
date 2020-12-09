import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

class Utilities {
  static String getImageBase64(String image) {
    final bytes = File(image).readAsBytesSync();
    return base64Encode(bytes);
  }
  static Future<String> uploadImage(FileType type) async {
    return await FilePicker.getFilePath(type: type);
  }
}