library fp_business_onboadring_package;

import 'dart:convert';

import 'Constants.dart';
import 'ResultObject.dart';

Future<ResultObject> loadResultAssets() async {
  String jsonResponse = await RequiredAssets.loadResult();
  return ResultObject.fromJson(jsonDecode(jsonResponse));
}
