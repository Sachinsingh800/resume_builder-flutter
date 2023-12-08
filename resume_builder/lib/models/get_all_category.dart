class GetAllCategory {
  String? category;


  GetAllCategory(
      {
        this.category,
        });

  GetAllCategory.fromJson(Map<String, dynamic> json) {
    category = json['category'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    return data;
  }
}
