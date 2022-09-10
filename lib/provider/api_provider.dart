import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/api_helper.dart';
import 'package:social_media/model/comment_model.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/model/user_model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/post_provider.dart';

class ApiProvider extends ChangeNotifier{

  ApiProvider(){
    getPosts();
  }

   List? posts ;
  List? postsApi ;
   List? users;
   List? postsOfUser;
   List? comments;
   List? postsOfUserFromeComment;
   DataUser? dataUserFromeComment;
   DataUser? dataUser;


  int page = 0;
  bool isLoading = false;



  getPosts()async{
    isLoading = true;
    notifyListeners();
    if(page == 0){
      postsApi = await ApiHelper.apiHelper.getAllPosts(page);
      fillList();
    }

    else posts?.addAll(await ApiHelper.apiHelper.getAllPosts(page)) ;
    isLoading = false;

    notifyListeners();
   }

   getMorePosts(){
    page++;
    getPosts();
   }

   deletPost(DataPost dataPost){
    posts?.remove(dataPost);
    notifyListeners();

   }

   fillList(){
     posts =[];
    posts ?.addAll(Provider.of<PostProvider>(AppRouter.navKey.currentContext!,listen: false).allPosts) ;
    posts?.addAll(postsApi!);
    notifyListeners();

   }

  getAllUsers()async{
    users = await ApiHelper.apiHelper.getAllUsers();
    notifyListeners();
    print(users);
  }

  getPostOfUser(String userId)async{
    postsOfUser = null;
    PostsModel postsModel = await ApiHelper.apiHelper.getPostOfUser(userId);
    postsOfUser = postsModel.data;
    notifyListeners();
  }



  getOneUser(String idUser)async{
    dataUser = null;
     dataUser = await ApiHelper.apiHelper.getOneUser(idUser);
     notifyListeners();
  }

  getPostOfUserFromeComment(String userId)async{
    postsOfUserFromeComment = null;
    PostsModel postsModel = await ApiHelper.apiHelper.getPostOfUser(userId);
    print(postsModel.data?.length);


    postsOfUserFromeComment = postsModel.data;
    notifyListeners();
  }
  getOneUserFromeComment(String idUser)async{
    dataUserFromeComment = null;
    dataUserFromeComment = await ApiHelper.apiHelper.getOneUser(idUser);
    notifyListeners();
  }

  getCommentofPost(String idPost)async{
    comments = null;
    CommentModel commentModel = await ApiHelper.apiHelper.getCommentofPost(idPost);
    comments = commentModel.data;
    notifyListeners();
  }


}