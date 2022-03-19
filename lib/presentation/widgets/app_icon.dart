import 'package:flutter/material.dart';
import 'package:food_delievery_app/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backGroundColor;
  final Color iconColor;
  final double size;
  final double iconsSize;

  AppIcon(
      {Key? key,
      required this.icon,
      this.backGroundColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
        this.iconsSize = 16,
      this.size = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(size / 2)),
      child: Icon(icon, color: iconColor, size: iconsSize),
    );
  }
}
