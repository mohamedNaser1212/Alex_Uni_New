class UniversityModel{

  String? id;
  String? name;
  String? arabicName;
  String? image;

  UniversityModel({
    this.id,
    this.name,
    this.arabicName,
    this.image,
  });

  UniversityModel.fromJson(Map<String,dynamic>? json){
    name=json!['name'];
    arabicName=json['arabicName'];
    image=json['image'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'arabicName':arabicName,
      'image':image,
    };
  }
}

