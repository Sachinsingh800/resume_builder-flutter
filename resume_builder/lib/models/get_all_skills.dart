class GetAllSkills {
  String? category;
  String? skillName;


  GetAllSkills(
      {
        this.category,
        this.skillName,
      });

  GetAllSkills.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    skillName = json['skillName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['skillName'] = this.skillName;
    return data;
  }
}
