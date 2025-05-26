import 'package:ow_battlelog/models/role_model.dart';

class PlatformRoleStatus {
  final int season;
  final RoleModel tank;
  final RoleModel damage;
  final RoleModel support;
  final RoleModel open;

  PlatformRoleStatus({
    required this.season,
    required this.tank,
    required this.damage,
    required this.support,
    required this.open,
  });

  factory PlatformRoleStatus.empty() {
    return PlatformRoleStatus(
      season: 0,
      tank: RoleModel.empty(),
      damage: RoleModel.empty(),
      support: RoleModel.empty(),
      open: RoleModel.empty(),
    );
  }

  factory PlatformRoleStatus.fromJson(Map<String, dynamic> json) {
    return PlatformRoleStatus(
      season: json['season'] ?? 0,
      tank: RoleModel.fromJson(json['tank'] ?? {}),
      damage: RoleModel.fromJson(json['damage'] ?? {}),
      support: RoleModel.fromJson(json['support'] ?? {}),
      open: RoleModel.fromJson(json['open'] ?? {}),
    );
  }
}