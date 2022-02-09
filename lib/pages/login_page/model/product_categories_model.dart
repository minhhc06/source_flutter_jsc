class ProductCategories{
  late int? id;
  late String? name;

  ProductCategories({this.id, this.name});

  factory ProductCategories.fromJson(dynamic json) {
    return ProductCategories(
        id: json['id'] ?? -1,
        name: json['name'] ?? ''

    );
  }
}