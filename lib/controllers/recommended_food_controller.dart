import 'package:food_delievery_app/data/repository/recommended_food_repo.dart';
import 'package:get/get.dart';
import '../models/product_models.dart';

class RecommendedFoodController extends GetxController{


  final RecommendedFoodRepo recommendedFoodRepo;

  RecommendedFoodController({required this.recommendedFoodRepo, RecommendedFoodRepo});

  List<dynamic> _recommendedList = [];

  List<dynamic> get recommendedProductList => _recommendedList;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedFoodRepo.getRecommendedFoodList();
    if (response.statusCode == 200) {
      _recommendedList = [];
      _recommendedList.addAll(Product.fromJson(response.body).products);
      _isLoaded=true;
      update();
    } else {
      print(" status code = ${response.statusCode}");
      print(' recommended products error ');
    }
  }
}