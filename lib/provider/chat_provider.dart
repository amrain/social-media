import 'dart:developer';
import 'dart:io';

import 'package:dialog_loader/dialog_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/data/auth_helper.dart';
import 'package:social_media/data/chat_helper.dart';
import 'package:social_media/data/storge_helper.dart';
import 'package:social_media/data/user_firestore_helper.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';
import 'package:social_media/model/Firebase/chat_message.dart';
import 'package:social_media/navigation/router.dart';

class ChatProvider extends ChangeNotifier{

  TextEditingController messagecontroller = TextEditingController();
  List<ChatMessage> messages = [];
  String? image;

  int num = 0;

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

  sendImage(String otherUserId)async{
    if(image != null){
      ChatMessage message = ChatMessage(
          imageurl: image,
          senderId: AuthHelper.authHelper.getCurrentUserId(),
          time: DateTime.now().toString()

      );
      ChatHelper.chatHelper.sendImage(message, otherUserId);
      selectedImage = null;
      image = null;
    }
  }



  deletMessage(String otherUserId,String idMesagge)async{
    await ChatHelper.chatHelper.deletMessage(otherUserId,idMesagge);
  }

  deletChate(String otherUserId)async{
    await ChatHelper.chatHelper.deletChate(otherUserId);
  }

  getAllMessageJust(String otherUserId)async{
    messages =  await ChatHelper.chatHelper.getAllMessagejust(otherUserId);


  }
  File? selectedImage;
  Future<String> uploadImage()async{
    _dialogLoader();
    if(selectedImage != null){
      String url = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
      image = url;
      log(url);
      dialogLoader.close();

      return url;

    }else {
      dialogLoader.close();
      return "";
    }

  }
  selecteImageFun()async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xfile != null)
      selectedImage= File(xfile.path);
    notifyListeners();
  }

  DialogLoader dialogLoader = DialogLoader(context: AppRouter.navKey.currentContext!);

  _dialogLoader() async {

    dialogLoader.show(
      theme: LoaderTheme.dialogCircle,
      title: Text("Loading"),
      leftIcon: SizedBox(
        child: CircularProgressIndicator(),
        height: 25.0,
        width: 25.0,
      ),
    );
  }

}