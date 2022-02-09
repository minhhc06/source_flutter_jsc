import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class InformationUserOrderProvider extends BaseProvider{
  Future<BaseModelApi?> requestAddressApiProvider({
    required BuildContext context, required String url}) async {
    BaseModelApi? response = await fetchApiAddressUtil(
      url: url,
    );

    return response;
  }
}