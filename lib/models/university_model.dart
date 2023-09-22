class UniversityModel{

  String? id;
  String? name;
  String? image;

  UniversityModel({
    this.id,
    this.name,
    this.image,
  });

  UniversityModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'image':image,
    };
  }
}

