class OrderItemsModel{
  late int? productId;
  late int? quantity;
  late int? total;
  late String? urlImage ;
  late String? title ;

  OrderItemsModel({this.productId, this.quantity, this.total, this.urlImage, this.title});

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "quantity": quantity,
    "total": total,

  };

}