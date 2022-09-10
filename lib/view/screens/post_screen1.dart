import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/view/widgets/comment_widget.dart';
import 'package:social_media/view/widgets/constans.dart';

class PostScreen1 extends StatefulWidget {
  DataPost dataPost;
  PostScreen1(this.dataPost);

  @override
  _PostScreen1State createState() => _PostScreen1State();
}

class _PostScreen1State extends State<PostScreen1> {

  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;
  int? liks = 0;
  bool isLike = false;



  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    liks = widget.dataPost.likes;


  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(
      builder: (context,provider,x) {
        return Scaffold(
                  body:
                  (provider.comments == null)?Center(
                    child: CircularProgressIndicator(),
                  ):
                  NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          elevation: 0,
                          backgroundColor: (_isShrink)?MainColor:Colors.white,
                          // foregroundColor: MainColor,

                          pinned: true,
                          expandedHeight: 450.h,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            centerTitle: true,
                            title: _isShrink
                                ?  Text(
                              'Comments',
                              style: TextStyle(
                                // color: MainColor
                              ),
                              // widget.index.toString(),
                            )
                                : null,
                            background: SafeArea(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight:Radius.circular(20) ),
                                      child: Image.network(widget.dataPost.image!,height: 400.h,fit: BoxFit.cover,),
                                    ),
                                  ),
                                  Padding(
                                    // color: Colors.white,
                                    padding: const EdgeInsets.only(top: 15,right: 22,left: 22),
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
                                          '  (${provider.comments?.length.toString()})',
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
                                  // SizedBox(height: .h,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body:               (provider.comments!.isEmpty)?Center(
                      child: Lottie.asset("assets/animation/16289-no-comments.json",width: 280.w),
                    ):
                    CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(



                                (BuildContext context, int index) {
                              return  _isShrink?(
                                  (index == 0)?Column(
                                    children: [
                                      SizedBox(height: 75.h,),
                                      CommentWidget(
                                        Provider.of<ApiProvider>(context).comments![index],

                                        isOne: (index == 0)?true:false,

                                      ),
                                    ],
                                  ):
                                  CommentWidget(
                                Provider.of<ApiProvider>(context).comments![index],

                                isOne: (index == 0)?true:false,

                              )
                              ):CommentWidget(
                                        Provider.of<ApiProvider>(context).comments![index],

                                  isOne: (index == 0)?true:false,

                                );

                            },
                            childCount: Provider.of<ApiProvider>(context).comments?.length??0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
      }
    );
        }

  }




