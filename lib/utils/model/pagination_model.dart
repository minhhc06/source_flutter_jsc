class PaginationModel{
  String? page;
  String? limit;


  PaginationModel({this.page, this.limit});

  Map<String, dynamic> toJsonPagination() => {
    "page": page,
    "limit": limit
  };

}