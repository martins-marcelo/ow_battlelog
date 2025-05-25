import 'package:ow_battlelog/models/competitive_status_model.dart';
import 'package:ow_battlelog/models/endorsement.dart';

class PlayerModel {
  final String username;
  final String avatar;
  final String namecard;
  String? title;
  final int lastUpdatedAt;
  final Endorsement endorsement;
  final CompetitiveStatusModel competitive;

  PlayerModel({
      required this.username,
      required this.avatar,
      required this.namecard,
      this.title,
      required this.lastUpdatedAt,
      required this.endorsement,
      required this.competitive
      });

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      username: json['username'],
      avatar: json['avatar'],
      namecard: json['namecard'],
      title: json['title'],
      endorsement: Endorsement.fromJson(json['endorsement'] ?? {}),
      competitive: CompetitiveStatusModel.fromJson(json['competitive'] ?? {}),
      lastUpdatedAt: json['last_updated_at']
  );
  }

}