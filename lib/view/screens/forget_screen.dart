import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/view/screens/register_Screen.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/custem_appbar.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvaider>(
      builder: (context,provider,x) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: provider.forgetPasswordkey,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CustemAppBar(),
                        SizedBox(
                          height: 160.h,
                          child: Align(
                            alignment: Alignment.center,
                            child:Container(
                                decoration: BoxDecoration(

                                ),

                                child:Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ),

                          ),
                        ),

                        SizedBox(
                          height: 200.h,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26.withOpacity(.1),
                                        offset: Offset(7,15),
                                        blurRadius: 15,
                                      )
                                    ]
                                ),

                                child: Image.asset('assets/images/forgot-password.png',height: 65.h,)),

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
                    SizedBox(height: 60.h,),
                    Text(
                      'Please enter your email and we will send \nyou a link to return to your account',
                      style: TextStyle(
                        fontFamily: 'Montserrat-Medium',
                        fontSize: 15.sp,
                        color: const Color(0xb2161f3d),
                        height: 1.5.h,
                      ),
                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 25.h,),

                    Padding(
                      padding:  EdgeInsets.only(left: 20,right: 20),
                      child: TextFormField(
                        controller: provider.emailController,
                        validator: (x) => provider.emailvaliation(x!),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                            labelText: 'EMAIL ADDRESS',
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 17.sp,
                              color:  Colors.blueGrey,
                              letterSpacing: 1,
                              height: 1,
                            ),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 12.sp,
                              color: const Color(0x80161f3d),
                              letterSpacing: 1,
                              height: 1,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Icon(Icons.email_outlined,size: 30.sp,),
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.black),
                              gapPadding: 3,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.black),
                              gapPadding: 3,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(28),
                              borderSide: BorderSide(color: Colors.grey),
                              gapPadding: 3,
                            ),
                            suffixIconColor: Colors.grey

                        ),
                      ),
                    ),

                    SizedBox(height: 100.h,),
                    InkWell(
                      onTap: (){
                        provider.forgetPassword();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 315.w,
                        height: 52.h,
                        decoration: BoxDecoration(
                            color: MainColor,
                            borderRadius: BorderRadius.circular(5)

                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Montserrat-Medium',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xffffffff),
                            letterSpacing: 0.5333333129882812,
                            height: 1.25,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    NoAccountText(),
                    SizedBox(
                      height: 152.h,
                      child: Align(alignment: Alignment.bottomRight,child: Image.asset("assets/images/Scroll Group 1.png")),
                    )






                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don’t have an account? ",
          style: TextStyle(fontSize: 16.sp),
        ),
        GestureDetector(
          onTap: () {
            return AppRouter.NavigateWithReplacemtnToWidget(RegisterScreen());
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 16.sp,
                color: MainColor
            ),
          ),
        ),
      ],
    );
  }
}


