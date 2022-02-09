import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class SignUpProvider extends BaseProvider{
  Future<BaseModelApi?> signInApiProvider({
    required String url, required Map<String, dynamic>? body}) async {
    BaseModelApi? response = await fetchApiUtil(
      nameApi: url,
      body: body
    );

    return response;
  }
}