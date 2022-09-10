import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_media/model/comment_model.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/view/screens/profile_screen.dart';
import 'package:social_media/view/widgets/constans.dart';
class CommentWidget extends StatelessWidget {
   CommentWidget(this.dataComment,{this.isOne});
   DataComment dataComment;
   bool? isOne = false;


   @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context,provider,x) {
        return Container(
          padding: EdgeInsets.all(12),
          height: 104.h,
          decoration: BoxDecoration(
            border: Border(

              top: (isOne!)?BorderSide(
                color: Color(0xff7A8FA6),
              ):BorderSide(
                color: Colors.transparent
              ),
              bottom: BorderSide(
                color: Color(0xff7A8FA6),

              ),

            )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(

                onTap: (){
                  // print(dataComment.owner?.id??"hjgh");

                  provider.getPostOfUserFromeComment(dataComment.owner?.id??"");
                   provider.getOneUserFromeComment(dataComment.owner?.id??"");
                  AppRouter.NavigateToWidget(ProfileScreen(fromeComment: true,));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,

                  radius: 30.sp,

                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        dataComment.owner?.picture??noImage,
                        height: 55.h,
                        width: 55.w,

                        loadingBuilder: (contxt,child,loding){
                          if(loding == null){
                            return child;
                          }else {
                            return FadeShimmer.round(
                              size: 10,
                              highlightColor: Color(0xffF9F9FB),
                              baseColor: Color(0xffE6E8EB),
                            );
                          }
                        },
                        errorBuilder: (contxt,child,loding){

                          return FadeShimmer.round(
                            size: 50,
                            highlightColor: Color(0xffF9F9FB),
                            baseColor: Color(0xffE6E8EB),
                          );


                        },

                      )
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      provider.getPostOfUserFromeComment(dataComment.owner?.id??"");
                      provider.getOneUserFromeComment(dataComment.owner?.id??"");
                      AppRouter.NavigateToWidget(ProfileScreen(fromeComment: true,));
                    },
                    child: Text(
                      dataComment.owner!.firstName!+" "+dataComment.owner!.lastName!,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16.sp,
                        color: const Color(0xff1b1b1b),
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: false,
                    ),
                  ),
                  SizedBox(height: 15,),

                  Text(
                    dataComment.message!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      color: const Color(0xff7a8fa6),
                    ),
                  )
                ],
              )
            ],
          ),

        );
      }
    );
  }
}
