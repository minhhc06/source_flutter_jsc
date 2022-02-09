import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class ConfirmOrderProvider extends BaseProvider{
  Future<BaseModelApi?> apiProvider({
    required String nameApi,
     Map<String, dynamic>? body,
    method: Method.post
  }) async {
    BaseModelApi? response = await fetchApiUtil(
        nameApi: nameApi, body: body, method: method
    );

    return response;

  }
}