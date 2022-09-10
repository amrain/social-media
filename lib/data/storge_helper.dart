import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorgeHelper{
  static StorgeHelper storgeHelper = StorgeHelper();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

 Future<String> uplodImage(File file)async{
    String fileName = file.path.split("/").last;
    Reference reference = await firebaseStorage.ref(fileName);
    await reference.putFile(file);
    String urlImage = await  reference.getDownloadURL();
    return urlImage;
  }



}