class SignInRequestApiModel {
  String? fullName;
  String? username;
  String? password;
  String? email;
  String? city;
  String? district;
  String? ward;
  String? address;
  String? avatar;

  SignInRequestApiModel({
    this.fullName,
    this.username,
    this.password,
    this.email,
    this.city,
    this.district,
    this.ward,
    this.address,
    this.avatar
    });

  Map<String, dynamic> toJson() => {
    "email": email,
    "username": username,
    "password": password,
    "fullname": fullName,
    "address": address,
    "city": city,
    "district": district,
    "ward": ward,
    "avatar": avatar,
  };

}