class PostModel{
  String ? text;
  String? date;
  String? userName;
  String? userImage;
  String? userId;
  List<String>?likes;
  List<CommentDataModel>?comments;
  List<String> ?image;
  bool? showPost=false;
  bool isReviewed=false;

  PostModel({
    required this.text,
    required this.date,
    required this.userName,
    required this.userImage,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.image,
    this.showPost,
});

  PostModel.fromJson(Map<String,dynamic>json){
    text=json['text']??'';
    date=json['date']??'';
    userName=json['userName']??'';
    userImage=json['userImage']??'';
    userId=json['userId']??'';
    likes=List.from(json['likes']).map((e) => e.toString()).toList();
    comments = List.from(json['comments']).map((e) => CommentDataModel.fromJson(e)).toList();
    image=List.from(json['image']).map((e) => e.toString()).toList();
    showPost=json['showPost'];
  }

  Map<String,dynamic>toMap(){
    return {
      'text':text,
      'date':date,
      'userName':userName,
      'userImage':userImage,
      'userId':userId,
      'likes':likes!.map((element) => element).toList(),
      'comments': comments!.map((element) => element.toJson()).toList(),
      'image':image!.map((element) => element).toList(),
      'showPost':showPost,
      'isReviewed':isReviewed,
    };
  }
}

class CommentDataModel {
  CommentDataModel({
    required this.text,
    required this.time,
    required this.ownerName,
    required this.ownerImage,
    required this.ownerId,
  });

  late final String text;
  late final String time;
  late final String ownerName;
  late final String ownerImage;
  late final String ownerId;

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