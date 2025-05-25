class Endorsement {
  int? level;
  String? frame;

  Endorsement({this.level, this.frame});

  Endorsement.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    frame = json['frame'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['frame'] = this.frame;
    return data;
  }
}