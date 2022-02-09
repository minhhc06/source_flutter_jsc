class ProductImages{
  int? id;
  String? url;

  ProductImages({this.id, this.url});

  factory ProductImages.fromJson(dynamic json) {
    return ProductImages(
        id: json['id'] ?? -1,
        url: json['url'] ?? ''
    );
    }

}