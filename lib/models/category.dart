class CategoryNewsModel {
  String image="";
  String title="";

  CategoryNewsModel({String image="", String title=""}) {
      this.image = image;
      this.title = title;
  }

  CategoryNewsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}