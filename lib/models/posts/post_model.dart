class PostModel{
  String ? postId;
  String ? text;
  String? date;
  String? userName;
  String? userImage;
  String? userId;
  List<String>?likes;
  List<String> ?image=[];
  bool? showPost=false;
  bool? isReviewed=false;
  bool isShared=false;

  PostModel({
    this.postId,
    required this.text,
    required this.date,
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.likes,
    required this.image,
    this.showPost,
    this.isReviewed,
});

  PostModel.fromJson(Map<String,dynamic>json){
    if(!json['isShared']){
      text=json['text']??'';
      date=json['date']??'';
      userName=json['userName']??'';
      userImage=json['userImage']??'';
      userId=json['userId']??'';
      likes=List.from(json['likes']).map((e) => e.toString()).toList();
      image=List.from(json['image']).map((e) => e.toString()).toList();
      showPost=json['showPost'];
      isReviewed=json['isReviewed'];
      isShared=json['isShared'];
    }
    else{
      postId=json['postId']??'';
      text=json['text']??'';
      date=json['mainPostDate']??'';
      userName=json['userName']??'';
      userImage=json['userImage']??'';
      userId=json['ownerId']??'';
      likes=List.from(json['mainPostLikes']).map((e) => e.toString()).toList();
      image=List.from(json['image']).map((e) => e.toString()).toList();
      showPost=json['showPost'];
      isReviewed=json['isReviewed'];
    }
  }

  Map<String,dynamic>toMap(){
    return {
      'postId':postId,
      'text':text,
      'date':date,
      'userName':userName,
      'userImage':userImage,
      'userId':userId,
      'likes':likes!.map((element) => element).toList(),
      'image':image!.map((element) => element).toList(),
      'showPost':showPost,
      'isReviewed':isReviewed,
      'isShared':isShared,
    };
  }
}

class CommentDataModel {


  String? id;
  late final String text;
  late final String time;
  late final String ownerName;
  late final String ownerImage;
  late final String ownerId;

  CommentDataModel({
    this.id,
    required this.text,
    required this.time,
    required this.ownerName,
    required this.ownerImage,
    required this.ownerId,
  });

  CommentDataModel.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    time = json['time'] ?? '';
    ownerName = json['ownerName'] ?? '';
    ownerImage = json['ownerImage'] ?? '';
    ownerId = json['ownerId'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'time': time,
      'ownerName': ownerName,
      'ownerImage': ownerImage,
      'ownerId': ownerId,
    };
  }
}