import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/view/widgets/constans.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProvaider>(context,listen:  false).userNameController.text = Provider.of<AuthProvaider>(context,listen:  false).appUser?.userName??"";
    Provider.of<AuthProvaider>(context,listen:  false).phoneController.text = Provider.of<AuthProvaider>(context,listen:  false).appUser?.phone??"";
    Provider.of<AuthProvaider>(context,listen:  false).emailController.text = Provider.of<AuthProvaider>(context,listen:  false).appUser?.email??"";
    Provider.of<AuthProvaider>(context,listen:  false).cityController.text = Provider.of<AuthProvaider>(context,listen:  false).appUser?.city??"";


  }

  @override

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvaider>(
      builder: (context,provider,x) {
        return WillPopScope(
          onWillPop: (){
            if(Navigator.canPop(context)){
              Navigator.pop(context);
              Provider.of<AuthProvaider>(context,listen:  false).userNameController.clear();
              Provider.of<AuthProvaider>(context,listen:  false).phoneController.clear();
              Provider.of<AuthProvaider>(context,listen:  false).cityController.clear();

              return Future.value(true);
            }else{
              // SystemNavigator.pop();
              print("th");
              return Future.value(false);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Edit profile"),
              backgroundColor: MainColor,
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    height: 200.h,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child: new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 135.h,
                                    height: 135.h,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: NetworkImage(provider.appUser?.image??"https://raw.githubusercontent.com/flutter-devs/flutter_profileview_demo/master/assets/images/as.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),

                            Padding(
                                padding: EdgeInsets.only(top: 85.h, right: 100.0.h),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: ()async{
                                        await provider.selecteImageFun();
                                        await provider.upDateImage();
                                      },
                                      child: new CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )),//update
                          ]),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffFFFFFF),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0.h, right: 25.0.h, ),
                            child:  Text(
                              'Parsonal Information',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Name',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: provider.userNameController,
                                    decoration: const InputDecoration(
                                      hintText: "Enter Your Name",
                                    ),
                                    // enabled: !_status,
                                    // autofocus: !_status,

                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Email ID',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: provider.emailController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Email ID"),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: provider.phoneController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Mobile Number"),
                                    // enabled: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'adress',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: provider.cityController,
                                    decoration: const InputDecoration(
                                        hintText: "Enter your adress"),
                                    // enabled: !_status,
                                  ),
                                ),
                              ],
                            )),
                        _getActionButtons()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  height: 45,
                  child: new RaisedButton(
                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                       Provider.of<AuthProvaider>(context,listen:  false).upDateUser();
                       AppRouter.popraoter();

                      // setState(() {
                      //   _status = true;
                      //   FocusScope.of(context).requestFocus(new FocusNode());
                      // });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  height: 45,
                  child: new RaisedButton(
                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      Provider.of<AuthProvaider>(context,listen:  false).userNameController.clear();
                      Provider.of<AuthProvaider>(context,listen:  false).phoneController.clear();
                      Provider.of<AuthProvaider>(context,listen:  false).cityController.clear();
                      AppRouter.popraoter();


                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }
}
