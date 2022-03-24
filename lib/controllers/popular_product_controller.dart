import 'package:food_delievery_app/data/repository/popular_product_repo.dart';
import 'package:food_delievery_app/models/product_models.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularList = [];

  List<dynamic> get popularProductList => _popularList;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularList = [];
      _popularList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print(" status code = ${response.statusCode}");
      print('popular products error ');
    }
  }
}
