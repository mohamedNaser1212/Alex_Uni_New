class BothNewsModel{

  String? title;
  String? arabicTitle;
  String? type;
  String? date;
  List<String?>? images= [];
  List<String?>? descriptions= [];
  List<String?>? arabicDescriptions= [];

  BothNewsModel({
    this.title,
    this.arabicTitle,
    this.type,
    this.date,
    this.images= const [],
    this.descriptions = const [],
    this.arabicDescriptions= const [],
  });

  BothNewsModel.fromJson(Map<String,dynamic>?json){
    title=json!['title']??'';
    arabicTitle=json['arabicTitle']??'';
    type=json['type']??'';
    date=json['date']??'';
    json['images'].forEach((element){
      images!.add(element.toString());
    });
    json['descriptions'].forEach((element){
      descriptions!.add(element.toString());
    });
    json['arabicDescriptions'].forEach((element){
      arabicDescriptions!.add(element.toString());
    });
  }

  Map<String,dynamic>toMap(){
    return {
      'title':title,
      'arabicTitle':arabicTitle,
      'type':type,
      'date':date,
      'images':images!.map((element) => element).toList(),
      'descriptions':descriptions!.map((element) => element).toList(),
      'arabicDescriptions':arabicDescriptions!.map((element) => element).toList(),
    };
  }
}