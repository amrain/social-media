import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/view/screens/test.dart';
import 'package:social_media/view/widgets/constans.dart';

import '../screens/chat_screen1.dart';

class UserChatWidget extends StatelessWidget {
   UserChatWidget(this.appUser) ;
  AppUser appUser;

  @override
  Widget build(BuildContext context) {
    var sp;
    return Column(
      children: [
        InkWell(
          onTap: (){
            AppRouter.NavigateToWidget(ChatScreen(appUser));
          },
          child: Container(
            color: Color(0xffFBFCFE),
            padding: EdgeInsets.symmetric(vertical:12,horizontal: 17 ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 27.5.sp,
                  backgroundImage: NetworkImage(appUser.image??"https://raw.githubusercontent.com/flutter-devs/flutter_profileview_demo/master/assets/images/as.png"),
                ),
                SizedBox(width: 10.w,),
                Text(
                  appUser.userName,
                  style: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: 15.sp,
                    color: const Color(0xffe9446a),
                  ),
                  softWrap: false,
                )

              ],
            ),
          ),
        ),
        Divider(
          color: MainColor,
          height: 5,
          thickness: .5,
          indent: 15,
          endIndent: 15,
        )
      ],
    );
  }
}
