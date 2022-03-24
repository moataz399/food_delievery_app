import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/widgets/app_icon.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/presentation/widgets/rate_container.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:food_delievery_app/utils/dimensions.dart';

import 'expandable_text.dart';

class FoodDetails extends StatelessWidget {
  const FoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                height: Dimensions.height350,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/food1.jpg'),
                  fit: BoxFit.cover,
                )),
              )),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back),
                AppIcon(icon: Icons.shopping_cart_checkout_outlined),
              ],
            ),
          ),
          Positioned(
            top: Dimensions.height350 - 20,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      Dimensions.radius20,
                    ),
                    topLeft: Radius.circular(
                      Dimensions.radius20,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RateContainer(
                      text: 'Burger',
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: 'Introduce'),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableText(
                                text:
                                    'moayazxasdlfml;msdfadsfsdfsfsdfasdfssssssssssssssssssssssssssssssssssssssssssssssslmkdjfsjfsdkafasdfkjsafnsdfnsjsnmsvjskskfjfsfjksfjjffasfjsdkfjjaasdfjklkjskfjsdjkasjgkdflgdfkglkdflgkdlfkgldkfgldkfglkdflgkdlfkgldkgldfkgsd;flk'))),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20),
              topLeft: Radius.circular(Dimensions.radius20)),
          color: AppColors.buttonBackgroundColor,
        ),
        height: Dimensions.height120,
        padding: EdgeInsets.only(
            top: Dimensions.height30,
            bottom: Dimensions.height30,
            left: Dimensions.width20,
            right: Dimensions.width20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove,
                      color: AppColors.signColor,
                    ),
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  BigText(
                    text: '0',
                  ),
                  SizedBox(
                    width: Dimensions.width10 / 2,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: AppColors.signColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20,
                  bottom: Dimensions.height20),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: BigText(
                text: '\$10| Add to cart ',
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
