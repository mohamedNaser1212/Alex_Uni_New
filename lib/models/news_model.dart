class ArabicNewsModel{

  String? title;
  List<String?> images= [];
  List<String?> descriptions= [];
  String? date;
  String? type;

  ArabicNewsModel({
    this.title,
    this.images= const [],
    this.descriptions= const [],
    this.date,
    this.type,

  });

  ArabicNewsModel.fromJson(Map<String, dynamic>? json){
    title = json!['title'];
    json['images'].forEach((element){
      images.add(element);
    });
    json['descriptions'].forEach((element){
      descriptions.add(element);
    });
    date = json['date'];
    type = json['type'];

  }

  Map<String, dynamic> toMap(){
    return {
      'title': title,
      'images': images,
      'descriptions': descriptions,
      'date': date,
      'type': type,

    };
  }
}