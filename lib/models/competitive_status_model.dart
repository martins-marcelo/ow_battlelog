import 'package:ow_battlenet/models/platform_role_status.dart';

class CompetitiveStatusModel {
  PlatformRoleStatus? pc;
  PlatformRoleStatus? console;

  CompetitiveStatusModel({this.pc, this.console});

  CompetitiveStatusModel.fromJson(Map<String, dynamic> json) {
    pc = json['pc'] != null ? PlatformRoleStatus.fromJson(json['pc']) : null;
    console = json['console'] != null ? PlatformRoleStatus.fromJson(json['console']) : null;
  }
}