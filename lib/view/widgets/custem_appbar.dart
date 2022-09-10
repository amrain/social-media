import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustemAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: custemClass(),
          child: Container(
          height: 200.h,
          width: 400.w,
          decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Color(0xffF0648D),
            Color(0xffEF6089),
            Color(0xffEF5F88),
            Color(0xffEE5E86),
            Color(0xffE9446A),

            ]
          )
          ),
          ),
        ),
        ClipPath(
    clipper: custemClass1(),
       child: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
                    colors: [
                  Color(0xffFBB97A),
                  Color(0xffFCAF7A),
                  Color(0xffFDA77A),
                  Color(0xffFF9E7B),


        ]

)
),
height: 170.h,
width: 400.w,
),
),
        SizedBox(
height: 200.h,
child: Align(
alignment: Alignment.bottomCenter,
child:SvgPicture.asset('assets/images/Blob_BG.svg'),
),
),
      ],
    );
  }
}

class custemClass extends  CustomClipper<Path>{
@override
      Path getClip(Size size) {
var path = Path();
path.lineTo(100.w, 0);
path.quadraticBezierTo(
(size.width / 2.5).w, size.height.h,
size.width.w, (size.height - 20));
path.lineTo(size.width, 0);
path.close();
return path;
}

@override
bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class custemClass1 extends  CustomClipper<Path>{
@override
      Path getClip(Size size) {
  var path = Path();
  path.lineTo(200.w, 0);

    // path.lineTo(0, size.height);
    path.quadraticBezierTo(
    200.w , 150.h, 0,
    size.height - 50
    );


    path.close();
      return path;
}

    @override
    bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

//259
