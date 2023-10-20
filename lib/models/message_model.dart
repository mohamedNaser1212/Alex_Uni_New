class ListMessageModel{
  List<MessageModel> messages=[];

  ListMessageModel({
    required this.messages,
  });

  ListMessageModel.fromJson(Map<String,dynamic>json){
    messages = List.from(json['messages']).map((e) => MessageModel.fromJson(e)).toList();

  }

  Map<String,dynamic>toMap(){
    return {
      'messages':messages.map((e) => e.toMap()).toList(),
    };

  }

}


class MessageModel{
  String ?message;
  String ?dateTime;
  String ?image;
  String ?receiverId;
  String ?senderId;

  MessageModel({
    required this.message,
    required this.dateTime,
    required this.image,
    required this.receiverId,
    required this.senderId,
  });

  MessageModel.fromJson(Map<String,dynamic>json){
    message=json['message'];
    dateTime=json['dateTime'];
    image=json['image'];
    receiverId=json['receiverId'];
    senderId=json['senderId'];
  }

  Map<String,dynamic>toMap(){
    return {
      'message':message,
      'dateTime':dateTime,
      'image':image,
      'receiverId':receiverId,
      'senderId':senderId,
    };
  }
}