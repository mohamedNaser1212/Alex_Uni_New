class NewsModel{

  String? title;
  String? mainDescription;
  String? headlineImage;


  List<String?> images= [];

  List<String?> descriptions= [];

  NewsModel({
    this.title,
    this.mainDescription,
    this.headlineImage,

    this.images= const [],


    this.descriptions= const [],
  });

  NewsModel.fromJson(Map<String, dynamic>? json){
    title = json!['title'];
    mainDescription = json['mainDescription'];
    headlineImage = json['headlineImage'];

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
      'headline': mainDescription,
      'headlineImage': headlineImage,

      'images': images,
      'descriptions': descriptions,

    };
  }
}