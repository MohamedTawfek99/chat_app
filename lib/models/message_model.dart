class MessageModel{
  String? message;
  MessageModel.fromJson(json){
    message=json['message'];

}


}