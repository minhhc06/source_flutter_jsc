import 'package:project_flutter/pages/home_page/model/products_home_model.dart';

class OrderListingModel{
  late int? id;
  late int? quantity;
  late ProductHomeModel? product;
  late bool? isSelected;


  OrderListingModel({this.id, this.product, this.quantity, this.isSelected});

  factory OrderListingModel.fromJson(dynamic json) {
    return OrderListingModel(
      id: json['id'] ?? -1,
      quantity: json['quantity'] ?? -1,
        product: ProductHomeModel.fromJson(json['product'] ?? {}),
      isSelected: false
    );
  }


}