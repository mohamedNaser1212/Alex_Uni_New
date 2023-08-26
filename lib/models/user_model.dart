class UserModel {
  String? uId;
  String? name;
  String? email;
  String? profileImage; // Add the profileImage field

  UserModel({
    this.uId,
    this.name,
    this.email,
    this.profileImage,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    name = json['name'];
    uId = json['uId'];
    profileImage = json['profileImage']; // Deserialize profileImage
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'profileImage': profileImage, // Serialize profileImage
    };
  }
}
