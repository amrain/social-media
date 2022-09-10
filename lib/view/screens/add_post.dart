import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:provider/provider.dart';
import 'package:social_media/model/post_model.dart';
import 'package:social_media/navigation/router.dart';
import 'package:social_media/provider/auth_provaider.dart';
import 'package:social_media/provider/post_provider.dart';
import 'package:social_media/view/screens/nav_bar.dart';
import 'package:social_media/view/widgets/constans.dart';
import 'package:social_media/view/widgets/custem_textfild.dart';


class AddPostScreen extends StatefulWidget {
  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // clearTextField(){
  // String selectedCategory = "Select category";
  @override




  @override
  Widget build(BuildContext context) {
    // clearTextField();
    return Consumer2<AuthProvaider,PostProvider>(
        builder: (context,provider,provider2,x) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MainColor,
              title: Text('Add Post',style: TextStyle(
              ),),
              centerTitle: true,
              leading: IconButton(

                icon: Icon(Icons.arrow_back), onPressed: () {
                controller.index = (0);
                provider2.selectedImage = null;
                provider2.postDescriptionController.clear();

              },),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: provider2.postdKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20,top: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text('Add Image',style: TextStyle(
                              fontSize: 25.sp,
                              // color:kPrimaryColor,

                            ),textAlign: TextAlign.start,),
                          ),
                        ),
                        // SizedBox(height: .h,),
                        GestureDetector(
                          onTap: (){
                            provider2.selecteImageFun();
                          } ,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150.h,
                              width: 360.w,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                                color: Colors.grey,


                              ),
                              child: provider2.selectedImage == null?
                              Icon(Icons.add_a_photo_outlined,size: 25.sp,)
                                  :Image.file(provider2.selectedImage!)
                              ,
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h,),

                        TextFieldAuthWidget(

                          hintText: 'write something...',
                          suffix: Icon(Icons.drive_file_rename_outline),
                          controller: provider2.postDescriptionController,
                          validator: provider2.nullvaliation,
                        ),


                        InkWell(
                          onTap: () async {
                            // await provider2.addNewPost(provider.appUser!.id!);
                            // await Diloge.show("Category added");
                            // provider.categoryNameController.clear();
                            DataPost dataPost = DataPost(
                              text: provider2.postDescriptionController.text,
                              publishDate: DateTime.now().toString(),
                              owner: Owner(
                                id: provider.appUser!.id,
                                picture: provider.appUser!.image,
                                firstName: provider.appUser!.userName.split(" ")[0],
                                lastName:  provider.appUser!.userName.split(" ")[1],
                              )

                            );
                            provider2.addNewPost(dataPost);


                          },
                          child: Container(
                            height: 50.h,
                            width: 250.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: MainColor,
                              borderRadius: BorderRadius.circular(7.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  offset: Offset(0, 3),
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: Text('Add Post',style: TextStyle(fontSize: 25.sp,color: Colors.white),),
                          ),
                        ),

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



