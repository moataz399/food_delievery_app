import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final String text;
  Color? color;
  double size;
  double height;
  SmallText(
      {Key? key,
        required this.text,
      this.height=1.2,
        this.color= const Color(0xFFccc7c5),
        this.size = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size==0 ? Dimensions.font12 : size,
      height: height,
          fontWeight: FontWeight.w400),
    );
  }
}
