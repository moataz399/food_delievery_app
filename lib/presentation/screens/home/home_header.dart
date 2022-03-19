import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        margin: EdgeInsets.only(
            top: Dimensions.height45, bottom: Dimensions.height15),
        padding: EdgeInsets.only(
            left: Dimensions.width20, right: Dimensions.width20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BigText(
                  text: 'egypt',
                  color: AppColors.mainColor,
                ),
                SmallText(
                  text: 'damietta',
                  color: Colors.black54,
                )
              ],
            ),
            Center(
              child: Container(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: Dimensions.iconsSize24,
                ),
                width: Dimensions.height45,
                height: Dimensions.height45,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius:
                  BorderRadius.circular(Dimensions.radius15),
                ),
              ),
            )
          ],
        ));
  }
}
