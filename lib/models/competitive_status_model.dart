import 'package:ow_battlelog/models/platform_role_status.dart';

class CompetitiveStatusModel {
  final  PlatformRoleStatus pc;
  final PlatformRoleStatus console;

  CompetitiveStatusModel({
    required this.pc,
    required this.console
  });

  factory CompetitiveStatusModel.fromJson(Map<String, dynamic> json) {
    return CompetitiveStatusModel(
      pc: PlatformRoleStatus.fromJson(json['pc'] ?? {}),
      console: PlatformRoleStatus.fromJson(json['console'] ?? {})
    );
  }
}