import 'dart:developer';
import 'dart:io';

import 'package:dialog_loader/dialog_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/auth_helper.dart';
import 'package:social_media/data/post_helper.dart';
import 'package:social_media/data/storge_helper.dart';
import 'package:social_media/data/user_firestore_helper.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/chat_provider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/feed_screen.dart';
import 'package:social_media/view/screens/login_screen.dart';
import 'package:social_media/view/screens/nav_bar.dart';
import 'package:social_media/view/widgets/custom_dialog.dart';
import 'package:social_media/view/screens/inbox_screen.dart';


import 'package:string_validator/string_validator.dart';


class AuthProvaider extends ChangeNotifier{

  GlobalKey<FormState>? loginKey = GlobalKey();
  GlobalKey<FormState>? forgetPasswordkey = GlobalKey();

  bool isLoad = false;

  GlobalKey<FormState> registerKey = GlobalKey();
  AppUser? appUser;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  nullvaliation(String? v){
    if(v == null || v.isEmpty){
      return"هذ الحقل مطلوب";
    }
  }
  passwrdvaliation(String v){
    if(v.isEmpty){
      return"هذه الحقل مطلوب";
    }
    else if(v.length < 6){
      return"يجب ان تكون كلمة المرور مكونة من 6 احرف عل الأقل";
    }
  }
  emailvaliation(String v){
    if(v.isEmpty){
      return"هذه الحقل مطلوب";
    }
    else if(!isEmail(v)){
      return"صيغة ايميل خاطئة";
    }
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
  signIn()async{
    // isLoad = true;
    //
    //
    // notifyListeners();

    if(loginKey!.currentState!.validate()){
      _dialogLoader();

      UserCredential? userCredential =    await AuthHelper.authHelper.signIn(emailController.text, passwordController.text);
      if(userCredential != null){
        appUser = await UserFirestoreHelper.firestoreHelper.getUserFromFirestore(userCredential.user!.uid);
        Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).appUser = appUser;
        await Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).getAllPosts();
        await Provider.of<ApiProvider>(AppRouter.navKey.currentContext!,listen: false).getPosts();
        await Provider.of<ChatProvider>(AppRouter.navKey.currentContext!,listen: false).getAllUsers();
        dialogLoader.close();


        AppRouter.NavigateWithReplacemtnToWidget(InboxScreen());
      passwordController.clear();

      }
    }
    // isLoad = false;
    // notifyListeners();

  }

  register()async{
    // isLoad = true;
    // notifyListeners();

    if(registerKey.currentState!.validate()){
      _dialogLoader();

      UserCredential? userCredential = await AuthHelper.authHelper.signUp(emailController.text, passwordController.text);
    appUser = AppUser(email: emailController.text, userName: userNameController.text, phone: phoneController.text,city: cityController.text,id:userCredential!.user!.uid );
    await UserFirestoreHelper.firestoreHelper.addUserToFirestore(appUser!);
    Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).appUser = appUser;

    if(userCredential != null){
      await Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).getAllPosts();
      await Provider.of<ApiProvider>(AppRouter.navKey.currentContext!,listen: false).getPosts();
      await Provider.of<ChatProvider>(AppRouter.navKey.currentContext!,listen: false).getAllUsers();
      dialogLoader.close();

      AppRouter.NavigateWithReplacemtnToWidget(InboxScreen());

      passwordController.clear();
      cityController.clear();
      userNameController.clear();
      phoneController.clear();
    }
    }
    // isLoad = false;
    // notifyListeners();
  }
  checUser() async {
    User? user = await AuthHelper.authHelper.checUser();
     if(user == null){
       AppRouter.NavigateWithReplacemtnToWidget(LoginScreen());
     }else{
       appUser = await UserFirestoreHelper.firestoreHelper.getUserFromFirestore(user.uid);
       Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).appUser = appUser;

       AppRouter.NavigateWithReplacemtnToWidget(InboxScreen());
     }
  }
  signOut(){

    // loginKey = GlobalKey();
     AuthHelper.authHelper.signOut();
     AppRouter.NavigateWithReplacemtnToWidget(LoginScreen());
     controller.index = 0;
  }
  forgetPassword(){
    if(forgetPasswordkey!.currentState!.validate())
      _dialogLoader();
      AuthHelper.authHelper.forgetPassword(emailController.text);
  }
  File? selectedImage;
  Future<String> uploadImage(File file)async{
    log('url');

    String url = await StorgeHelper.storgeHelper.uplodImage(file);
    log(url);
    return url;
  }
  selecteImageFun()async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(xfile != null)
    selectedImage= File(xfile.path);
    notifyListeners();
  }
  upDateImage()async{

    if(selectedImage != null){
      _dialogLoader();
      appUser!.image = await uploadImage(selectedImage!);
      await UserFirestoreHelper.firestoreHelper.upDateImage(appUser!);
      Owner owner = Owner(id: appUser!.id,firstName: appUser!.userName.split(" ")[0],lastName: appUser!.userName.split(" ")[1],picture: appUser!.image);
      Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).updateImagePost(owner);

      dialogLoader.close();
      notifyListeners();
    }

  }
  upDateUser()async{
    _dialogLoader();
    appUser?.email = emailController.text;
    appUser?.phone = phoneController.text;
    appUser?.userName = userNameController.text;
    appUser?.city = cityController.text;
    await UserFirestoreHelper.firestoreHelper.upDateUser(appUser!);
    dialogLoader.close();
    notifyListeners();
  }





}