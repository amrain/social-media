
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/post_helper.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/inbox_screen.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/custom_dialog.dart';
import 'package:social_media/view/widgets/post_widget.dart';
import 'package:social_media/view/widgets/post_widget.dart';
import 'package:social_media/view/widgets/post_widget_firebase.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F3FA),
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Feeds'),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(1),
        //     child: IconButton(onPressed: (){
        //
        //     }, icon: InkWell(
        //       onTap: (){
        //         // Diloge.show("v");
        //         PostHelper.postHelper.getAllPosts();
        //       },
        //         child: Icon(Icons.search)),),
        //   ),
        // ],
        leading: IconButton(onPressed: (){
          AppRouter.NavigateToWidget(InboxScreen());
        }, icon: Icon(Icons.forum))
      ),

      body: Consumer2<ApiProvider,PostProvider>(
        builder: (context,provider,postProvider,x) {
          return SafeArea(
            child: provider.posts==null
                ?Container(
              child: ListView.separated(
                itemBuilder: (_, i) {
                  final delay = (i * 300);
                  return Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                        color:  Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeShimmer.round(
                          size: 60,
                          fadeTheme:  FadeTheme.light,
                          millisecondsDelay: delay,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeShimmer(
                              height: 8,
                              width: 150,
                              radius: 4,
                              millisecondsDelay: delay,
                              fadeTheme: FadeTheme.light,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            FadeShimmer(
                              height: 150.h,
                              millisecondsDelay: delay,
                              width: 230.w,
                              radius: 4,
                              fadeTheme: FadeTheme.light,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: 20,
                separatorBuilder: (_, __) => SizedBox(
                  height: 20,
                ),
              ),
            )
                : LazyLoadScrollView(
              onEndOfPage: (){
                provider.getMorePosts();
              },
                  child: ListView.builder(
                  itemCount:(provider.isLoading)?provider.posts!.length+1:provider.posts?.length ,
                  itemBuilder: (contxt,index){
                    return

                      (index == provider.posts!.length)
                    ? Container(
                        height: 200.h,
                        decoration: BoxDecoration(
                            color:  Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeShimmer.round(
                              size: 60,
                              fadeTheme:  FadeTheme.light,
                              // millisecondsDelay: delay,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeShimmer(
                                  height: 8,
                                  width: 150,
                                  radius: 4,
                                  // millisecondsDelay: delay,
                                  fadeTheme: FadeTheme.light,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                FadeShimmer(
                                  height: 150.h,
                                  // millisecondsDelay: delay,
                                  width: 230.w,
                                  radius: 4,
                                  fadeTheme: FadeTheme.light,
                                ),
                              ],
                            )
                          ],
                        ),
                      )

                    :((index < postProvider.allPosts.length)
                          ?PostWidgetFirebase(provider.posts?[index])
                          : PostWidget(provider.posts?[index],isFeed: true,));

                  }),
                ),

          );
        }
      )

    );
  }
}

