
import 'package:project_flutter/pages/home_page/model/product_images_model.dart';

class ProductHomeModel{
  final int id;
  final String name;
  final int price;
  final String discount;
  final List<ProductImagesModel> productImages;

  ProductHomeModel({required this.name, required this.price,required this.id,
    required this.discount, required this.productImages});

  factory ProductHomeModel.fromJson(dynamic json) {
    return ProductHomeModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      price: json['price'] ?? -1,
      discount: '',
      productImages:(json['productImages'] as List<dynamic>)
          .map((e) => ProductImagesModel.fromJson(e)).toList(),


    );
  }


}