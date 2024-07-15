import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/controllers/auth_controller.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/controllers/popular_product_controller.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/controllers/table_res_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/data/api/api_client.dart';
import 'package:test/data/repository/auth_repo.dart';
import 'package:test/data/repository/cart_repo.dart';
import 'package:test/data/repository/product_repo.dart';
import 'package:test/data/repository/popular_product_repo.dart';
import 'package:test/data/repository/reservation_repo.dart';
import 'package:test/data/repository/table_repo.dart';
import 'package:test/data/repository/user_repo.dart';
import 'package:test/utils/app_constants.dart';

Future<void> init()async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstant.BASE_URL , sharedPreferences:Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find())); 

  //repos
  Get.lazyPut(() => ProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRapo(sharedPreferences:Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => ReservationRepo(sharedPreferences:Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => TableRepo(apiClient: Get.find()));

  //controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => ProductController(productRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => ReservationController(reservationRepo: Get.find()));
  Get.lazyPut(() => TableResController(tableRepo: Get.find()));
}