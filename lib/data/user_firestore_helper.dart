import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/auth_helper.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';

class UserFirestoreHelper{
  UserFirestoreHelper._();
  static UserFirestoreHelper firestoreHelper = UserFirestoreHelper._();

  //خاص بال User
  CollectionReference<Map<String, dynamic>> firestoreinstance = FirebaseFirestore.instance.collection("users");
  addUserToFirestore(AppUser appUser)async{
     await firestoreinstance.doc(appUser.id).set(appUser.toMap());
  }
  Future<AppUser> getUserFromFirestore(String id)async{
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestoreinstance.doc(id).get();
    Map<String, dynamic>? dataMap = documentSnapshot.data();
    return AppUser.fromeMap(dataMap!);

  }

  Future<List<AppUser>> getAllUser()async{
    QuerySnapshot<Map<String, dynamic>> documentSnapshots = await firestoreinstance.get();
    List<AppUser> users = documentSnapshots.docs.map((e) =>
        AppUser.fromeMap(e.data())).toList();
    users.removeWhere((element) => element.id == AuthHelper.authHelper.getCurrentUserId());
    return users;
  }
  Future<List> getAllUserFromFirestore2()async{
    QuerySnapshot<Map<String, dynamic>> documentSnapshots = await firestoreinstance.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = documentSnapshots.docs;
    List<Map<String, dynamic>> listData =  data.map((e) => e.data()).toList();

    Map<int,dynamic> mapuser = Map();

    for(int i = 0;i<listData.length;i++){
      mapuser[i] = {i, AppUser.fromeMap(listData[0])};
    }

    List users = mapuser.values.toList();
    return users;
  }

  upDateImage(AppUser appUser)async{
    await firestoreinstance.doc(appUser.id).update(appUser.toMap());
  }
  upDateUser(AppUser appUser)async{
    await firestoreinstance.doc(appUser.id).update(appUser.toMap());
  }








}