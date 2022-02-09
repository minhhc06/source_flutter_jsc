class ProvinceModel{
  late final String name;
  late  int code;
  late final String division_type;
  late final String codename;
  late final int province_code;
  late final int district_code;

  ProvinceModel({required this.name, required this.code, required this.division_type, required this.codename,
    required this.province_code, required this.district_code});

  factory ProvinceModel.fromJson(dynamic json) {
    return ProvinceModel(
      name: json['name'] ?? '',
      code: json["code"] ?? -1,
      division_type: json['division_type'] ?? '',
      codename: json['codename'] ?? '',
      province_code: json['province_code'] ?? -1,
      district_code: json['district_code'] ?? -1,

    );

  }

  @override
  String toString() {
    return '$name';
  }

}



