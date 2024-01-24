class MedicalRecordsModel {
  List<Taluk> talukList; // Assuming there is a Taluk class

  MedicalRecordsModel({required this.talukList});

  factory MedicalRecordsModel.fromJson(Map<String, dynamic> json) {
    List<Taluk> taluks = List<Taluk>.from(
        json['msgdata']['taluklist'].map((talukJson) => Taluk.fromJson(talukJson)));

    return MedicalRecordsModel(talukList: taluks);
  }
}

class Taluk {
  String talukId;
  String talukName;

  Taluk({required this.talukId, required this.talukName});

  factory Taluk.fromJson(Map<String, dynamic> json) {
    return Taluk(
      talukId: json['talukid'],
      talukName: json['talukname'],
    );
  }
}
