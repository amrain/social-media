import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/chat_helper.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';
import 'package:social_media/model/Firebase/chat_message.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/chat_provider.dart';
import 'package:social_media/view/screens/edit_screen.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/custom_dialog.dart';

import '../widgets/menu_list1/menu_items.dart';
import '../widgets/menu_list1/one_item.dart';

class ChatScreen extends StatefulWidget {
   ChatScreen(this.otherUser);
   AppUser otherUser;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ValueNotifier<TextDirection> _textDir = ValueNotifier(TextDirection.ltr);
  ScrollController scrollController = ScrollController();
  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.minScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  void _scrollDown1() {
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<ChatProvider>(
      builder: (context,provider,x) {
        return Scaffold(
          backgroundColor: Color(0xffFBFCFE),
          body: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                 Container(
                   // color: MainColor.withOpacity(.1),
                   color: Colors.white,
                     height: MediaQuery.of(context).size.height,
                     width: MediaQuery.of(context).size.width,
                      ),
                 SvgPicture.asset("assets/images/logo.svg",height: 130.h,),


                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2,
                          blurStyle: BlurStyle.inner,
                          offset: Offset(-1,.5)
                          )
                        ],
                        color: Colors.white,

                      ),
                      padding: EdgeInsets.symmetric(horizontal:19,vertical: 10 ),
                      child: Row(
                        children: [

                          InkWell(
                            onTap: (){
                              AppRouter.popraoter();
                            },
                              child: Icon(Icons.arrow_back_ios,color: MainColor,)),
                          SizedBox(width: 10.w,),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 23.r,
                                backgroundColor: MainColor,
                              ),
                              CircleAvatar(
                                radius: 22.r,
                                backgroundImage: NetworkImage(widget.otherUser.image??"https://raw.githubusercontent.com/flutter-devs/flutter_profileview_demo/master/assets/images/as.png"),
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w,),
                          Text.rich(
                            TextSpan(
                              children:[
                                TextSpan(
                                  text:widget.otherUser.userName+"\n",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-Medium',
                                    fontSize: 16.sp,
                                    color: const Color(0xcc161f3d),
                                  ),
                                ),
                                TextSpan(
                                  text:"online",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 12.sp,
                                    color: Colors.green,
                                  )
                                )
                              ]
                            )
                          ),
                          const Spacer(),
                          // InkWell(
                          //   onTap: (){
                          //     provider.deletMessage(widget.otherUser.id??"");
                          //   },
                          //     child: Icon(Icons.more_vert,color: MainColor,size: 25.sp,))

