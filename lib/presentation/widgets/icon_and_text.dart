import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/widgets/small_text.dart';
import 'package:food_delievery_app/utils/dimensions.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  IconTextWidget(
      {required this.icon, required this.iconColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.iconsSize24,
        ),
        const SizedBox(
          width: 5,
        ),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
