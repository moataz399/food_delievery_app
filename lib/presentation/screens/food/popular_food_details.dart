import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/app_router.dart';
import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:food_delievery_app/models/product_models.dart';
import 'package:food_delievery_app/presentation/screens/home/main_food_page.dart';
import 'package:food_delievery_app/presentation/widgets/app_icon.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/presentation/widgets/rate_container.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:food_delievery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/cart_controller.dart';
import 'expandable_text.dart';

class PopularFoodDetails extends StatelessWidget {
  int pageId;

  PopularFoodDetails({required this.pageId});

  @override
  Widget build(BuildContext context) {
    PopularProductsModel product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(Get.find<CartController>());

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
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(AppStrings.appBaseUrl +
                      AppStrings.uploadUrl +
                      product.img!),
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
                GestureDetector(
                    child: AppIcon(icon: Icons.arrow_back),
                    onTap: () {
                      Get.toNamed(AppRouter.getInitial());
                    }),
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
                      text: product.name!,
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
                            child: ExpandableText(text: product.description!))),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
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
                      onPressed: () {
                        popularProduct.setQuantity(false);
                      },
                      icon: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(
                      text: popularProduct.quantity.toString(),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    IconButton(
                      onPressed: () {
                        popularProduct.setQuantity(true);
                      },
                      icon: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
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
                  child: GestureDetector(
                    onTap: (){
                      popularProduct.addItem(product);
                    },
                    child: BigText(
                      text: '\$${product.price} | Add to cart ',
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
