import 'package:flutter/material.dart';

import '../../navigation/router.dart';

class CustomDialog {

  static showDialogfunction(String v){
    showDialog(context: AppRouter.navKey.currentContext!, builder: (context){
    return AlertDialog(
      content: Text(v),
      actions: [
        TextButton(onPressed: (){
          AppRouter.popraoter();
        }, child: Text("OK"),)
      ],
    );
  });
  }


}