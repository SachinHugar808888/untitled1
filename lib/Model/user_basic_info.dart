class UserBasicInfo {
  final String borrowerId;
  final String statusId;
  final double p2pDue;
  final String taluk;
  final String district;
  final String kycStatus;
  final String mmid;
  final String borrowerName;
  final String state;
  final List<String> occupations;

  UserBasicInfo({
    required this.borrowerId,
    required this.statusId,
    required this.p2pDue,
    required this.taluk,
    required this.district,
    required this.kycStatus,
    required this.mmid,
    required this.borrowerName,
    required this.state,
    required this.occupations,
  });

  factory UserBasicInfo.fromJson(Map<String, dynamic> json) {
    return UserBasicInfo(
      borrowerId: json['borrowerid'],
      statusId: json['statusid'],
      p2pDue: json['p2pdue'] != null ? double.tryParse(json['p2pdue'].toString()) ?? 0.0 : 0.0,
      taluk: json['taluk'],
      district: json['district'],
      kycStatus: json['kycstatus'],
      mmid: json['mmid'],
      borrowerName: json['borrowername'],
      state: json['state'],
      occupations: List<String>.from(json['occupations']),
    );
  }

}
