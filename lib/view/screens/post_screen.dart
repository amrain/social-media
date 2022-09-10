import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/api_helper.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/widgets/comment_widget.dart';

import '../../model/post_model.dart';

class PostScreen extends StatefulWidget {
  DataPost dataPost ;
  PostScreen(this.dataPost);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLike = false;

  int? liks = 0;
  void initState() {
    super.initState();
    liks = widget.dataPost.likes;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(builder: (contxt,provider,x){
        return SafeArea(
          child:Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),
                child: Image.network(widget.dataPost.image!,height: 350.h,fit: BoxFit.fitHeight,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14,right: 22,left: 22),
                child: Row(
                  children: [
                    GestureDetector(onTap: (){
                      isLike =! isLike;
                      if(isLike)(liks = liks! + 1);else(liks = liks! - 1) ;
                      setState(() {

                      });
                    },
                        child: Icon(Icons.favorite,color: (isLike)?Colors.red:Colors.grey.shade600,)),
                    Text(
                      '  (${liks.toString()})',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 15,
                        color: const Color(0xff161f3d),
                      ),
                      textAlign: TextAlign.right,
                      softWrap: false,
                    ),

                    SizedBox(width: 15.w,),
                    SvgPicture.asset("assets/images/003-comment-1.svg"),
                    Text(
                      '  (${provider.postsUser.length.toString()})',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 15,
                        color: const Color(0xff161f3d),
                      ),
                      textAlign: TextAlign.right,
                      softWrap: false,
                    ),

                  ],
                ),
              ),
              SizedBox(height: 25.h,),

              // (provider.comments!.isEmpty)?Expanded(
              //   child: Center(
              //     child: Lottie.asset("assets/animation/16289-no-comments.json",width: 280.w),
              //   ),
              // ):
              // Expanded(
              //     child: ListView.builder(
              //       itemCount: provider.comments?.length,
              //         itemBuilder: (context,index){
              //         return CommentWidget(
              //             provider.comments?[index],
              //
              //           isOne: (index == 0)?true:false,
              //
              //         );
              //
              //     })
              //
              // ),
              
            ],

          ),
        );
      }),
    );
  }
}
