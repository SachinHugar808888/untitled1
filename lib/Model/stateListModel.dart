class StateInfo{
  final String statename;
  final String statecode;
  StateInfo(this.statename,this.statecode);
  factory StateInfo.fromJson(Map<String, dynamic> json) {
    return StateInfo(
      json['statename'],
      json['statecode'],
    );
  }
}