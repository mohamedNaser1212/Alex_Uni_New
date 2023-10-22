class UserModel {
  String? uId;
  String? name;
  String? email;
  String? image;
  String? cover;
  String? bio;
  String? universityname;
  String? phone;
  String? passportId;
  String? address;
  String? country;
  bool? underGraduate;
  bool? postGraduate;

  UserModel({
    required this.uId,
    required this.name,
    required this.email,
    required this.image,
    required this.cover,
    required this.bio,
    required this.phone,
    required this.country,
    required this.universityname,
    required this.underGraduate,
    required this.postGraduate,
    required this.address,
    required this.passportId,
  });

  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json!['email'];
    image = json['image'];
    cover = json['cover'];
    name = json['name'];
    uId = json['uId'];
    bio = json['bio'] ?? '';
    phone = json['phone'];
    country = json['country'];
    universityname = json['universityname'];
    underGraduate = json['underGraduate'];
    postGraduate = json['postGraduate'];
    address = json['address'];
    passportId = json['passportId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'cover': cover,
      'uId': uId,
      'bio': bio,
      'phone': phone,
      'country': country,
      'universityname': universityname,
      'underGraduate': underGraduate,
      'postGraduate': postGraduate,
      'address': address,
      'passportId': passportId,
    };
  }
}
