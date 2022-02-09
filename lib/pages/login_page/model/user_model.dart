class UserModel{
  int? id;
  int? coin;
  String? fullname;
  String? username;
  String? email;
  String? city;
  String? district;
  String? ward;
  String? address;
  String? avatar;

  UserModel({this.id, this.coin, this.fullname, this.username, this.email,
      this.city, this.district, this.ward, this.address, this.avatar});

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json['id'] ?? -1,
      coin: json['coin'] ?? -1,
      fullname: json['fullname'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
      district: json['district'] ?? '',
      ward: json['ward'] ?? '',
      address: json['address'] ?? '',
      avatar: json['avatar'] ?? '',

    );
  }
}