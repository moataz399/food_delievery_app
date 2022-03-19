import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/screens/food/expandable_text.dart';
import 'package:food_delievery_app/presentation/widgets/app_icon.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:food_delievery_app/utils/dimensions.dart';

class RecommendedFoodDetails extends StatefulWidget {
  const RecommendedFoodDetails({Key? key}) : super(key: key);

  @override
  State<RecommendedFoodDetails> createState() => _RecommendedFoodDetailsState();
}

class _RecommendedFoodDetailsState extends State<RecommendedFoodDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.mainColor,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: Center(
                    child: BigText(
                  text: ' moataz mohamed',
                  size: Dimensions.font26,
                )),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/images/food1.jpg',
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                  left: Dimensions.width10,
                  right: Dimensions.width10,
                  bottom: Dimensions.height20),
              child: Column(
                children: [
                  ExpandableText(
                    text:
                        'moataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz momoataz mohamed refat sdklfjmat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamed refat sdklfjmoataz mohamhamed refat sdklfjmoataz mohamed refat sdklfj',
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: Dimensions.width20*2.5,
                right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    icon: Icons.remove,
                    iconColor: Colors.white,
                    backGroundColor: AppColors.mainColor,
                    iconsSize: Dimensions.iconsSize24),
                BigText(text: '\$ 12 '+' X '+' 0',color: AppColors.mainColor,size: Dimensions.font26,),
                AppIcon(
                    icon: Icons.add,
                    iconColor: Colors.white,
                    backGroundColor: AppColors.mainColor,
                    iconsSize: Dimensions.iconsSize24),
              ],
            ),
          ),
          Container(
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
                  child: Icon(Icons.favorite,color: AppColors.mainColor,),
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
                    text: '\$12| Add to cart ',
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
