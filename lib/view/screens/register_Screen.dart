import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/view/screens/login_screen.dart';
import 'package:social_media/view/widgets/custem_appbar.dart';

import '../widgets/constans.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvaider>(
      builder: (context,provider,x) {
        return WillPopScope(
          onWillPop: (){
            provider.userNameController.clear();
            provider.cityController.clear();
            provider.passwordController.clear();
            provider.loginKey == null;
            Navigator.pop(context);
            return Future.value(true);
          },
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: provider.registerKey,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              CustemAppBar(),
                              SizedBox(
                                height: 140.h,
                                child: Align(
                                  alignment: Alignment.center,
                                  child:Container(
                                      decoration: BoxDecoration(

                                      ),

                                      child: Text(
                                        'Hello!\nSign up to get started.',
                                        style: TextStyle(
                                          fontFamily: 'Montserrat-Medium',
                                          fontSize: 18,
                                          color: const Color(0xffffffff),
                                          height: 1.5,
                                        ),
                                        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                                        textAlign: TextAlign.center,
                                      )
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
                                              blurRadius: 18,
                                            )
                                          ]
                                      ),

                                      child: Image.asset('assets/images/Profile_main.png',height: 85.sp,)),

                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                child: InkWell(
                                  onTap:(){
                                    provider.userNameController.clear();
                                    provider.cityController.clear();
                                    provider.passwordController.clear();
                                    AppRouter.popraoter();
                                    // Navigator.of(context).
                                  },

                                  child: CircleAvatar(
                                    child: Icon(Icons.arrow_back,color: Colors.white,),
                                    backgroundColor: Color(0xff151630).withOpacity(.1),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 40.h,),


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
                          SizedBox(height: 20.h,),
                          Padding(


                            padding:  EdgeInsets.only(left: 20,right: 20),
                            child: TextFormField(
                              controller: provider.passwordController,
                              validator: (x) => provider.passwrdvaliation(x!),
                              obscureText: true,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 17.sp,
                                    color:  Colors.blueGrey,
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  hintText: "Enter your Password",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 12.sp,
                                    color: const Color(0x80161f3d),
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.password_outlined,size: 25.sp,),
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
                          SizedBox(height: 20.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 20,right: 20),
                            child: TextFormField(
                              controller: provider.userNameController,
                              validator: (x) => provider.nullvaliation(x!),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                                  labelText: 'FULL NAME',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 17.sp,
                                    color:  Colors.blueGrey,
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  hintText: "Enter your name",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 12.sp,
                                    color: const Color(0x80161f3d),
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.person_outline_outlined,size: 30.sp,),
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
                          SizedBox(height: 20.h,),
                          Padding(
                            padding:  EdgeInsets.only(left: 20,right: 20),
                            child: TextFormField(
                              controller: provider.cityController,
                              validator: (x) => provider.nullvaliation(x!),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                                  labelText: 'Address',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 17.sp,
                                    color:  Colors.blueGrey,
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  hintText: "Enter your address",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 12.sp,
                                    color: const Color(0x80161f3d),
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.person_pin_circle,size: 30.sp,),
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
                          SizedBox(height: 20.h,),
                          Padding(


                            padding:  EdgeInsets.only(left: 20,right: 20),
                            child: TextFormField(
                              controller: provider.phoneController,
                              validator: (x) => provider.passwrdvaliation(x!),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),

                                  labelText: 'Phone',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 17.sp,
                                    color:  Colors.blueGrey,
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  hintText: "Enter your Phone",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 12.sp,
                                    color: const Color(0x80161f3d),
                                    letterSpacing: 1,
                                    height: 1,
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.always,
                                  suffixIcon: Icon(Icons.phone,size: 25.sp,),
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


                          SizedBox(height: 30.h,),
                          InkWell(
                                  onTap: (){
                                    provider.register();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 315.w,
                                    height: 52.h,
                                    decoration: BoxDecoration(
                                        color: Color(0xffE9446A),
                                        borderRadius: BorderRadius.circular(5)

                                    ),
                                    child: Text(
                                      'Sign up',
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
                          SizedBox(height: 10.h,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Regular',
                                  fontSize: 15.sp,
                                  color: const Color(0x801d1d26),
                                  letterSpacing: 0.4000000133514404,
                                ),
                                softWrap: false,
                              ),
                              InkWell(
                                onTap:(){
                                  AppRouter.popraoter();
                                },
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 14.sp,
                                    color: const Color(0xffe9446a),
                                    letterSpacing: 0.4000000133514404,
                                  ),
                                  softWrap: false,
                                ),
                              )
                            ],
                          ),




                        ],
                      ),
                      // (provider.isLoad)
                      //     ?SizedBox(
                      //   height: MediaQuery.of(context).size.height,
                      //   child: Center(
                      //     child: CircularProgressIndicator(
                      //       color: MainColor,
                      //     ),
                      //   ),
                      // )
                      //     :SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

