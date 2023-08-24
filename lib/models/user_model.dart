class UserModel {
  String? uId;
  String? name;
  String? email;

  UserModel({
    this.uId,
    this.name,
    this.email,
  });

  UserModel.fromJson(Map<String,dynamic>? json){
    email=json!['email'];
    name=json['name'];
    uId=json['uId'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'uId':uId,
    };
  }
}
