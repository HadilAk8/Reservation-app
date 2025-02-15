import 'package:get/get.dart';
import 'package:test/data/repository/popular_product_repo.dart';
import 'package:test/models/products_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});

  List<dynamic> _popularProductList=[];
  List<dynamic> get  popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList()async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode==200){
      _popularProductList=[];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }else{
      print("could not get products Popular");
    }
  }
}