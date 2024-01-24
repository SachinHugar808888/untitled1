class DistrictInfo {
  final String districtId;
  final String districtName;

  DistrictInfo({
    required this.districtId,
    required this.districtName,
  });

  factory DistrictInfo.fromJson(Map<String, dynamic> json) {
    return DistrictInfo(
      districtId: json['distid'] ?? "",
      districtName: json['distname'] ?? "",
    );
  }
}
