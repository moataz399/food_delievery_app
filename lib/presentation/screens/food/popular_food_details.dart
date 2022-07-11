import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/app_router.dart';
import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:food_delievery_app/models/product_models.dart';
import 'package:food_delievery_app/presentation/screens/cart/cart_page.dart';
import 'package:food_delievery_app/presentation/widgets/app_icon.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/presentation/widgets/rate_container.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:food_delievery_app/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controllers/cart_controller.dart';
import '../../widgets/expandable_text.dart';

class PopularFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;

  PopularFoodDetails({required this.pageId, required this.page});

  @override
  Widget build(BuildContext context) {
    ProductsModel product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

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
                      if (page == "cartPage") {
                        Get.toNamed(AppRouter.getCartPage());
                      } else {
                        Get.toNamed(AppRouter.getInitial());
                      }
                    }),
                GetBuilder<PopularProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1)
                        Get.toNamed(AppRouter.cartPage);
                    },
                    child: Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart,
                        ),
                        controller.totalItems >= 1
                            ? Positioned(
                                right: 0,
                                top: 0,
                                child: AppIcon(
                                  size: 20,
                                  icon: Icons.circle,
                                  iconColor: Colors.transparent,
                                  backGroundColor: AppColors.mainColor,
                                ),
                              )
                            : Container(),
                        Get.find<PopularProductController>().totalItems >= 1
                            ? Positioned(
                                right: 3,
                                top: 3,
                                child: BigText(
                                  text: Get.find<PopularProductController>()
                                      .totalItems
                                      .toString(),
                                  size: 12,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  );
                }),
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
          GetBuilder<PopularProductController>(builder: (controller) {
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
                        controller.setQuantity(false);
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
                      text: controller.inCartItems.toString(),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    IconButton(
                      onPressed: () {
                        controller.setQuantity(true);
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
                    onTap: () {
                      controller.addItem(product);
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
