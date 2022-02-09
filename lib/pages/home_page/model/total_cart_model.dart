class TotalCartModel{
  late int? total;


  TotalCartModel({this.total});

  factory TotalCartModel.fromJson(dynamic json) {
    return TotalCartModel(
      total: json['count']
    );
  }

}