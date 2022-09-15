import 'package:flutter/material.dart';

import 'package:social_media/view/widgets/menu_list1/one_item.dart';

class MenuItems{

  static const List firstItems = [
    itemDelet,
  ];
  static const List SecundItems = [
    itemlogOut
  ]
  ;
  static const itemDelet = OneItem(text: "Delet Chat", icon: Icon(Icons.delete,color: Colors.red,),);
  static const itemlogOut = OneItem(text: "logOut", icon: Icon(Icons.logout));


}