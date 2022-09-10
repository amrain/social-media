import 'package:flutter/material.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/view/screens/edit_screen.dart';
import 'package:social_media/view/widgets/menu_list/one_item.dart';

class MenuItems{

  static const List firstItems = [
    itemEdit,
  ];
  static const List SecundItems = [
    itemlogOut
  ]
  ;
  static const itemEdit = OneItem(text: "Edit", icon: CircleAvatar(
    //onTap: () {
    //       AppRouter.NavigateToWidget(EditScreen());
    //
    //     },
    backgroundColor: Colors.orangeAccent,
    radius: 13,
    child:  Icon(
      Icons.edit,
      color: Colors.white,
      size: 15,
    ),
  ),);
  static const itemlogOut = OneItem(text: "logOut", icon: Icon(Icons.logout));


}