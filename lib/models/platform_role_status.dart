import 'package:ow_battlelog/models/role_model.dart';

class PlatformRoleStatus {
  RoleModel? tank;
  RoleModel? damage;
  RoleModel? support;
  RoleModel? open;
  int? season;

  PlatformRoleStatus({this.tank, this.damage, this.support, this.open, this.season});

  PlatformRoleStatus.fromJson(Map<String, dynamic> json) {
    tank = json['tank'] != null ? RoleModel.fromJson(json['tank']) : null;
    damage = json['damage'] != null ? RoleModel.fromJson(json['damage']) : null;
    support =
        json['support'] != null ? RoleModel.fromJson(json['support']) : null;
    open = json['open'] != null ? RoleModel.fromJson(json['open']) : null;
    season = json['season'];
  }
}