import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/widgets/small_text.dart';

import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';
class RateContainer extends StatelessWidget {
  const RateContainer({Key? key,required this.text}) : super(key: key);
  final String  text;



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text:text,),
        SizedBox(
          height: Dimensions.height10,
        ),

        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconTextWidget(
                icon: Icons.circle_sharp,
                iconColor: AppColors.iconColor1,
                text: 'normal'),
            IconTextWidget(
                icon: Icons.location_on,
                iconColor: AppColors.mainColor,
                text: '1.7km'),
            IconTextWidget(
                icon: Icons.access_time_rounded,
                iconColor: AppColors.iconColor2,
                text: '32 min'),
          ],
        )
      ],
    );
  }
}
