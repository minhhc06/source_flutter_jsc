import 'package:flutter/material.dart';
import 'package:project_flutter/utils/base_bloc.dart';
import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class HistoryOrderProvider extends BaseProvider{
  Future<BaseModelApi?> fetchListApiProvider({
    required String nameApi,
    required Map<String, dynamic>? body,
  }) async {
    BaseModelApi? response = await fetchApiUtil(
        nameApi: nameApi, body: body, method: Method.get
    );

    return response;

  }
}