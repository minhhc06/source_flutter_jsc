import 'package:project_flutter/pages/history_order_page/model/order_model.dart';
import 'package:project_flutter/pages/home_page/model/products_home_model.dart';

class HistoryOrderModel{
  late int? id;
  late int? quantity;
  late int? total;
  late String? statusName;
  late String? created_at;
  late OrderModel? order;
  late ProductHomeModel? product;


  HistoryOrderModel(
  {this.id, this.quantity, this.total, this.order, this.product, this.statusName ,this.created_at});

  factory HistoryOrderModel.fromJson(dynamic json) {
    return HistoryOrderModel(
      id: json['id'] ?? -1,
      quantity: json['quantity'] ?? -1,
      total: json['total'] ?? -1,
      statusName: json['statusName'] ?? '',
      created_at: json['created_at'] ?? -1,
      order: OrderModel.fromJson(json['order']),
      product: ProductHomeModel.fromJson(json['product']),

    );
  }


}