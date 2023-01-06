import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/view/widgets/constans.dart';


class CustomDialog extends StatelessWidget {

  String v;
  CustomDialog(this.v);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context,v),
    );
  }

  _buildChild(BuildContext context,String v) => Container(
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
          child: Text(v, style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        ),
        SizedBox(height: 35,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('No',style: TextStyle(color:Colors.white ),)),
            SizedBox(width: 8,),
            ElevatedButton(onPressed: (){
              SystemNavigator.pop();

            }, child: Text('Yes',style: TextStyle(color:Colors.redAccent ),),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            )
          ],
        )
      // RaisedButton(onPressed: (){
      //   AppRouter.popraoter();
      // }, child: Text('back'), color: Colors.white, textColor: Colors.redAccent,)

      ],
    ),
  );
}

class Diloge {
  static show(String v){
    return showDialog(context: AppRouter.navKey.currentContext!, builder: (context){
      return CustomDialog(v);
    });
  }
}


