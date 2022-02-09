
import 'package:project_flutter/pages/login_page/model/product_categories_model.dart';
import 'package:project_flutter/pages/login_page/model/user_model.dart';

class GetUserResponseApiModel{
  UserModel userInfo;
  int? totalCarts;


  GetUserResponseApiModel({
    required this.userInfo,
    this.totalCarts
      });

  factory GetUserResponseApiModel.fromJson(dynamic json) {
    return GetUserResponseApiModel(
      userInfo: UserModel.fromJson(json['userInfo'] ?? {}),
      // productCategories:(json['productCategories'] as List<dynamic>)
      //     .map((e) => ProductCategories.fromJson(e)).toList(),
          totalCarts: json['totalCarts'] ?? 0

    );
  }

}