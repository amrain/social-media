import 'package:social_media/data/auth_helper.dart';

class ChatMessage{
  String? content;
  String? imageurl;

  String? senderId;
  String? time;
  String? id;


  late   bool isFromMe;


  ChatMessage({ this.content,required this.senderId,required this.time,this.imageurl});
  ChatMessage.fromeMap(Map<String,dynamic> map){
    content = map ['content'];
    imageurl = map ['imageurl'];

    senderId = map ['senderId'];
    time = map ['time'];
    id = map ['id'];

    isFromMe = map ['senderId'] == AuthHelper.authHelper.getCurrentUserId()?true:false;
  }
   Map<String,dynamic>toMap(){
     return {
       "content":content,
       "senderId":senderId,
       "time":time,
       "imageurl":imageurl,


     };
   }

}