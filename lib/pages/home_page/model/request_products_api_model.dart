class RequestProductsApiModel{
  late String page;
  late String limit;

  RequestProductsApiModel({required this.page, required this.limit});

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit
  };
}