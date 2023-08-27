class UserModel {
  String? uId;
  String? name;
  String? email;
  String? image;
  String? cover;
  String? bio;
  String? phone;

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.image,
    this.cover,
    this.bio,
    this.phone,
  });

  UserModel.fromJson(Map<String,dynamic>? json){
    email=json!['email'];
    image=json['image'];
    cover=json['cover'];
    name=json['name'];
    uId=json['uId'];
    bio=json['bio'];
    phone=json['phone'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'image':image,
      'cover':cover,
      'uId':uId,
      'bio':bio,
      'phone':phone,
    };
  }
}
