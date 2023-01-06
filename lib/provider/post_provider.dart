
import 'dart:developer';
import 'dart:io';

import 'package:dialog_loader/dialog_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/auth_helper.dart';
import 'package:social_media/data/post_helper.dart';
import 'package:social_media/data/storge_helper.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';
import 'package:social_media/model/Firebase/chat_message.dart';
import 'package:social_media/model/comment_model.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/view/screens/nav_bar.dart';



class PostProvider extends ChangeNotifier{

  PostProvider(){
    getAllPosts();
  }
  init()async{

    await getAllPosts();

  }

  GlobalKey<FormState> postdKey = GlobalKey();
  GlobalKey<FormState> commentKey = GlobalKey();


  File? selectedImage;
  TextEditingController postDescriptionController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  List<DataPost> postsUser = [];
  List<DataPost> allPosts = [];
  List<DataComment>? comments;
  String? publishDate;
  Owner? owner;
  AppUser? appUser;




  nullvaliation(String? v){
    if(v == null || v.isEmpty){
      return"This field is required";
    }
  }

  selecteImageFun()async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage= File(xfile!.path);
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

  addNewPost(DataPost dataPost)async{
    String? imageUrl;
    if(selectedImage != null && postdKey.currentState!.validate()){
      _dialogLoader();

      imageUrl = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
      dataPost.image = imageUrl;
      await PostHelper.postHelper.addNewPost(dataPost);
      allPosts.insert(0, dataPost);
      postsUser.insert(0, dataPost);
      Provider.of<ApiProvider>(AppRouter.navKey.currentContext!,listen: false).posts?.insert(0, dataPost);
      postDescriptionController.clear();
      selectedImage = null;
      dialogLoader.close();
      controller.index = 0;
      selectedImage = null;

      notifyListeners();
    }


  }

  getAllPosts()async{
    allPosts = await PostHelper.postHelper.getAllPosts();
    allPosts.sort();
    postsUser = allPosts.where((element) => element.owner?.id == appUser?.id).toList();
     notifyListeners();
  }
  deletPost(DataPost dataPost)async{
    await PostHelper.postHelper.deletPost(dataPost.id!);
    postsUser.remove(dataPost);
    allPosts.remove(dataPost);
    Provider.of<ApiProvider>(AppRouter.navKey.currentContext!,listen: false).posts?.remove(dataPost);
    notifyListeners();

  }

  updateImagePost(Owner owner)async{
    await PostHelper.postHelper.updateImagePost(owner);
    appUser!.image = owner.picture;
    notifyListeners();
  }

  addNewComment(DataPost dataPost,)async{
    if(commentKey.currentState!.validate()){
      _dialogLoader();
      DataComment dataComment = DataComment(
        message: commentController.text,
        owner: OwnerComment(
          id: appUser!.id,
          picture: appUser!.image,
          firstName: appUser!.userName.split(" ")[0],
          lastName:  appUser!.userName.split(" ")[1],

        ),
        post: dataPost.id,
        publishDate: DateTime.now().toString()
      );

      DataComment comment = await PostHelper.postHelper.addComment(dataComment);
      comments?.add(comment);
      commentController.clear();
      dialogLoader.close();
      notifyListeners();
    }


  }

   getCommentOfPost(DataPost dataPost)async{
     comments = null;
    comments = await PostHelper.postHelper.getCommentOfPost(dataPost);
    notifyListeners();
  }


// addLike(bool like){
  //   like = !like;
  //   if(like){
  //
  //   }else{
  //
  //   }
  //
  // }







// addNewPost(String userId)async{
  //   if(postdKey.currentState!.validate()){
  //     String? imageUrl;
  //     if(selectedImage != null)
  //      imageUrl = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
  //     DataPost  postModel =
  //     DataPost(
  //         text: postDescriptionController.text,
  //         userId: userId,
  //         urlimage:  (selectedImage != null)?imageUrl:null,
  //       // price:productPriceController.text,
  //       // image: imageUrl,
  //       // title: productTitleController.text,
  //       // description: productDescriptionController.text,
  //       // catId: catId,
  //     );
  //     DataPost newPost = await SocialHelper.socialHelper.addNewPost(postModel);
  //
  //
  //     postsUser.add(newPost);
  //     // productTitleController.clear();
  //     selectedImage = null;
  //     notifyListeners();
  //   }
  // }
  //
  //
  //
  // getAllPost(String catId)async{
  //   postsUser = await  SocialHelper.socialHelper.getAllPost(catId);
  //
  //   notifyListeners();
  // }
  //
  // deletPost(PostModel postModel)async{
  //   await  SocialHelper.socialHelper.deletPost(postModel);
  //   postsUser.remove(postModel);
  //   notifyListeners();
  // }
  //
  // upDatePost(PostModel postModel) async {
  //   String? url;
  //   if(selectedImage != null){
  //     url = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
  //   }
  //   PostModel newProduct = PostModel(
  //       text: postDescriptionController.text,
  //     userId: postModel.userId,
  //     urlimage: url??postModel.urlimage
  //   );
  //   getAllPost(postModel.userId);
  //   SocialHelper.socialHelper.updatePost(newProduct);
  //   notifyListeners();
  // }
  //
  //

















//للفردي يعم
//
//
// addNewProduct1()async{
//   if(selectedImage != null && prodKey.currentState!.validate()){
//     String imageUrl = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
//     ProductModel  productModel = ProductModel(
//       price:productPriceController.text,
//       image: imageUrl,
//       title: productTitleController.text,
//       description: productDescriptionController.text,
//
//     );
//     ProductModel newProduct = await ProductFirestoreHelper.productFirestoreHelper.addNewProduct1(productModel);
//     products.add(newProduct);
//     // productTitleController.clear();
//     selectedImage = null;
//     notifyListeners();
//   }
// }
//
//  getAllProduct1()async{
//    products = await ProductFirestoreHelper.productFirestoreHelper.getAllProducts1();
//
//   notifyListeners();
// }
//
// deletProduct1(ProductModel productModel){
//   ProductFirestoreHelper.productFirestoreHelper.deletProduct1(productModel);
//   products.remove(productModel);
//   notifyListeners();
// }
//
// upDateProduct1(ProductModel productModel) async {
//   String? url;
//   if(selectedImage != null){
//      url = await StorgeHelper.storgeHelper.uplodImage(selectedImage!);
//   }
//   ProductModel newProduct = ProductModel(
//       id: productModel.id,
//       title: productTitleController.text,
//       description: productDescriptionController.text,
//       image: url??productModel.image,
//       price: productPriceController.text
//   );
//   ;
//   products[products.indexOf(productModel)] = newProduct;
//
//   ProductFirestoreHelper.productFirestoreHelper.upDateProduct1(newProduct);
//   notifyListeners();
// }
//
//
//
//
//
}