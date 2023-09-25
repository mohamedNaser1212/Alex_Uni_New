import 'package:alex_uni_new/models/post_model.dart';

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

  List<SavePostsModel>?savedPosts;
  List<SharePostModel>? sharePosts;

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
    required this.savedPosts,
    required this.sharePosts,
  });

  UserModel.fromJson(Map<String,dynamic>? json){
    email=json!['email'];
    image=json['image'];
    cover=json['cover'];
    name=json['name'];
    uId=json['uId'];
    bio=json['bio'];
    phone=json['phone'];
    country=json['country'];
    universityname=json['universityname'];
    underGraduate=json['underGraduate'];
    postGraduate=json['postGraduate'];

    address=json['address'];
    passportId=json['passportId'];
    savedPosts = List.from(json['savedPosts']).map((e) => SavePostsModel.fromJson(e)).toList();
    sharePosts = List.from(json['sharePosts']).map((e) => SharePostModel.fromJson(e)).toList();
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
      'country':country,
      'universityname':universityname,
      'underGraduate':underGraduate,
      'postGraduate':postGraduate,

      'address':address,
      'passportId':passportId,
      'savedPosts': savedPosts!.map((e) => e.toMap()).toList(),
      'sharePosts': sharePosts!.map((e) => e.toMap()).toList(),
    };
  }
}

class SavePostsModel{
  String? postId;
  String ? text;
  String? date;
  String? userName;
  String? userImage;
  String? userId;
  List<String>?likes;
  List<CommentDataModel>?comments;
  List<String> ?image;
  SavePostsModel({
    required this.postId,
    required this.text,
    required this.date,
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.image,
  });
  SavePostsModel.fromJson(Map<String,dynamic>? json){
    postId=json!['postId'];
    text=json['text']??'';
    date=json['date']??'';
    userName=json['userName']??'';
    userImage=json['userImage']??'';
    userId=json['userId']??'';
    likes=List.from(json['likes']).map((e) => e.toString()).toList();
    comments = List.from(json['comments']).map((e) => CommentDataModel.fromJson(e)).toList();
    image=List.from(json['image']).map((e) => e.toString()).toList();
  }
  Map<String,dynamic> toMap(){
    return {
      'postId':postId,
      'text':text,
      'date':date,
      'userName':userName,
      'userImage':userImage,
      'userId':userId,
      'likes':likes!.map((element) => element).toList(),
      'comments': comments!.map((element) => element.toJson()).toList(),
      'image':image!.map((element) => element).toList(),
    };
  }
}
class SharePostModel{
  String? postId;
  String ? text;
  String? date;
  String? userName;
  String? userImage;
  String? userId;
  List<String>?likes;
  List<CommentDataModel>?comments;
  List<String> ?image;
  SharePostModel({
    required this.postId,
    required this.text,
    required this.date,
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.image,
  });
  SharePostModel.fromJson(Map<String,dynamic>? json){
    postId=json!['postId'];
    text=json['text']??'';
    date=json['date']??'';
    userName=json['userName']??'';
    userImage=json['userImage']??'';
    userId=json['userId']??'';
    likes=List.from(json['likes']).map((e) => e.toString()).toList();
    comments = List.from(json['comments']).map((e) => CommentDataModel.fromJson(e)).toList();
    image=List.from(json['image']).map((e) => e.toString()).toList();
  }
  Map<String,dynamic> toMap(){
    return {
      'postId':postId,
      'text':text,
      'date':date,
      'userName':userName,
      'userImage':userImage,
      'userId':userId,
      'likes':likes!.map((element) => element).toList(),
      'comments': comments!.map((element) => element.toJson()).toList(),
      'image':image!.map((element) => element).toList(),
    };
  }
}