                          Container(
                              child: PopupMenuButton<OneItem>(
                                padding:const EdgeInsets.all(1),
                                icon: Icon(Icons.more_vert,color: MainColor,),
                                onSelected: (item) => onSelected(context,item),
                                itemBuilder: (contxt){
                                  return [
                                    ...MenuItems.firstItems.map(buildItem).toList(),
                                    // PopupMenuDivider(),
                                    // ...MenuItems.SecundItems.map(buildItem).toList()

                                  ];
                                },

                              )
                          )

                        ],
                      ),

                    ),
                    Expanded(
                        child:StreamBuilder<List<ChatMessage>>(
                          stream: ChatHelper.chatHelper.getAllMessage(widget.otherUser.id!),
                          builder: (contxt,snapshot) {
                            List<ChatMessage>? list = snapshot.data?.reversed.toList();
                            return ListView.builder(
                              reverse: true,
                              controller: scrollController,
                                itemCount: list?.length??0,
                                itemBuilder: (context, index) {
                              return list![index].isFromMe
                                  ?ChatBubble(
                                clipper:   ChatBubbleClipper5(type: BubbleType.sendBubble),
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(right: 6,bottom: 5,top: 1),
                                backGroundColor: MainColor,
                                child: InkWell(
                                  onLongPress: (){
                                    showDialog(context: context, builder: (context){
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16)
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        child: Container(
                                          height: 180,
                                          decoration: BoxDecoration(
                                              color: MainColor,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.all(Radius.circular(12))
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              // Container(
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.all(12.0),
                                              //     child: Image.asset('assets/images/sad.png', height: 120, width: 120,),
                                              //   ),
                                              //   width: double.infinity,
                                              //   decoration: BoxDecoration(
                                              //       color: Colors.white,
                                              //       shape: BoxShape.rectangle,
                                              //       borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                              //   ),
                                              // ),
                                              SizedBox(height: 24,),
                                              // Text(v, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                                              SizedBox(height: 8,),
                                              Padding(
                                                padding: const EdgeInsets.only(right: 16, left: 16),
                                                child: Text("Do you want to delete the message?", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                              ),
                                              SizedBox(height: 35,),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  FlatButton(onPressed: ()async{
                                                    Navigator.of(context).pop();

                                                    await provider.deletMessage(widget.otherUser.id!,list[index].id!);

                                                  }, child: Text('Yes'),textColor: Colors.white,),
                                                  SizedBox(width: 8,),
                                                  RaisedButton(onPressed: (){
                                                    Navigator.of(context).pop();

                                                  }, child: Text('No'), color: Colors.white, textColor: Colors.redAccent,)
                                                ],
                                              )
                                              // RaisedButton(onPressed: (){
                                              //   AppRouter.popraoter();
                                              // }, child: Text('back'), color: Colors.white, textColor: Colors.redAccent,)

                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                    // provider.deletMessage(widget.otherUser.id!,list[index].id!);
                                    print("iug");
                                  },
                                  child:(list[index].content == null)
                                      ? Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Image.network(list[index].imageurl!)
                                  )
                                      :Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Text(
                                      list[index].content??"",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                                  :ChatBubble(
                                clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 6,bottom: 5,top: 1),
                                backGroundColor: Colors.grey.shade100,
                                child: InkWell(
                                  // onLongPress: (){
                                  //   showDialog(context: context, builder: (context){
                                  //     return Dialog(
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.circular(16)
                                  //       ),
                                  //       elevation: 0,
                                  //       backgroundColor: Colors.transparent,
                                  //       child: Container(
                                  //         height: 180,
                                  //         decoration: BoxDecoration(
                                  //             color: MainColor,
                                  //             shape: BoxShape.rectangle,
                                  //             borderRadius: BorderRadius.all(Radius.circular(12))
                                  //         ),
                                  //         child: Column(
                                  //           children: <Widget>[
                                  //             // Container(
                                  //             //   child: Padding(
                                  //             //     padding: const EdgeInsets.all(12.0),
                                  //             //     child: Image.asset('assets/images/sad.png', height: 120, width: 120,),
                                  //             //   ),
                                  //             //   width: double.infinity,
                                  //             //   decoration: BoxDecoration(
                                  //             //       color: Colors.white,
                                  //             //       shape: BoxShape.rectangle,
                                  //             //       borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                                  //             //   ),
                                  //             // ),
                                  //             SizedBox(height: 24,),
                                  //             // Text(v, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                                  //             SizedBox(height: 8,),
                                  //             Padding(
                                  //               padding: const EdgeInsets.only(right: 16, left: 16),
                                  //               child: Text("Do you want to delete the message?", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                  //             ),
                                  //             SizedBox(height: 35,),
                                  //             Row(
                                  //               mainAxisSize: MainAxisSize.min,
                                  //               children: <Widget>[
                                  //                 FlatButton(onPressed: ()async{
                                  //                   Navigator.of(context).pop();
                                  //
                                  //                   await provider.deletMessage(widget.otherUser.id!,list[index].id!);
                                  //
                                  //                 }, child: Text('Yes'),textColor: Colors.white,),
                                  //                 SizedBox(width: 8,),
                                  //                 RaisedButton(onPressed: (){
                                  //                   Navigator.of(context).pop();
                                  //
                                  //                   }, child: Text('No'), color: Colors.white, textColor: Colors.redAccent,)
                                  //               ],
                                  //             )
                                  //             // RaisedButton(onPressed: (){
                                  //             //   AppRouter.popraoter();
                                  //             // }, child: Text('back'), color: Colors.white, textColor: Colors.redAccent,)
                                  //
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     );
                                  //   });
                                  //   // provider.deletMessage(widget.otherUser.id!,list[index].id!);
                                  //   print("iug");
                                  // },
                                  child: (list[index].content == null)
                                      ? Container(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width * 0.7,
                                      ),
                                      child: Image.network(list[index].imageurl!)
                                  )
                                      :Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Text(
                                      list[index].content??"",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                              );

                            });
                          },
                        )
                    ),
                    // const SizedBox(height: 5,),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      // height: 70.h ,
                      color:  Colors.white,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: ()async{
                             await provider.selecteImageFun();
                              await provider.uploadImage();
                             await  provider.sendImage(widget.otherUser.id!);
                            },

                              child: Icon(Icons.add,color: MainColor ,size: 32,)),
                          SizedBox(width: 5,),
                          Expanded(

                            child: ValueListenableBuilder<TextDirection>(
                              valueListenable: _textDir,
                              builder: (context, value, child) =>
                               TextField(
                                 maxLines: null,
                                 controller: provider.messagecontroller,
                                keyboardType: TextInputType.text,
                              textAlignVertical: TextAlignVertical.top,
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
                          SizedBox(width: 5,),
                          InkWell(
                            onTap:(){
                              provider.sendMessage(widget.otherUser.id!);
                              _scrollDown();
                            },
                            child: Icon(
                              Icons.send,color: MainColor,size: 35.sp,),
                          )
                        ],
                      ),
                    )


                  ],
                ),
              ],
            ),
          ),

        );
      }
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
      case MenuItems.itemDelet: Provider.of<ChatProvider>(AppRouter.navKey.currentContext!,listen: false).deletChate(widget.otherUser.id!);break;
      case MenuItems.itemlogOut: Provider.of<AuthProvaider>(context,listen: false).signOut();;break;

    }


  }
}
