import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/api_helper.dart';
import 'package:social_media/data/post_helper.dart';
import 'package:social_media/model/comment_model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/widgets/comment_widget.dart';
import 'package:social_media/view/widgets/constans.dart';

import '../../model/post_model.dart';

class PostScreen extends StatefulWidget {
  DataPost dataPost ;
  PostScreen(this.dataPost);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isLike = false;
  final ValueNotifier<TextDirection> _textDir = ValueNotifier(TextDirection.ltr);


  int? liks = 0;
  void initState() {
    super.initState();
    liks = widget.dataPost.likes;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(builder: (contxt,provider,x){
        return (provider.comments == null)
            ?Center(
        child: CircularProgressIndicator(),
        )
            :SafeArea(
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
                    StreamBuilder<DocumentSnapshot>(
                        stream: PostHelper.postHelper.getAllLiks(widget.dataPost),
                        builder: (contxt,snapshots){
                          if(!snapshots.hasData){
                            return IconButton(onPressed:(){} , icon: Icon(Icons.favorite,color: Colors.grey.shade600,));
                          }
                          if(snapshots.data!.exists){
                            return IconButton(onPressed: (){
                              PostHelper.postHelper.addLike(true, widget.dataPost);
                            }, icon: Icon(Icons.favorite,color: Colors.red,));
                          }else  return IconButton(onPressed: (){
                            PostHelper.postHelper.addLike(false, widget.dataPost);

                          }, icon: Icon(Icons.favorite,color: Colors.grey.shade600,));

                        }),
                    StreamBuilder<QuerySnapshot>(
                        stream: PostHelper.postHelper.getAllLiksforeNum(widget.dataPost),
                        builder: (contxt,snapshots){
                          if(snapshots.hasData){
                            return  (snapshots.data!.docs.length==0)
                                ?Text(
                              "",
                              style: TextStyle(
                                fontFamily: 'Montserrat-Medium',
                                fontSize: 15,
                                color: const Color(0xff161f3d),
                              ),
                              textAlign: TextAlign.right,
                              softWrap: false,
                            )
                                :Text(
                              snapshots.data!.docs.length.toString(),
                              style: TextStyle(
                                fontFamily: 'Montserrat-Medium',
                                fontSize: 15,
                                color: const Color(0xff161f3d),
                              ),
                              textAlign: TextAlign.right,
                              softWrap: false,
                            );
                            //   (snapshots.data!.docs.length==0)
                            //       ?snapshots.data!.docs.length.toString()
                            //   !Text(
                            //   snapshots.data!.docs.length.toString(),
                            //   style: TextStyle(
                            //     fontFamily: 'Montserrat-Medium',
                            //     fontSize: 15,
                            //     color: const Color(0xff161f3d),
                            //   ),
                            //   textAlign: TextAlign.right,
                            //   softWrap: false,
                            // );
                          }
                          else return Text(
                            "",
                            style: TextStyle(
                              fontFamily: 'Montserrat-Medium',
                              fontSize: 15,
                              color: const Color(0xff161f3d),
                            ),
                            textAlign: TextAlign.right,
                            softWrap: false,
                          );
                        }),

                    SizedBox(width: 10.w,),
                    SvgPicture.asset("assets/images/003-comment-1.svg"),
                    Text(
                      '   ${provider.comments!.length.toString()}',
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

              (provider.comments!.isEmpty)?Expanded(
                child: Center(
                  child: Lottie.asset("assets/animation/16289-no-comments.json",width: 280.w),
                ),
              ):
              Expanded(
                  child: ListView.builder(
                    itemCount: provider.comments?.length,
                      itemBuilder: (context,index){
                      return CommentWidget(
                          provider.comments![index],

                        isOne: (index == 0)?true:false,

                      );

                  })

              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(

                      child: Form(
                        key: provider.commentKey,
                        child: ValueListenableBuilder<TextDirection>(
                          valueListenable: _textDir,
                          builder: (context, value, child) =>
                              TextFormField(
                                maxLines: null,
                                controller: provider.commentController,
                                keyboardType: TextInputType.text,
                                textAlignVertical: TextAlignVertical.top,
                                validator: (x)=>provider.nullvaliation(x),
                                textDirection: value,
                                onChanged: (input){
                                  if (input.trim().length < 2) {
                                    final dir = getDirection(input);
                                    if (dir != value) _textDir.value = dir;
                                  }
                                },
                                style: TextStyle(
                                    fontSize: 15.sp
                                ),

                                decoration: InputDecoration(
                                    hintText: "Aa",
                                    hintStyle:TextStyle(
                                      fontFamily: 'Montserrat-Regular',
                                      fontSize: 15,
                                      color: Colors.black26,
                                    ) ,
                                    fillColor: Colors.white,

                                    filled: false,

                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: MainColor,
                                            width: 1
                                        )
                                    ),
                                    focusedBorder:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: MainColor,
                                            width: 1
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: BorderSide(
                                            color: Colors.black26,
                                            width: 1
                                        )
                                    )

                                ),

                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    InkWell(
                      onTap:(){
                        provider.addNewComment(widget.dataPost );
                      },
                      child: Icon(
                        Icons.send,color: MainColor,size: 35.sp,),
                    )
                  ],
                ),
              )

            ],

          ),
        );
      }),
    );
  }

  TextDirection getDirection(String v) {
    final string = v.trim();
    if (string.isEmpty) return TextDirection.ltr;
    final firstUnit = string.codeUnitAt(0);
    if (firstUnit > 0x0600 && firstUnit < 0x06FF ||
        firstUnit > 0x0750 && firstUnit < 0x077F ||
        firstUnit > 0x07C0 && firstUnit < 0x07EA ||
        firstUnit > 0x0840 && firstUnit < 0x085B ||
        firstUnit > 0x08A0 && firstUnit < 0x08B4 ||
        firstUnit > 0x08E3 && firstUnit < 0x08FF ||
        firstUnit > 0xFB50 && firstUnit < 0xFBB1 ||
        firstUnit > 0xFBD3 && firstUnit < 0xFD3D ||
        firstUnit > 0xFD50 && firstUnit < 0xFD8F ||
        firstUnit > 0xFD92 && firstUnit < 0xFDC7 ||
        firstUnit > 0xFDF0 && firstUnit < 0xFDFC ||
        firstUnit > 0xFE70 && firstUnit < 0xFE74 ||
        firstUnit > 0xFE76 && firstUnit < 0xFEFC ||
        firstUnit > 0x10800 && firstUnit < 0x10805 ||
        firstUnit > 0x1B000 && firstUnit < 0x1B0FF ||
        firstUnit > 0x1D165 && firstUnit < 0x1D169 ||
        firstUnit > 0x1D16D && firstUnit < 0x1D172 ||
        firstUnit > 0x1D17B && firstUnit < 0x1D182 ||
        firstUnit > 0x1D185 && firstUnit < 0x1D18B ||
        firstUnit > 0x1D1AA && firstUnit < 0x1D1AD ||
        firstUnit > 0x1D242 && firstUnit < 0x1D244) {
      return TextDirection.rtl;
    }
    return TextDirection.ltr;
  }
}
