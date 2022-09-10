import 'package:flutter/cupertino.dart';
import 'package:social_media/data/auth_helper.dart';
import 'package:social_media/data/chat_helper.dart';
import 'package:social_media/data/user_firestore_helper.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';
import 'package:social_media/model/Firebase/chat_message.dart';

class ChatProvider extends ChangeNotifier{

  TextEditingController messagecontroller = TextEditingController();

  List<AppUser>? chatUsers;

  getAllUsers()async{
    chatUsers = await UserFirestoreHelper.firestoreHelper.getAllUser();
    print(chatUsers);
    notifyListeners();

  }

  sendMessage(String otherUserId)async{
    String contant = messagecontroller.text;
    if(contant.isNotEmpty){
      ChatMessage message = ChatMessage(
          content: contant,
          senderId: AuthHelper.authHelper.getCurrentUserId(),
          time: DateTime.now().toString()

      );
        ChatHelper.chatHelper.sendMessage(message, otherUserId);
      messagecontroller.clear();
    }
  }

  deletChat(String otherUserId)async{
    await ChatHelper.chatHelper.deletChat(otherUserId);
  }

}