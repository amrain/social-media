import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_list/chat_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media/data/chat_helper.dart';
import 'package:social_media/model/Firebase/appUser_Model.dart';
import 'package:social_media/model/Firebase/chat_message.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/chat_provider.dart';
import 'package:social_media/view/widgets/constans.dart';

class Test extends StatefulWidget {
  Test(this.otherUser);
  AppUser otherUser;

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final ValueNotifier<TextDirection> _textDir = ValueNotifier(TextDirection.ltr);
  ChatListController chatListController = ChatListController();
  @override
  Widget build(BuildContext context) {

    return Consumer<ChatProvider>(
        builder: (context,provider,x) {
          return Scaffold(
            backgroundColor: Color(0xffFBFCFE),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Center(child:
                  //   ElevatedButton(onPressed: (){
                  //     ChatHelper.chatHelper.getAllMessagejust();
                  //   }, child: Text("click")),),
                  Expanded(
                      child:StreamBuilder<List<ChatMessage>>(
                        initialData: provider.messages,
                        stream: ChatHelper.chatHelper.getAllMessage(widget.otherUser.id!),
                        builder: (contxt,snapshot)  {
                          List<ChatMessage>? list =  snapshot.data?.reversed.toList();
                          print(provider.messages.length);

                          // print(list?.length);
                          // print(provider.messages.length);
                          // if(provider.messages.length == list?.length) {
                          //   provider.num++;
                          //   print(provider.num);
                          // }
                          return ListView.builder(
                              reverse: true,
                              // controller: scrollController,
                              itemCount: list?.length??0,
                              itemBuilder: (context, index) {
                                return list![index].isFromMe
                                    ?ChatBubble(
                                  clipper:   ChatBubbleClipper5(type: BubbleType.sendBubble),
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 20,right: 5),
                                  backGroundColor: MainColor,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Text(
                                      list[index].content??"",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                                    :ChatBubble(
                                  clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 20,left: 5),
                                  backGroundColor: Colors.grey,
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                                    ),
                                    child: Text(
                                      list[index].content??"",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );

                              });
                        },
                      )
                  ),
                  SizedBox(height: 5,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    height:80.h ,
                    color: const Color(0xffBEC4D9).withOpacity(.5),
                    child: Row(
                      children: [
                        Icon(Icons.add,color:Color(0xff161F3D) ,size: 32,),
                        SizedBox(width: 10,),
                        Expanded(
                          child: ValueListenableBuilder<TextDirection>(
                            valueListenable: _textDir,
                            builder: (context, value, child) =>
                                TextField(
                                  maxLines: null,
                                  expands: true,
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
                                        color: const Color(0xcc161f3d).withOpacity(.5),
                                      ) ,
                                      fillColor: Colors.white,

                                      filled: true,

                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(50),


                                      )

                                  ),

                                ),
                          ),
                        ),
                        SizedBox(width: 10,),

                        InkWell(
                          onTap:(){
                            provider.sendMessage(widget.otherUser.id!);
                            // _scrollDown();
                          },
                          child: CircleAvatar(
                            backgroundColor: MainColor,
                            radius: 23.sp,
                            child: Icon(Icons.send,color: Colors.white,size: 25.sp,),
                          ),
                        )
                      ],
                    ),
                  )
                  // Container(
                  //
                  //   decoration: BoxDecoration(
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: Colors.grey,
                  //           blurRadius: 5,
                  //           offset: Offset(0,1)
                  //       )
                  //     ],
                  //     color: Color(0xffFFFFFF),
                  //
                  //   ),
                  //   padding: EdgeInsets.symmetric(horizontal:19,vertical: 10 ),
                  //   child: Row(
                  //     children: [
                  //
                  //       InkWell(
                  //           onTap: (){
                  //             AppRouter.popraoter();
                  //           },
                  //           child: Icon(Icons.arrow_back_ios,color: Colors.grey,)),
                  //       SizedBox(width: 10.w,),
                  //       CircleAvatar(
                  //         radius: 22.sp,
                  //         backgroundImage: NetworkImage(widget.otherUser.image??"https://raw.githubusercontent.com/flutter-devs/flutter_profileview_demo/master/assets/images/as.png"),
                  //       ),
                  //       SizedBox(width: 10.w,),
                  //       Text.rich(
                  //           TextSpan(
                  //               children:[
                  //                 TextSpan(
                  //                   text:widget.otherUser.userName+"\n",
                  //                   style: TextStyle(
                  //                     fontFamily: 'Montserrat-Medium',
                  //                     fontSize: 16.sp,
                  //                     color: const Color(0xcc161f3d),
                  //                   ),
                  //                 ),
                  //                 TextSpan(
                  //                     text:"online",
                  //                     style: TextStyle(
                  //                       fontFamily: 'Montserrat-Regular',
                  //                       fontSize: 12.sp,
                  //                       color: const Color(0x66161f3d),
                  //                     )
                  //                 )
                  //
                  //
                  //
                  //
                  //               ]
                  //           )
                  //       ),
                  //       Spacer(),
                  //       InkWell(
                  //           onTap: (){
                  //             provider.deletChat(widget.otherUser.id??"");
                  //           },
                  //           child: Icon(Icons.more_vert,color: Colors.grey,))
                  //
                  //     ],
                  //   ),
                  //
                  // ),
                  // // SizedBox(height: 55.h,),
                  // Container(
                  //
                  //   child: Expanded(
                  //       child:StreamBuilder<List<ChatMessage>>(
                  //         stream: ChatHelper.chatHelper.getAllMessage(widget.otherUser.id!),
                  //         builder: (contxt,snapshot) {
                  //           List<ChatMessage>? list = snapshot.data?.reversed.toList();
                  //
                  //           return ChatList(
                  //             msgCount: list?.length ?? 0,
                  //             itemBuilder: (BuildContext context, int index) {
                  //               return list![index].isFromMe
                  //                   ?ChatBubble(
                  //                 clipper:   ChatBubbleClipper5(type: BubbleType.sendBubble),
                  //                 alignment: Alignment.topRight,
                  //                 margin: EdgeInsets.only(top: 20,right: 5),
                  //                 backGroundColor: MainColor,
                  //                 child: Container(
                  //                   constraints: BoxConstraints(
                  //                     maxWidth: MediaQuery.of(context).size.width * 0.7,
                  //                   ),
                  //                   child: Text(
                  //                     list[index].content??"",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                 ),
                  //               )
                  //                   :ChatBubble(
                  //                 clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
                  //                 alignment: Alignment.topLeft,
                  //                 margin: EdgeInsets.only(top: 20,left: 5),
                  //                 backGroundColor: Colors.grey,
                  //                 child: Container(
                  //                   constraints: BoxConstraints(
                  //                     maxWidth: MediaQuery.of(context).size.width * 0.7,
                  //                   ),
                  //                   child: Text(
                  //                     list[index].content??"",
                  //                     style: TextStyle(color: Colors.white),
                  //                   ),
                  //                 ),
                  //               );
                  //             },
                  //             onMsgKey: (int index) => list![index].senderId!,
                  //             controller: chatListController,
                  //             // New message tip
                  //             showReceivedMsgButton: true,
                  //             // onIsReceiveMessage: (int i) => list![i].senderId == MsgType.receive,
                  //
                  //             // Scroll to top
                  //             showScrollToTopButton: true,
                  //           );
                  //
                  //
                  //         },
                  //       )
                  //   ),
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  //   height:65.h ,
                  //   color: const Color(0xffBEC4D9).withOpacity(.5),
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.add,color:Color(0xff161F3D) ,size: 32,),
                  //       SizedBox(width: 10,),
                  //       Expanded(
                  //         child: ValueListenableBuilder<TextDirection>(
                  //           valueListenable: _textDir,
                  //           builder: (context, value, child) =>
                  //               TextField(
                  //                 controller: provider.messagecontroller,
                  //                 keyboardType: TextInputType.text,
                  //                 textAlignVertical: TextAlignVertical.top,
                  //                 textDirection: value,
                  //                 onChanged: (input){
                  //                   if (input.trim().length < 2) {
                  //                     final dir = getDirection(input);
                  //                     if (dir != value) _textDir.value = dir;
                  //                   }
                  //                 },
                  //                 style: TextStyle(
                  //                     fontSize: 20
                  //                 ),
                  //
                  //                 decoration: InputDecoration(
                  //                     hintText: "Aa",
                  //                     hintStyle:TextStyle(
                  //                       fontFamily: 'Montserrat-Regular',
                  //                       fontSize: 15,
                  //                       color: const Color(0xcc161f3d).withOpacity(.5),
                  //                     ) ,
                  //                     fillColor: Colors.white,
                  //
                  //                     filled: true,
                  //
                  //                     border: OutlineInputBorder(
                  //                       borderRadius: BorderRadius.circular(50),
                  //
                  //
                  //                     )
                  //
                  //                 ),
                  //
                  //               ),
                  //         ),
                  //       ),
                  //       SizedBox(width: 10,),
                  //
                  //       InkWell(
                  //         onTap:(){
                  //           provider.sendMessage(widget.otherUser.id!);
                  //           // _scrollDown();
                  //         },
                  //         child: CircleAvatar(
                  //           backgroundColor: MainColor,
                  //           radius: 23.sp,
                  //           child: Icon(Icons.send,color: Colors.white,size: 25.sp,),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )


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
}

// return list![index].isFromMe
//                                           ?ChatBubble(
//                                         clipper:   ChatBubbleClipper5(type: BubbleType.sendBubble),
//                                         alignment: Alignment.topRight,
//                                         margin: EdgeInsets.only(top: 20,right: 5),
//                                         backGroundColor: MainColor,
//                                         child: Container(
//                                           constraints: BoxConstraints(
//                                             maxWidth: MediaQuery.of(context).size.width * 0.7,
//                                           ),
//                                           child: Text(
//                                             list[index].content??"",
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       )
//                                           :ChatBubble(
//                                         clipper: ChatBubbleClipper5(type: BubbleType.receiverBubble),
//                                         alignment: Alignment.topLeft,
//                                         margin: EdgeInsets.only(top: 20,left: 5),
//                                         backGroundColor: Colors.grey,
//                                         child: Container(
//                                           constraints: BoxConstraints(
//                                             maxWidth: MediaQuery.of(context).size.width * 0.7,
//                                           ),
//                                           child: Text(
//                                             list[index].content??"",
//                                             style: TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       );
