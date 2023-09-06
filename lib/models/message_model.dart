class MessageModel{
  String?image;
  String? dateTime;
  String?receiverId;
  String?senderId;
  String?message;

  MessageModel({
    required this.image,
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
    required this.message,
  });

  MessageModel.fromJson(Map<String,dynamic>json){
    image=json['image'];
    dateTime=json['dateTime'];
    receiverId=json['receiverId'];
    senderId=json['senderId'];
    message=json['message'];
  }

  Map<String,dynamic>toMap(){
    return{
      'image':image,
      'dateTime':dateTime,
      'receiverId':receiverId,
      'senderId':senderId,
      'message':message,
    };
  }

}