class OrderModel{
  late int? id;
  late String? name_receiver;
  late String? statusName;

  OrderModel({this.id, this.name_receiver, this.statusName});

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_receiver": name_receiver,
    "statusName": statusName,
  };

  factory OrderModel.fromJson(dynamic json) {
    return OrderModel(
      id: json['id'] ?? -1,
      name_receiver: json['name_receiver'] ?? '',
      statusName: json['statusName'] ?? '',

    );
  }

}