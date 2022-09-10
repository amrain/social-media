import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/api_helper.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/chat_provider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/add_post.dart';
import 'package:social_media/view/screens/feed_screen.dart';
import 'package:social_media/view/screens/nav_bar.dart';
import 'package:social_media/view/screens/profile_screen.dart';
import 'package:social_media/view/screens/splach_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
          providers: [
            ChangeNotifierProvider<ApiProvider>(
              create: (BuildContext context) {
                return  ApiProvider();
              },
            ),
            ChangeNotifierProvider<AuthProvaider>(
              create: (BuildContext context) {
                return  AuthProvaider();
              },

            ),
            ChangeNotifierProvider<PostProvider>(
              create: (BuildContext context) {
                return  PostProvider();
              },

            ),
            ChangeNotifierProvider<ChatProvider>(
              create: (BuildContext context) {
                return  ChatProvider();
              },

            ),


          ],
          child: Bais(),
        );



      }

}

class Bais extends StatelessWidget {
  const Bais({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize:  Size(375, 768),
    minTextAdapt: true,
    builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            navigatorKey: AppRouter.navKey,
            debugShowCheckedModeBanner: false,
            home: SplachScreen(),
          );
    }
    );}
}

//SizedBox(
//                     height: 768.h,
//
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.center,
//                       // crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Stack(
//                           children: [
//                             CustemAppBar(),
//                             SizedBox(
//                               height: 245.h,
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(150),
//                                     child: Image.network(provider.dataUser?.picture??"",height: 136.h,width: 136.h,
//                                       fit: BoxFit.contain,)),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
//                               child: InkWell(
//                                 onTap:(){
//                                   AppRouter.popraoter();
//                                 },
//
//                                 child: CircleAvatar(
//                                   child: Icon(Icons.arrow_back,color: Colors.white,),
//                                   backgroundColor: Color(0xff151630).withOpacity(.1),
//                                 ),
//                               ),
//                             )
//
//                           ],
//                         ),
//                         // SizedBox(height: 50.h,),
//                         //  ClipRRect(
//                         //    borderRadius: BorderRadius.circular(500),
//                         //      child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3nNTrHOc2zJq7M_01KkHHz7w1Z9C_Tzg4cQ&usqp=CAU",height: 136.h,width: 136.h,)),
//                         SizedBox(height: 20.h,),
//                         Text.rich(
//
//                           TextSpan(
//                             // style: TextStyle(
//                             //   fontFamily: 'Open Sans',
//                             //   fontSize: 15.sp,
//                             //   color: const Color(0xffcecece),
//                             // ),
//                             children: [
//
//                               TextSpan(
//                                 text: provider.dataUser?.firstName??"",
//                                 style:  TextStyle(
//                                   fontFamily: 'Montserrat-SemiBold',
//                                   fontSize: 16.sp,
//                                   color: const Color(0xe6161f3d),
//                                 ),
//                               ),
//
//                               TextSpan(
//
//                                 text: provider.dataUser?.lastName??"",
//                                 style: TextStyle(
//                                   fontFamily: 'Montserrat-SemiBold',
//                                   fontSize: 16.sp,
//                                   color: const Color(0xe6161f3d),
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                           textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
//                           // textAlign: TextAlign.center,
//                           softWrap: false,
//
//
//                         ),
//
//                         // Text(
//                         //   provider.dataUser?.firstName??"",
//                         //   style: TextStyle(
//                         //     fontFamily: 'Montserrat-SemiBold',
//                         //     fontSize: 16.sp,
//                         //     color: const Color(0xe6161f3d),
//                         //   ),
//                         //   textAlign: TextAlign.center,
//                         //   softWrap: false,
//                         // ),
//                         SizedBox(height: 10.h,),
//
//                         Text(
//                           provider.dataUser?.location?["country"],
//                           style: TextStyle(
//                             fontFamily: 'Montserrat-Regular',
//                             fontSize: 13.sp,
//                             color: const Color(0x80161f3d),
//                           ),
//                           textAlign: TextAlign.center,
//                           softWrap: false,
//                         ),
//                         SizedBox(height: 40.h,),
//
//                         Text(
//                           'Posts'+' (${provider.postsOfUser?.length})',
//                           style: TextStyle(
//                             fontFamily: 'Montserrat-Medium',
//                             fontSize: 14.sp,
//                             color: const Color(0xcc161f3d),
//                           ),
//                           textAlign: TextAlign.center,
//                           softWrap: false,
//                         ),
//                         SizedBox(height: 8.h,),
//
//                         provider.postsOfUser==null
//                         // ?CircularProgressIndicator()
//                             ? Container(
//                           child: Expanded(
//                             child: ListView.separated(
//                               itemBuilder: (_, i) {
//                                 final delay = (i * 300);
//                                 return Container(
//                                   height: 200.h,
//                                   decoration: BoxDecoration(
//                                       color:  Colors.white,
//                                       borderRadius: BorderRadius.circular(8)),
//                                   margin: EdgeInsets.symmetric(horizontal: 16),
//                                   padding: EdgeInsets.all(16),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       FadeShimmer.round(
//                                         size: 60,
//                                         fadeTheme:  FadeTheme.light,
//                                         millisecondsDelay: delay,
//                                       ),
//                                       SizedBox(
//                                         width: 8,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           FadeShimmer(
//                                             height: 8,
//                                             width: 150,
//                                             radius: 4,
//                                             millisecondsDelay: delay,
//                                             fadeTheme: FadeTheme.light,
//                                           ),
//                                           SizedBox(
//                                             height: 15,
//                                           ),
//                                           FadeShimmer(
//                                             height: 150.h,
//                                             millisecondsDelay: delay,
//                                             width: 230.w,
//                                             radius: 4,
//                                             fadeTheme: FadeTheme.light,
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               },
//                               itemCount: 20,
//                               separatorBuilder: (_, __) => SizedBox(
//                                 height: 20,
//                               ),
//                             ),
//                           ),
//                         )
//                             : LazyLoadScrollView(
//                           onEndOfPage: (){
//                             // provider.getMorePosts();
//                           },
//                           child: Expanded(
//                             child: ListView.builder(
//                                 itemCount:(provider.isLoading)?provider.postsOfUser!.length+1:provider.postsOfUser?.length ,
//                                 itemBuilder: (contxt,index){
//                                   return
//
//                                     (index == provider.postsOfUser!.length)
//                                         ? Container(
//                                       height: 200.h,
//                                       decoration: BoxDecoration(
//                                           color:  Colors.white,
//                                           borderRadius: BorderRadius.circular(8)),
//                                       margin: EdgeInsets.symmetric(horizontal: 16),
//                                       padding: EdgeInsets.all(16),
//                                       child: Row(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           FadeShimmer.round(
//                                             size: 60,
//                                             fadeTheme:  FadeTheme.light,
//                                             // millisecondsDelay: delay,
//                                           ),
//                                           SizedBox(
//                                             width: 8,
//                                           ),
//                                           Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               FadeShimmer(
//                                                 height: 8,
//                                                 width: 150,
//                                                 radius: 4,
//                                                 // millisecondsDelay: delay,
//                                                 fadeTheme: FadeTheme.light,
//                                               ),
//                                               SizedBox(
//                                                 height: 15,
//                                               ),
//                                               FadeShimmer(
//                                                 height: 150.h,
//                                                 // millisecondsDelay: delay,
//                                                 width: 230.w,
//                                                 radius: 4,
//                                                 fadeTheme: FadeTheme.light,
//                                               ),
//                                             ],
//                                           )
//                                         ],
//                                       ),
//                                     )
//                                     // Center(child: CircularProgressIndicator())
//                                     // Container(
//                                     //   child: ListView.separated(
//                                     //     itemBuilder: (_, i) {
//                                     //       final delay = (i * 300);
//                                     //       return Container(
//                                     //         height: 200.h,
//                                     //         decoration: BoxDecoration(
//                                     //             color:  Colors.white,
//                                     //             borderRadius: BorderRadius.circular(8)),
//                                     //         margin: EdgeInsets.symmetric(horizontal: 16),
//                                     //         padding: EdgeInsets.all(16),
//                                     //         child: Row(
//                                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                                     //           children: [
//                                     //             FadeShimmer.round(
//                                     //               size: 60,
//                                     //               fadeTheme:  FadeTheme.light,
//                                     //               millisecondsDelay: delay,
//                                     //             ),
//                                     //             SizedBox(
//                                     //               width: 8,
//                                     //             ),
//                                     //             Column(
//                                     //               crossAxisAlignment: CrossAxisAlignment.start,
//                                     //               children: [
//                                     //                 FadeShimmer(
//                                     //                   height: 8,
//                                     //                   width: 150,
//                                     //                   radius: 4,
//                                     //                   millisecondsDelay: delay,
//                                     //                   fadeTheme: FadeTheme.light,
//                                     //                 ),
//                                     //                 SizedBox(
//                                     //                   height: 15,
//                                     //                 ),
//                                     //                 FadeShimmer(
//                                     //                   height: 150.h,
//                                     //                   millisecondsDelay: delay,
//                                     //                   width: 230.w,
//                                     //                   radius: 4,
//                                     //                   fadeTheme: FadeTheme.light,
//                                     //                 ),
//                                     //               ],
//                                     //             )
//                                     //           ],
//                                     //         ),
//                                     //       );
//                                     //     },
//                                     //     itemCount: 20,
//                                     //     separatorBuilder: (_, __) => SizedBox(
//                                     //       height: 20,
//                                     //     ),
//                                     //   ),
//                                     // )
//                                         : PostWidget(provider.postsOfUser?[index]);
//
//                                 }),
//                           ),
//                         ),
//
//
//
//                       ],
//                     ),
//                   );







