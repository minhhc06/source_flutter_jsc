class LoginRequestApiModel{
  String username;
  String password;

  LoginRequestApiModel({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password
  };

}