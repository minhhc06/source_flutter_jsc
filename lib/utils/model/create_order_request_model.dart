import 'package:project_flutter/utils/model/order_items_model.dart';

class CreateOrderRequestModel{
  late int? total;
  late String? delivery_date;
  late String? note;
  late String? phone_number;
  late String? name_receiver;
  late String? city;
  late String? district;
  late String? ward;
  late String? address;
  late String? statusName;
  late List<OrderItemsModel>? orderItems;

  CreateOrderRequestModel({
      this.total,
      this.delivery_date,
      this.note,
      this.phone_number,
      this.name_receiver,
      this.city,
      this.district,
      this.ward,
      this.address,
      this.statusName,
      this.orderItems});

  Map<String, dynamic> toJson() => {
    "total": total,
    "delivery_date": delivery_date,
    "note": note,
    "phone_number": phone_number,
    "name_receiver": name_receiver,
    "city": city,
    "district": district,
    "ward": ward,
    "address": address,
    "statusName": statusName,
    "orderItems": orderItems!.toList(),
  };

}