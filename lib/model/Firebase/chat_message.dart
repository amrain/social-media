import 'package:social_media/data/auth_helper.dart';

class ChatMessage{
  String? content;
  String? senderId;
  String? time;
late   bool isFromMe;


  ChatMessage({required this.content,required this.senderId,required this.time});
  ChatMessage.fromeMap(Map<String,dynamic> map){
    content = map ['content'];
    senderId = map ['senderId'];
    time = map ['time'];
    isFromMe = map ['senderId'] == AuthHelper.authHelper.getCurrentUserId()?true:false;
  }
   Map<String,dynamic>toMap(){
     return {
       "content":content,
       "senderId":senderId,
       "time":time,

     };
   }

}