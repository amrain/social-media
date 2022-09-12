import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/auth_helper.dart';
import 'package:social_media/model/post_model.dart';

class PostHelper{
  PostHelper();
  static PostHelper postHelper = PostHelper();

  CollectionReference<Map<String, dynamic>> postCollection = FirebaseFirestore.instance.collection("posts");

  Future<DataPost> addNewPost(DataPost dataPost) async {
    DocumentReference<Map<String, dynamic>> referense =await  postCollection.add(dataPost.toJson());
    dataPost.id = referense.id;
    return dataPost;
  }


   getAllPosts()async{
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await postCollection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documints = querySnapshot.docs;
    List<DataPost> posts = documints.map((e) {

      DataPost dataPost = DataPost.fromJson(e.data());
      dataPost.id = e.id;
      // log(e.data().toString());
      return dataPost;
    } ).toList();
    // print(posts[0].toJson());
    return posts;

  }
   deletPost(String idPost){
    postCollection.doc(idPost).delete();
  }

  updateImagePost(Owner owner)async{
    // postCollection
    //     .where('answer', isEqualTo : 'value')
    //   .then((value) => value.docs.forEach((doc) {
    //     doc.reference.update({'answer': ''});
    //   }));
    // var collection = FirebaseFirestore.instance.collection('collection');
    // QuerySnapshot<Map<String, dynamic>> querySnapshots = await postCollection.get();
    // for (var doc in querySnapshots.docs) {
    //   await doc.reference.update({
    //     'single_field': 'newValue',
    //   });
    // }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await postCollection.get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documints = querySnapshot.docs;
    List<DataPost> posts = documints.map((e) {

      DataPost dataPost = DataPost.fromJson(e.data());
      dataPost.id = e.id;
      return dataPost;
    } ).toList();
    posts.removeWhere((element) => element.owner!.id != AuthHelper.authHelper.getCurrentUserId());
    print(posts);
    posts.forEach((element) {
      postCollection.doc(element.id).update(
        {
          "owner":owner.toJson()
        }
      );
    }
    );


  }


// Future<DataPost> addNewPost(DataPost dataPost)async{
  //   DocumentReference<Map<String, dynamic>> documentReference = await socialCollection
  //       .doc(dataPost.userId)
  //       .collection("posts")
  //       .add(dataPost.toMap());
  //   dataPost.id = documentReference.id;
  //   return dataPost;
  // }
  //
  // Future<List<DataPost>>getAllPost(String userId)async{
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot = await socialCollection
  //       .doc(userId)
  //       .collection("posts")
  //       .get();
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> queryDocumentSnapshot=querySnapshot.docs;
  //   List<DataPost> posts = queryDocumentSnapshot.map((e) {
  //     DataPost postModel = DataPost.fromeMap(e.data());
  //     postModel.id = e.id;
  //     return postModel;
  //   } ).toList();
  //   return posts;
  // }
  //
  // updatePost(DataPost postModel)async{
  //   socialCollection
  //       .doc(postModel.userId)
  //       .collection("posts")
  //       .doc(postModel.id)
  //       .update(postModel.toMap());
  // }
  //
  // deletPost(DataPost postModel)async{
  //   await socialCollection
  //       .doc(postModel.userId)
  //       .collection("posts")
  //       .doc(postModel.id)
  //       .delete();
  //   // await deletProduct1(productModel);
  // }
  //
  //
  //



}