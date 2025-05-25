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

  PlayerModel(
      this.username,
      this.avatar,
      this.namecard,
      this.title,
      this.endorsement,
      this.competitive,
      this.lastUpdatedAt);

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      json['username'],
      json['avatar'],
      json['namecard'],
      json['title'],
      json['endorsement'],
      json['competitive'],
      json['last_updated_at']
    );
  }

}