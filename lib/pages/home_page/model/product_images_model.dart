class ProductImagesModel{
  late String? url;

  ProductImagesModel({this.url});
  factory ProductImagesModel.fromJson(dynamic json) {
    return ProductImagesModel(
      url: json['url'] ?? 'https://lamontenprovence.com/thumbs_size/product/2020_07/[800x800-watermark]cherryblossom_3.jpg',
    );
  }

}