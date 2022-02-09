import 'package:project_flutter/utils/model/pagination_model.dart';

class ProductRequestModel{
  String? searchString;
  int? categoryId;
  String? page;
  String? limit;

  ProductRequestModel({this.searchString, this.categoryId, this.page, this.limit});

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "searchString": searchString,
    "categoryId": categoryId,
  };


}