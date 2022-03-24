import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delievery_app/constants/strings.dart';
import 'package:food_delievery_app/controllers/popular_product_controller.dart';
import 'package:food_delievery_app/controllers/recommended_food_controller.dart';
import 'package:food_delievery_app/models/product_models.dart';
import 'package:food_delievery_app/models/recommended_model.dart';
import 'package:food_delievery_app/utils/colors.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/presentation/widgets/icon_and_text.dart';
import 'package:food_delievery_app/presentation/widgets/small_text.dart';
import 'package:food_delievery_app/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../widgets/rate_container.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Slider section
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return popularProduct.isLoaded ? Container(
            height: Dimensions.pageView,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
            ),
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProduct.popularProductList.isEmpty
                    ? 1
                    : popularProduct.popularProductList.length,
                itemBuilder: (context, index) => _buildPageItem(
                    index, popularProduct.popularProductList[index])),
          ):CircularProgressIndicator(color: AppColors.mainColor,) ;
        }),
        GetBuilder<PopularProductController>(builder: (popularProduct) {
          return DotsIndicator(
            dotsCount: popularProduct.popularProductList.isEmpty
                ? 1
                : popularProduct.popularProductList.length,
            position: currPageValue,
            decorator: DotsDecorator(
              color: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(
                text: 'Recommended',
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: 'Food Pairing',
                ),
              )
            ],
          ),
        ),
       GetBuilder<RecommendedFoodController>(builder: (recommendedProduct ){
         return recommendedProduct.isLoaded?  ListView.builder(
             physics: const NeverScrollableScrollPhysics(),
             shrinkWrap: true,
             itemCount: recommendedProduct.recommendedProductList.isEmpty? 1 : recommendedProduct.recommendedProductList.length,
             itemBuilder: (context, index) => _buildListViewItem(index, recommendedProduct.recommendedProductList[index])):CircularProgressIndicator(color: AppColors.mainColor);
       })
      ],
    );
  }

  Widget _buildPageItem(int index, PopularProductsModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();

    if (index == currPageValue.floor()) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == currPageValue.floor() - 1) {
      var currScale = 1 - (currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = .8;
      var currTrans = _height * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      appBaseUrl + '/uploads/' + popularProduct.img!),
                )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewText,
              margin: EdgeInsets.only(
                left: Dimensions.width30,
                right: Dimensions.width30,
                bottom: Dimensions.height30,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),
                child: RateContainer(
                  text: popularProduct.name!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListViewItem(int index,RecommendedProductsModel recommendedProduct) {
    return Row(
      children: [
        //image section
        Container(
          margin: EdgeInsets.only(
              bottom: Dimensions.width10,
              left: Dimensions.width20,
              right: Dimensions.width20),
          width: Dimensions.listViewImgSize,
          height: Dimensions.listViewImgSize,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              image:  DecorationImage(
                  image:NetworkImage(appBaseUrl +"/uploads/"+recommendedProduct.img! ),
                  fit: BoxFit.cover)),
        ),
        //text section
        Expanded(
          child: Container(
              height: Dimensions.listViewTextContSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    bottomRight: Radius.circular(Dimensions.radius20)),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                child: RateContainer(text: recommendedProduct.name!),
              )),
        )
      ],
    );
  }
}
