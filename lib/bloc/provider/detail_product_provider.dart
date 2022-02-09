import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class DetailProductProvider extends BaseProvider{
  Future<BaseModelApi?> fetchDetailProductApiProvider({
  required String nameApi,
  required int id,
  }) async {
    BaseModelApi? response = await fetchApiWithId(
        nameApi: nameApi, id: id
    );

    return response;

  }

  Future<BaseModelApi?> createCartApiProvider({
    required String nameApi,
    required Map<String, dynamic>? body,
  }) async {
    BaseModelApi? response = await fetchApiUtil(
        nameApi: nameApi, body: body
    );

    return response;

  }

}