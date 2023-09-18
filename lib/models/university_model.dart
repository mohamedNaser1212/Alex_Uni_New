class UniversityModel{

  String? id;
  String? name;
  String? image;
  String? description;

  UniversityModel({
    this.id,
    this.name,
    this.image,
    this.description,
  });

  UniversityModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    image=json['Image'];
    description=json['description'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'Image':image,
      'description':description,
    };
  }
}