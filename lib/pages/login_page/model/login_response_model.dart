class LoginResponseModel{
  String? accessToken;

  LoginResponseModel({this.accessToken});

  factory LoginResponseModel.fromJson(dynamic json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] ?? ''
    );
  }
}