// Card(
//           child: Padding(
//             padding: const EdgeInsets.all(13),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   backgroundImage: AssetImage("assets/images/profile.png"),
//                 ),
//                 SizedBox(width: 10.w,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                   Text.rich(
//
//                     TextSpan(
//                       // style: TextStyle(
//                       //   fontFamily: 'Open Sans',
//                       //   fontSize: 15.sp,
//                       //   color: const Color(0xffcecece),
//                       // ),
//                       children: [
//
//                         TextSpan(
//                             text: "Martin Palmer\n",
//                             style:  TextStyle(
//                                 fontFamily: 'Montserrat-Medium',
//                                 fontSize: 15.sp,
//                                 color: const Color(0xcc161f3d),
//                                 height: 3
//                             )
//                         ),
//
//                         TextSpan(
//
//                           text: 'Today, 03:24 PM',
//                           style: TextStyle(
//                             fontFamily: 'Montserrat-Regular',
//                             fontSize: 10.sp,
//                             color: const Color(0x66161f3d),
//
//                           ),
//                         ),
//
//
//                       ],
//                     ),
//                     textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
//                     // textAlign: TextAlign.center,
//                     softWrap: false,
//
//
//                   ),
//                   SizedBox(height: 12.h,),
//
//                   SizedBox(
//                     width: 270.w,
//                     child: Text(
//
//                       'What is the loop of Creation? How from nothing? In spite of the fact that it is impossible to prove that anythin….',
//                       style: TextStyle(
//                         fontFamily: 'Montserrat-Regular',
//                         fontSize: 13.sp,
//                         color: const Color(0xbf161f3d),
//                         height: 1.3076923076923077,
//                       ),
//                       textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   SizedBox(height: 10.h,),
//                   ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.asset("assets/images/Rectangle Copy.png",
//                         height: 130.h,
//                         width: 270.w,
//                         fit: BoxFit.cover,
//
//                       )
//                   ),
//                   SizedBox(height: 15.h,),
//                   SizedBox(
//                     width: 270.w,
//                     child: Row(
//                       children: [
//                         Icon(Icons.favorite,color: Colors.grey.shade600,),
//                         SizedBox(width: 15.w,),
//                         SvgPicture.asset("assets/images/003-comment-1.svg"),
//                         Spacer(),
//                         Text(
//                           '\$340.00',
//                           style: TextStyle(
//                             fontFamily: 'Montserrat-Medium',
//                             fontSize: 15,
//                             color: const Color(0xff161f3d),
//                           ),
//                           textAlign: TextAlign.right,
//                           softWrap: false,
//                         )
//                       ],
//                     ),
//                   )
//                 ],),
//
//               ],
//             ),
//           ),
//         )





//**********
// ListView.builder(
//             itemBuilder: (contxt,index){
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(13),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: AssetImage("assets/images/profile.png"),
//                       ),
//                       SizedBox(width: 10.w,),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text.rich(
//
//                             TextSpan(
//                               // style: TextStyle(
//                               //   fontFamily: 'Open Sans',
//                               //   fontSize: 15.sp,
//                               //   color: const Color(0xffcecece),
//                               // ),
//                               children: [
//
//                                 TextSpan(
//                                     text: "Martin Palmer\n",
//                                     style:  TextStyle(
//                                         fontFamily: 'Montserrat-Medium',
//                                         fontSize: 15.sp,
//                                         color: const Color(0xcc161f3d),
//                                         height: 3
//                                     )
//                                 ),
//
//                                 TextSpan(
//
//                                   text: 'Today, 03:24 PM',
//                                   style: TextStyle(
//                                     fontFamily: 'Montserrat-Regular',
//                                     fontSize: 10.sp,
//                                     color: const Color(0x66161f3d),
//
//                                   ),
//                                 ),
//
//
//                               ],
//                             ),
//                             textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
//                             // textAlign: TextAlign.center,
//                             softWrap: false,
//
//
//                           ),
//                           SizedBox(height: 12.h,),
//
//                           SizedBox(
//                             width: 270.w,
//                             child: Text(
//
//                               'What is the loop of Creation? How from nothing? In spite of the fact that it is impossible to prove that anythin….',
//                               style: TextStyle(
//                                 fontFamily: 'Montserrat-Regular',
//                                 fontSize: 13.sp,
//                                 color: const Color(0xbf161f3d),
//                                 height: 1.3076923076923077,
//                               ),
//                               textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
//                               maxLines: 3,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           SizedBox(height: 10.h,),
//                           ClipRRect(
//                               borderRadius: BorderRadius.circular(10),
//                               child: Image.asset("assets/images/Rectangle Copy.png",
//                                 height: 130.h,
//                                 width: 270.w,
//                                 fit: BoxFit.cover,
//
//                               )
//                           ),
//                           SizedBox(height: 15.h,),
//                           SizedBox(
//                             width: 270.w,
//                             child: Row(
//                               children: [
//                                 Icon(Icons.favorite,color: Colors.grey.shade600,),
//                                 SizedBox(width: 15.w,),
//                                 SvgPicture.asset("assets/images/003-comment-1.svg"),
//                                 Spacer(),
//                                 Text(
//                                   '\$340.00',
//                                   style: TextStyle(
//                                     fontFamily: 'Montserrat-Medium',
//                                     fontSize: 15,
//                                     color: const Color(0xff161f3d),
//                                   ),
//                                   textAlign: TextAlign.right,
//                                   softWrap: false,
//                                 )
//                               ],
//                             ),
//                           )
//                         ],),
//
//                     ],
//                   ),
//                 ),
//               );
//             }),
