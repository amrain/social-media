import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/chat_provider.dart';
import 'package:social_media/view/screens/ViewCodeScreen.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/user_chat_widget.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Inbox',
          style: TextStyle(
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 20.sp,
          ),
        ),

        backgroundColor: MainColor,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Provider.of<AuthProvaider>(context,listen: false).signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body:Consumer<ChatProvider>(
        builder: (context,provider,x) {
          return SafeArea(
            child:(provider.chatUsers == null)
                ?Center(child: CircularProgressIndicator())
                : ListView.builder(
                itemCount: provider.chatUsers!.length,
                itemBuilder: (context, index) {
                return UserChatWidget(provider.chatUsers![index]);

            })
          );
        }
      ),

    );
  }
}
