class GetAllArea {
  String? category;
  String? interestName;


  GetAllArea(
      {
        this.category,
        this.interestName,
      });

  GetAllArea.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    interestName = json['interestName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['interestName'] = this.interestName;
    return data;
  }
}
