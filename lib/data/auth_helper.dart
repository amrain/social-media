import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/view/screens/login_screen.dart';
import 'package:social_media/view/widgets/dialog.dart';


class AuthHelper {

  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;

    } on FirebaseAuthException catch (e) {
      Provider.of<AuthProvaider>(AppRouter.navKey.currentContext!,listen: false).dialogLoader.close();

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.showDialogfunction('The account already exists for that email.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }

  Future<UserCredential?>  signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      Provider.of<AuthProvaider>(AppRouter.navKey.currentContext!,listen: false).dialogLoader.close();
      if (e.code == 'user-not-found') {
        CustomDialog.showDialogfunction('No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.showDialogfunction('Wrong password provided for that user.');
        print('Wrong password provided for that user.');
      }
    }

  }

  Future<User?> checUser() async {
    User? user = await  firebaseAuth.currentUser;

    return user;
  }

  String? getCurrentUserId(){
    return firebaseAuth.currentUser?.uid;
  }

  signOut()async{
    await firebaseAuth.signOut();

  }

  forgetPassword(String email)async{
    try {
      await  firebaseAuth.sendPasswordResetEmail(email: email);
      Provider.of<AuthProvaider>(AppRouter.navKey.currentContext!,listen: false).dialogLoader.close();

      CustomDialog.showDialogfunction('تم ارسال رابط التأكد الى اميليك ');

    } on Exception catch (e) {
      // TODO
    }
  }

  verifyEmail(){
    User? user = firebaseAuth.currentUser;
    user!.sendEmailVerification();

  }


}