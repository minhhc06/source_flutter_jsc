import 'package:project_flutter/utils/base_model_api.dart';
import 'package:project_flutter/utils/base_provider.dart';

class OrderListingProvider extends BaseProvider{
  Future<BaseModelApi?> fetchOrderListingApiProvider({
    required String url, required Map<String, dynamic>? body, String? method = Method.get}) async {
    BaseModelApi? response = await fetchApiUtil(
        nameApi: url,
        body: body,
      method: method!
    );

    return response;
  }
}