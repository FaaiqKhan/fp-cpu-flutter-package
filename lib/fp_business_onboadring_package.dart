library fp_business_onboadring_package;

import 'dart:convert';

import 'package:fp_business_onboadring_package/Result.dart';
import 'Utils.dart';

Future<Result> loadResultAssets() async {
  String jsonResponse = await Utilities.loadResult();
  return Result.fromJson(jsonDecode(jsonResponse));
}
