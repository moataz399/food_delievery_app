import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:food_delievery_app/app_router.dart';
import 'package:food_delievery_app/controllers/recommended_food_controller.dart';
import 'package:food_delievery_app/models/recommended_model.dart';
import 'package:food_delievery_app/presentation/screens/food/expandable_text.dart';
import 'package:food_delievery_app/presentation/widgets/app_icon.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:food_delievery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../../constants/strings.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  const   RecommendedFoodDetails({Key? key,required this.pageId}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    RecommendedProductsModel  product = Get.find<RecommendedFoodController>().recommendedProductList[pageId];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.mainColor,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: (){
                  Get.toNamed(AppRouter.getInitial());
                },child: AppIcon(icon: Icons.clear)),
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
                  text:product.name!,
                  size: Dimensions.font26,
                )),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppStrings.appBaseUrl+AppStrings.uploadUrl+product.img!,
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
                    text:product.description!,
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
                BigText(text: '\$ ${product.price} '+' X '+' 0',color: AppColors.mainColor,size: Dimensions.font26,),
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
                Flexible(
                  child: Container(
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
                      text: '\$${product.price} | Add to cart ',
                      color: Colors.white,
                    ),
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
