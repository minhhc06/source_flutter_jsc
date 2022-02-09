import 'package:project_flutter/utils/model/product_images_model.dart';

class DetailModel{
  int? id;
  String? name;
  int? price;
  String? about;
  String? brand;
  String? material;
  String? made_in;
  String? expiry;
  String? preserve;
  String? type_skin;
  List<ProductImages>? productImages;

  DetailModel({
      this.id,
      this.name,
      this.price,
      this.about,
      this.brand,
      this.material,
      this.made_in,
      this.expiry,
      this.preserve,
      this.type_skin,
      this.productImages});

  factory DetailModel.fromJson(dynamic json) {
    return DetailModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      price: json['price'] ?? -1,
      about: json['about'] ?? '',
      brand: json['brand'] ?? '',
      material: json['material'] ?? '',
      made_in: json['made_in'] ?? '',
      expiry: json['expiry'] ?? '',
      preserve: json['preserve'] ?? '',
      type_skin: json['type_skin'] ?? '',
      productImages:(json['productImages'] as List<dynamic>)
          .map((e) => ProductImages.fromJson(e)).toList(),
    );
  }
}