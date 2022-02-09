class RequestFetchOrderItem{
  late String? page;
  late String? limit;
  late String? status;

  RequestFetchOrderItem({ this.page,  this.limit, this.status});

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "status": status
  };
}