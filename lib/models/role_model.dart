class RoleModel {
  final String division;
  final int tier;
  final String roleIcon;
  final String rankIcon;
  final String tierIcon;

  RoleModel(this.division, this.tier, this.roleIcon, this.rankIcon, this.tierIcon);

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(json["divison"],
    json["tier"],
    json["role_icon"],
    json["rank_icon"],
    json["tier_icon"]);
  }
}