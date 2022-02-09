import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class LoginProvider extends BaseProvider{
  Future<BaseModelApi?> loginApiProvider({
    required String url, required Map<String, dynamic>? body}) async {
    BaseModelApi? response = await fetchApiUtil(
        nameApi: url,
        body: body
    );

    return response;
  }

  Future<BaseModelApi?> getUserApiProvider({
    required String url}) async {
    BaseModelApi? response = await fetchApiUtil(
        nameApi: url,
      method: Method.get
    );

    return response;
  }
}