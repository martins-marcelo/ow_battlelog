class Endorsement {
  int? level;
  String? frame;

  Endorsement({this.level, this.frame});

  factory Endorsement.empty() => Endorsement(level: 0, frame: '');

  factory Endorsement.fromJson(Map<String, dynamic> json) {
    return Endorsement(
      level: json['level'] ?? 0,
      frame: json['frame'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    data['frame'] = this.frame;
    return data;
  }
}