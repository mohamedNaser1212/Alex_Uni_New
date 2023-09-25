class NewsModel{

  String? title;
  String? headline;
  String? headlineImage;
  List<String?> sectionTitles= [];
  List<String?> images= [];
  List<String?> imageDescription= [];
  List<String?> descriptions= [];

  NewsModel({
    this.title,
    this.headline,
    this.headlineImage,
    this.sectionTitles= const [],
    this.images= const [],
    this.imageDescription= const [],
    this.descriptions= const [],
  });

  NewsModel.fromJson(Map<String, dynamic>? json){
    title = json!['title'];
    headline = json['headline'];
    headlineImage = json['headlineImage'];
    json['sectionTitles'].forEach((element){
      sectionTitles.add(element);
    });
    json['images'].forEach((element){
      images.add(element);
    });
    json['imageDescription'].forEach((element){
      imageDescription.add(element);
    });
    json['descriptions'].forEach((element){
      descriptions.add(element);
    });
  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'headline': headline,
      'headlineImage': headlineImage,
      'sectionTitles': sectionTitles,
      'images': images,
      'imageDescription': imageDescription,
      'descriptions': descriptions,
    };
  }
}