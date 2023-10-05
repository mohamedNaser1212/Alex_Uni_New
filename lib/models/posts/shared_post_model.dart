import 'package:alex_uni_new/models/posts/post_model.dart';
import 'package:intl/intl.dart';

class SharePostModel{

  PostModel? postModel;
  String? postId;
  String? shareUserId;
  String? shareUserName;
  String? shareUserImage;
  String? sharePostText;
  DateTime? sharePostDate;
  String? formattedSharePostDate;
  bool isShared=true;
  List<String> likes=[];


  SharePostModel({
    this.postId,
    required this.postModel,
    required this.shareUserId,
    required this.shareUserName,
    required this.shareUserImage,
    required this.sharePostText,
    this.likes=const [],
  }){
    sharePostDate=DateTime.now();
    formattedSharePostDate=DateFormat('yyyy-MM-dd hh:mm a').format(sharePostDate!);
  }

  SharePostModel.fromJson(Map<String,dynamic>? json){
    postModel=PostModel.fromJson(json!);
    shareUserId=json['userId'];
    shareUserName=json['shareUserName'];
    shareUserImage=json['shareUserImage'];
    sharePostText=json['sharePostText'];
    formattedSharePostDate=json['date'];
    isShared=json['isShared'];
    likes=List.from(json['likes']).map((e) => e.toString()).toList();
  }

  Map<String,dynamic> toMap(){
    return {
      ...postModel!.toMap(),
      'ownerId':postModel!.userId,
      'mainPostLikes':postModel!.likes!.map((e) => e).toList(),
      'mainPostDate':postModel!.date,
      'shareUserName':shareUserName,
      'shareUserImage':shareUserImage,
      'sharePostText':sharePostText,
      'date':formattedSharePostDate,
      'isShared':isShared,
      'userId':shareUserId,
      'likes':likes.map((e) => e).toList(),
    };
  }
}