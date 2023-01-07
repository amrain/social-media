import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/api_provider.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/chat_provider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/login_screen.dart';
import 'package:social_media/view/widgets/constans.dart';

class SplachScreen extends StatelessWidget {
  const SplachScreen({Key? key}) : super(key: key);

  navigationFun()async{
     await Future.delayed(Duration(seconds: 3));
     await Provider.of<AuthProvaider>(AppRouter.navKey.currentContext!,listen: false).checUser();
     await Provider.of<ChatProvider>(AppRouter.navKey.currentContext!,listen: false).getAllUsers();



  }

  @override
  Widget build(BuildContext context) {
    navigationFun();
    return Scaffold(
      // backgroundColor: Color(0xffE9446A),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/data-encryption.png',height: 180.h,),
            SizedBox(height: 15.h,),
            Text("Encryption Chat",style: TextStyle(
              fontFamily: 'Montserrat-Regular',
              fontSize: 25.sp,
              color: MainColor,
              height: 1.5,
            ),),
          ],
        )
      ),

    );
  }
}
