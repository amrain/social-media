import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/post_screen.dart';
import 'package:social_media/view/screens/post_screen1.dart';
import 'package:social_media/view/screens/profile_screen.dart';
import 'package:social_media/view/widgets/constans.dart';

class PostWidgetFirebase extends StatefulWidget {
  DataPost data;
  bool isFeed;
  bool isUser;
  PostWidgetFirebase(this.data,{this.isFeed = false,this.isUser = false,});

  @override
  State<PostWidgetFirebase> createState() => _PostWidgetFirebaseState();
}

class _PostWidgetFirebaseState extends State<PostWidgetFirebase> {
  String? date;
  int? liks;

  bool isLike = false;



  @override
  void initState() {
    super.initState();

    date = widget.data.publishDate;
    date = date!.split(' ')[0];
    date = date = date!.split('-')[2]+"/"+date!.split('-')[1]+"/"+date!.split('-')[0];
    liks = widget.data.likes;
    liks = widget.data.likes;


  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PostProvider>(
        builder: (context,provider,x) {
          return Padding(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
            child: Card(
              elevation: 5,

              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    InkWell(
                      onTap: (){
                        if(widget.isFeed){
                          // provider.getPostOfUser(widget.data.owner!.id!);
                          // provider.getOneUser(widget.data.owner!.id!);
                          AppRouter.NavigateToWidget(ProfileScreen());
                        }

                      },
                      child: CircleAvatar(

                      backgroundImage: NetworkImage(widget.data.owner!.picture??noImage),
                      ),
                    ),

                    SizedBox(width: 10.w,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 275.w,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if (widget.isFeed){
                                    // provider.getPostOfUser(widget.data.owner?.id??"");
                                    // provider.getOneUser(widget.data.owner?.id??"");

                                    AppRouter.NavigateToWidget(ProfileScreen());
                                  }


                                },
                                child: Text.rich(

                                  TextSpan(
                                    // style: TextStyle(
                                    //   fontFamily: 'Open Sans',
                                    //   fontSize: 15.sp,
                                    //   color: const Color(0xffcecece),
                                    // ),
                                    children: [

                                      TextSpan(
                                          text: widget.data.owner!.firstName!+" "+widget.data.owner!.lastName!+"\n",
                                          style:  TextStyle(
                                              fontFamily: 'Montserrat-Medium',
                                              fontSize: 15.sp,
                                              color: const Color(0xcc161f3d),
                                              height: 3
                                          )
                                      ),

                                      TextSpan(

                                        text: date,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-Regular',
                                          fontSize: 10.sp,
                                          color: const Color(0x66161f3d),

                                        ),
                                      ),


                                    ],
                                  ),
                                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                  // textAlign: TextAlign.center,
                                  softWrap: false,


                                ),
                              ),
                              Spacer(),
                              (widget.isUser)?
                              IconButton(onPressed: (){
                                provider.deletPost(widget.data);
                              }, icon: Icon(Icons.delete,color: Colors.red,)):SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h,),

                        InkWell(onTap: (){
                          // provider.getCommentofPost(widget.data.id!);
                          AppRouter.NavigateToWidget(PostScreen(widget.data));
                        },child: Column(
                          children: [
                            SizedBox(
                              width: 270.w,
                              child: Text(
                                widget.data.text!,

                                style: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 13.sp,
                                  color: const Color(0xbf161f3d),
                                  height: 1.3076923076923077,
                                ),
                                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(widget.data.image!,
                                  height: 130.h,
                                  width: 270.w,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (contxt,child,loding){
                                    if(loding == null){
                                      return child;
                                    }else {
                                      return FadeShimmer(
                                        height: 130.h,
                                        width: 270.w,
                                        radius: 10,
                                        highlightColor: Color(0xffF9F9FB),
                                        baseColor: Color(0xffE6E8EB),
                                      );
                                    }
                                  },
                                  errorBuilder: (contxt,child,loding){

                                    return FadeShimmer(
                                      height: 130.h,
                                      width: 270.w,
                                      radius: 10,
                                      highlightColor: Color(0xffF9F9FB),
                                      baseColor: Color(0xffE6E8EB),
                                    );


                                  },

                                )
                            ),
                          ],
                        ),),



                        SizedBox(height: 15.h,),
                        SizedBox(
                          width: 270.w,
                          child: Row(
                            children: [
                              GestureDetector(onTap: (){
                                isLike =! isLike;
                                if(isLike)(liks = liks! + 1);else(liks = liks! - 1) ;
                                setState(() {

                                });
                              },
                                  child: Icon(Icons.favorite,color: (isLike)?Colors.red:Colors.grey.shade600,)),
                              SizedBox(width: 15.w,),
                              SvgPicture.asset("assets/images/003-comment-1.svg"),
                              Spacer(),
                              Text(
                                liks.toString(),
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Medium',
                                  fontSize: 15,
                                  color: const Color(0xff161f3d),
                                ),
                                textAlign: TextAlign.right,
                                softWrap: false,
                              )
                            ],
                          ),
                        )
                      ],),

                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
