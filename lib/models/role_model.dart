class RoleModel {
  final String division;
  final int tier;
  final String roleIcon;
  final String rankIcon;
  final String tierIcon;

  RoleModel({
    required this.division,
    required this.tier,
    required this.roleIcon,
    required this.rankIcon,
    required this.tierIcon,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      division: json['division'] ?? '',
      tier: json['tier'] ?? 0,
      roleIcon: json['role_icon'] ?? '',
      rankIcon: json['rank_icon'] ?? '',
      tierIcon: json['tier_icon'] ?? '',
    );
  }
}