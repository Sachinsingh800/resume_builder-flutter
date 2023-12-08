class GetAllBio {
  String? category;
  String? summary;


  GetAllBio(
      {
        this.category,
        this.summary,
      });

  GetAllBio.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    summary = json['summary'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['summary'] = this.summary;
    return data;
  }
}
