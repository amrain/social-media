import 'package:dio/dio.dart';
import 'package:social_media/model/comment_model.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/model/user_model.dart';
import 'package:social_media/view/widgets/constans.dart';

class ApiHelper{
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();

  Dio dio = Dio();

  getAllPosts(int page)async{
    Response response = await dio.get(urlApi+"post",
        queryParameters: {"page" : page,"limit":10},
      options: Options(
        headers: {
          'app-id':appID
        }

      )
    );
    dynamic responseData = response.data;
    PostsModel postsModel =  PostsModel.fromJson(responseData);
    List<DataPost>? posts = postsModel.data;
    return posts;
  }

  getAllUsers()async{
    Response response = await dio.get(urlApi+"user",
        options: Options(
            headers: {
              'app-id':appID
            }


        )
    );
    dynamic responseData = response.data;
    UserModel userModel =  UserModel.fromJson(responseData);
    List<DataUser>? users = userModel.data;
    return users;
  }
  
  getOneUser(String idUser)async{

    Response response = await dio.get(urlApi+'user/$idUser',

        options: Options(
        headers: {
        'app-id':appID,
        },

    ));
   DataUser dataUser = DataUser.fromJson(response.data);
   return dataUser;

  }

  getPostOfUser(String userId)async{
    Response response = await dio.get(urlApi+"user/$userId/post",
      options: Options(
        headers: {
          'app-id':appID,
        }
      )

    );
    PostsModel postsModel = PostsModel.fromJson(response.data);
    return postsModel;
  }

  getCommentofPost(String idPost)async{
   Response response = await dio.get(urlApi+"post/$idPost/comment",
    options: Options(
      headers: {
        'app-id':appID,
      }
    ));
   CommentModel commentModel = CommentModel.fromJson(response.data);
   return commentModel;
  }




}