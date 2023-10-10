class BothNewsModel{

  String? title;
  String? type;
  String? date;
  List<String?>? images= [];
  List<String?>? descriptions= [];

  BothNewsModel({
    this.title,
    this.type,
    this.date,
    this.images= const [],
    this.descriptions = const [],
  });

  BothNewsModel.fromJson(Map<String,dynamic>?json){
    title=json!['title']??'';
    type=json['type']??'';
    date=json['date']??'';
    json['images'].forEach((element){
      images!.add(element.toString());
    });
    json['descriptions'].forEach((element){
      descriptions!.add(element.toString());
    });
  }

  Map<String,dynamic>toMap(){
    return {
      'title':title,
      'type':type,
      'date':date,
      'images':images!.map((element) => element).toList(),
      'descriptions':descriptions!.map((element) => element).toList(),
    };
  }
}