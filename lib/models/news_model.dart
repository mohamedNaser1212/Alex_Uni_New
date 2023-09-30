class NewsModel{

  String? title;
  List<String?> images= [];
  List<String?> descriptions= [];

  NewsModel({
    this.title,
    this.images= const [],
    this.descriptions= const [],
  });

  NewsModel.fromJson(Map<String, dynamic>? json){
    title = json!['title'];
    json['images'].forEach((element){
      images.add(element);
    });
    json['descriptions'].forEach((element){
      descriptions.add(element);
    });

  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'images': images,
      'descriptions': descriptions,

    };
  }
}