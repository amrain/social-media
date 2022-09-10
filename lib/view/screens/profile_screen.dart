import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/api_helper.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/edit_screen.dart';
import 'package:social_media/view/screens/feed_screen.dart';
import 'package:social_media/view/screens/nav_bar.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/custem_appbar.dart';
import 'package:social_media/view/widgets/menu_list/menu_items.dart';
import 'package:social_media/view/widgets/menu_list/one_item.dart';
import 'package:social_media/view/widgets/post_widget.dart';
import 'package:social_media/view/widgets/post_widget.dart';
import 'package:social_media/view/widgets/post_widget_firebase.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({this.fromeComment = false,this.isUser = false});
   bool fromeComment;
   bool isUser;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffF2F3FA),
      body: Consumer2<ApiProvider,PostProvider>(
        builder: (context,provider,provider3,x) {
          return (widget.isUser)
              ?SafeArea(
            child:
            (provider3.appUser==null)
                ?Center(child: CircularProgressIndicator())
                : Column(

              children: [
                Stack(
                  children: [
                    CustemAppBar(),
                    SizedBox(
                      height: 245.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child:Stack(fit: StackFit.loose, children: <Widget>[
                          new Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                                    height: 245.h,
                                                    child: Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.circular(150),
                                                          child: Image.network(provider3.appUser?.image??"https://raw.githubusercontent.com/flutter-devs/flutter_profileview_demo/master/assets/images/as.png",height: 136.h,width: 136.h,
                                                            fit: BoxFit.cover,
                                                            loadingBuilder: (contxt,child,loding){
                                                              if(loding == null){
                                                                return child;
                                                              }else {
                                                                return FadeShimmer.round(
                                                                  size: 100.sp,
                                                                  highlightColor: Color(0xffF9F9FB),
                                                                  baseColor: Color(0xffE6E8EB),
                                                                );
                                                              }
                                                            },

                                                          )),
                                                    ),
                                                  ),

                            ],
                          ),

                          // Padding(
                          //     padding: EdgeInsets.only(top: 200.h, right: 100.0.h),
                          //     child: new Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: <Widget>[
                          //         InkWell(
                          //           onTap: ()async{
                          //             await provider3.selecteImageFun();
                          //             // await provider3.upDateImage();
                          //           },
                          //           child: new CircleAvatar(
                          //             backgroundColor: Colors.red,
                          //             radius: 25.0,
                          //             child: new Icon(
                          //               Icons.camera_alt,
                          //               color: Colors.white,
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     )),//update
                        ]),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                      child: InkWell(
                        onTap:(){
                          controller.index = (0);
                          },

                        child: CircleAvatar(
                          radius: 20,

                          child: Icon(Icons.arrow_back,color: Colors.white,),
                          backgroundColor: Color(0xff151630).withOpacity(.1),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                      child: PopupMenuButton<OneItem>(
                        icon: Icon(Icons.more_vert,color: Colors.white,),
                        onSelected: (item) => onSelected(context,item),
                        itemBuilder: (contxt){
                          return [
                            ...MenuItems.firstItems.map(buildItem).toList(),
                            PopupMenuDivider(),
                            ...MenuItems.SecundItems.map(buildItem).toList()

                          ];
                        },

                      )
                    )

                  ],
                  // GestureDetector(
                  //                             child: new CircleAvatar(
                  //                                   backgroundColor: Colors.orangeAccent,
                  //                                   radius: 20,
                  //                                   child: new Icon(
                  //                                     Icons.edit,
                  //                                     color: Colors.white,
                  //                                     size: 22,
                  //                                   ),
                  //                                 ),
                  //                               onTap: () {
                  //                               AppRouter.NavigateToWidget(EditScreen());
                  //
                  //                               },
                  //                       ),
                ),
                SizedBox(height: 15.h,),
                Text(
                   provider3.appUser?.userName??"",
                  style:  TextStyle(
                    fontFamily: 'Montserrat-SemiBold',
                    fontSize: 16.sp,
                    color: const Color(0xe6161f3d),
                  ),
                ),

                SizedBox(height: 10.h,),

                Text(
                  provider3.appUser?.city??"",
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 13.sp,
                    color: const Color(0x80161f3d),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                SizedBox(height: 30.h,),

                Text(
                  'Posts'+' (${provider3.postsUser.length})',
                  style: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: 14.sp,
                    color: const Color(0xcc161f3d),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                SizedBox(height: 8.h,),

                provider3.postsUser.length == 0

                    ? Container(
                  child: Expanded(
                    child:Center(
                      child: Lottie.asset("assets/animation/53207-empty-file (1).json",width: 280.w),
                    )
                  ),
                )
                    : Expanded(
                      child: ListView.builder(
                          itemCount:provider3.postsUser.length ,
                          itemBuilder: (contxt,index){
                            return PostWidgetFirebase(provider3.postsUser[index],isUser: true,);

                          }),
                    ),



              ],
            ),
          )
              :((widget.fromeComment)
              ?SafeArea(
            child:
            (provider.postsOfUserFromeComment == null||provider.dataUserFromeComment==null)
                ?Center(child: CircularProgressIndicator())
                : Column(

              children: [
                Stack(
                  children: [
                    CustemAppBar(),
                    SizedBox(
                      height: 245.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.network(provider.dataUserFromeComment?.picture??"",height: 136.h,width: 136.h,
                              fit: BoxFit.contain,)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                      child: InkWell(
                        onTap:(){
                          AppRouter.popraoter();
                        },

                        child: CircleAvatar(
                          child: Icon(Icons.arrow_back,color: Colors.white,),
                          backgroundColor: Color(0xff151630).withOpacity(.1),
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 15.h,),
                Text.rich(

                  TextSpan(

                    children: [

                      TextSpan(
                        text: provider.dataUserFromeComment?.firstName??"",
                        style:  TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 16.sp,
                          color: const Color(0xe6161f3d),
                        ),
                      ),
                      TextSpan(

                        text: "  ",
                        style: TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 16.sp,
                          color: const Color(0xe6161f3d),
                        ),
                      ),
                      TextSpan(

                        text: provider.dataUserFromeComment?.lastName??"",
                        style: TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 16.sp,
                          color: const Color(0xe6161f3d),
                        ),
                      ),


                    ],
                  ),
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  // textAlign: TextAlign.center,
                  softWrap: false,


                ),

                // Text(
                //   provider.dataUser?.firstName??"",
                //   style: TextStyle(
                //     fontFamily: 'Montserrat-SemiBold',
                //     fontSize: 16.sp,
                //     color: const Color(0xe6161f3d),
                //   ),
                //   textAlign: TextAlign.center,
                //   softWrap: false,
                // ),
                SizedBox(height: 10.h,),

                Text(
                  provider.dataUserFromeComment?.location?["country"],
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 13.sp,
                    color: const Color(0x80161f3d),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                SizedBox(height: 30.h,),

                Text(
                  'Posts'+' (${provider.postsOfUserFromeComment?.length})',
                  style: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: 14.sp,
                    color: const Color(0xcc161f3d),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                SizedBox(height: 8.h,),

                provider.postsOfUserFromeComment==null
                // ?CircularProgressIndicator()
                    ? Container(
                  child: Expanded(
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
                  ),
                )
                    : LazyLoadScrollView(
                  onEndOfPage: (){
                    // provider.getMorePosts();
                  },
                  child: Expanded(
                    child: ListView.builder(
                        itemCount:(provider.isLoading)?provider.postsOfUserFromeComment!.length+1:provider.postsOfUserFromeComment?.length ,
                        itemBuilder: (contxt,index){
                          return

                            (index == provider.postsOfUserFromeComment!.length)
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
                            // Center(child: CircularProgressIndicator())
                            // Container(
                            //   child: ListView.separated(
                            //     itemBuilder: (_, i) {
                            //       final delay = (i * 300);
                            //       return Container(
                            //         height: 200.h,
                            //         decoration: BoxDecoration(
                            //             color:  Colors.white,
                            //             borderRadius: BorderRadius.circular(8)),
                            //         margin: EdgeInsets.symmetric(horizontal: 16),
                            //         padding: EdgeInsets.all(16),
                            //         child: Row(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             FadeShimmer.round(
                            //               size: 60,
                            //               fadeTheme:  FadeTheme.light,
                            //               millisecondsDelay: delay,
                            //             ),
                            //             SizedBox(
                            //               width: 8,
                            //             ),
                            //             Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 FadeShimmer(
                            //                   height: 8,
                            //                   width: 150,
                            //                   radius: 4,
                            //                   millisecondsDelay: delay,
                            //                   fadeTheme: FadeTheme.light,
                            //                 ),
                            //                 SizedBox(
                            //                   height: 15,
                            //                 ),
                            //                 FadeShimmer(
                            //                   height: 150.h,
                            //                   millisecondsDelay: delay,
                            //                   width: 230.w,
                            //                   radius: 4,
                            //                   fadeTheme: FadeTheme.light,
                            //                 ),
                            //               ],
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //     itemCount: 20,
                            //     separatorBuilder: (_, __) => SizedBox(
                            //       height: 20,
                            //     ),
                            //   ),
                            // )
                                : PostWidget(provider.postsOfUserFromeComment?[index]);

                        }),
                  ),
                ),



              ],
            ),
          )
              :SafeArea(
            child:
            (provider.postsOfUser == null||provider.dataUser==null)
                ?Center(child: CircularProgressIndicator())
                : Column(

              children: [
                Stack(
                  children: [
                    CustemAppBar(),
                    SizedBox(
                      height: 245.h,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(150),
                            child: Image.network(provider.dataUser?.picture??"",height: 136.h,width: 136.h,
                              fit: BoxFit.contain,   )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                      child: InkWell(
                        onTap:(){
                          AppRouter.popraoter();
                        },

                        child: CircleAvatar(
                          child: Icon(Icons.arrow_back,color: Colors.white,),
                          backgroundColor: Color(0xff151630).withOpacity(.1),
                        ),
                      ),
                    )

                  ],
                ),
                SizedBox(height: 15.h,),
                Text.rich(

                  TextSpan(

                    children: [

                      TextSpan(
                        text: provider.dataUser?.firstName??"",
                        style:  TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 16.sp,
                          color: const Color(0xe6161f3d),
                        ),
                      ),
                      TextSpan(

                        text: "  ",
                        style: TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 16.sp,
                          color: const Color(0xe6161f3d),
                        ),
                      ),


                      TextSpan(

                        text: provider.dataUser?.lastName??"",
                        style: TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 16.sp,
                          color: const Color(0xe6161f3d),
                        ),
                      ),


                    ],
                  ),
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  // textAlign: TextAlign.center,
                  softWrap: false,


                ),

                // Text(
                //   provider.dataUser?.firstName??"",
                //   style: TextStyle(
                //     fontFamily: 'Montserrat-SemiBold',
                //     fontSize: 16.sp,
                //     color: const Color(0xe6161f3d),
                //   ),
                //   textAlign: TextAlign.center,
                //   softWrap: false,
                // ),
                SizedBox(height: 10.h,),

                Text(
                  provider.dataUser?.location?["country"],
                  style: TextStyle(
                    fontFamily: 'Montserrat-Regular',
                    fontSize: 13.sp,
                    color: const Color(0x80161f3d),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                SizedBox(height: 30.h,),

                Text(
                  'Posts'+' (${provider.postsOfUser?.length})',
                  style: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: 14.sp,
                    color: const Color(0xcc161f3d),
                  ),
                  textAlign: TextAlign.center,
                  softWrap: false,
                ),
                SizedBox(height: 8.h,),

                provider.postsOfUser==null
                // ?CircularProgressIndicator()
                    ? Container(
                  child: Expanded(
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
                  ),
                )
                    : LazyLoadScrollView(
                  onEndOfPage: (){
                    // provider.getMorePosts();
                  },
                  child: Expanded(
                    child: ListView.builder(
                        itemCount:(provider.isLoading)?provider.postsOfUser!.length+1:provider.postsOfUser?.length ,
                        itemBuilder: (contxt,index){
                          return

                            (index == provider.postsOfUser!.length)
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
                            // Center(child: CircularProgressIndicator())
                            // Container(
                            //   child: ListView.separated(
                            //     itemBuilder: (_, i) {
                            //       final delay = (i * 300);
                            //       return Container(
                            //         height: 200.h,
                            //         decoration: BoxDecoration(
                            //             color:  Colors.white,
                            //             borderRadius: BorderRadius.circular(8)),
                            //         margin: EdgeInsets.symmetric(horizontal: 16),
                            //         padding: EdgeInsets.all(16),
                            //         child: Row(
                            //           crossAxisAlignment: CrossAxisAlignment.start,
                            //           children: [
                            //             FadeShimmer.round(
                            //               size: 60,
                            //               fadeTheme:  FadeTheme.light,
                            //               millisecondsDelay: delay,
                            //             ),
                            //             SizedBox(
                            //               width: 8,
                            //             ),
                            //             Column(
                            //               crossAxisAlignment: CrossAxisAlignment.start,
                            //               children: [
                            //                 FadeShimmer(
                            //                   height: 8,
                            //                   width: 150,
                            //                   radius: 4,
                            //                   millisecondsDelay: delay,
                            //                   fadeTheme: FadeTheme.light,
                            //                 ),
                            //                 SizedBox(
                            //                   height: 15,
                            //                 ),
                            //                 FadeShimmer(
                            //                   height: 150.h,
                            //                   millisecondsDelay: delay,
                            //                   width: 230.w,
                            //                   radius: 4,
                            //                   fadeTheme: FadeTheme.light,
                            //                 ),
                            //               ],
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //     itemCount: 20,
                            //     separatorBuilder: (_, __) => SizedBox(
                            //       height: 20,
                            //     ),
                            //   ),
                            // )
                                : PostWidget(provider.postsOfUser?[index]);

                        }),
                  ),
                ),



              ],
            ),
          ));





        }
      ),
    );
  }

  PopupMenuItem<OneItem> buildItem(item) => PopupMenuItem<OneItem>(
    value: item,

    child: Row(
      children: [
        item.icon,
        SizedBox(width: 10.w,),
        Text(item.text),
      ],
    ),
  );
  void onSelected(BuildContext context,OneItem item){
    switch (item){
      case MenuItems.itemEdit: AppRouter.NavigateToWidget(EditScreen());break;
      case MenuItems.itemlogOut: Provider.of<AuthProvaider>(context,listen: false).signOut();;break;

    }


  }


}


