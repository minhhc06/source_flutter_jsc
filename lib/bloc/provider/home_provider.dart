import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class HomeProvider extends BaseProvider{

  Future<BaseModelApi?> getUserApiProvider({
    required String url}) async {
    BaseModelApi? response = await fetchApiUtil(
      method: Method.get,
        nameApi: url
    );

    return response;
  }

  Future<BaseModelApi?> productsApiProvider({
    required String url,  Map<String, dynamic>? body}) async {
    BaseModelApi? response = await fetchApiUtil(
      method: Method.get,
        nameApi: url,
      body: body
    );

    return response;
  }
}