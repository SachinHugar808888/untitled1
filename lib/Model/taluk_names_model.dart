class TalukInfo {
  final String talukId;
  final String talukName;

  TalukInfo({required this.talukId, required this.talukName});

  factory TalukInfo.fromJson(Map<String, dynamic> json) {
    return TalukInfo(
      talukId: json['talukid'],
      talukName: json['talukname'],
    );
  }
}
