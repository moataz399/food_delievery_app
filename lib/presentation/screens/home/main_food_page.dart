import 'package:flutter/material.dart';
import 'package:food_delievery_app/presentation/screens/home/home_header.dart';
import 'package:food_delievery_app/presentation/widgets/big_text.dart';
import 'package:food_delievery_app/utils/dimensions.dart';

import '../../../utils/colors.dart';
import '../../widgets/small_text.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatelessWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeHeader(),
          Expanded(
            child: SingleChildScrollView(child: FoodPageBody()),
          )
        ],
      ),
    );
  }
}
