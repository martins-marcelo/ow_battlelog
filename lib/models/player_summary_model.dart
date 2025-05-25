import 'dart:typed_data';

class PlayerSummaryModel {
  final String playerId;
  final String name;
  Uint8List? avatar;
  Uint8List? namecard;
  String? title;
  final String careerUrl;
  final int lastUpdatedAt;

  PlayerSummaryModel({
      required this.playerId,
      required this.name,
      this.avatar,
      this.namecard,
      this.title,
      required this.careerUrl,
      required this.lastUpdatedAt});

  factory PlayerSummaryModel.fromJson(Map<String, dynamic> json) {
    return PlayerSummaryModel(
      playerId: json['player_id'],
      name: json['name'],
      avatar: json['avatar'],
      namecard: json['namecard'],
      title: json['title'],
      careerUrl: json['career_url'],
      lastUpdatedAt: json['last_updated_at']
    );
  }

}