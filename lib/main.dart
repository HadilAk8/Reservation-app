import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/controllers/popular_product_controller.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/controllers/table_res_controller.dart';
import 'package:test/routes/route_helper.dart';
import 'helper/dependencies.dart' as dep;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    Get.find<CartController>().getCartData();//saving data when restart the app
    return GetBuilder<ProductController>(builder: (_){
      return GetBuilder<PopularProductController>(builder: (_){
        return GetBuilder<ReservationController>(builder: (_){
          return GetBuilder<TableResController>(builder: (_){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false  ,
              title: 'Flutter Demo',
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,
            );
          });
        });
      });
    });
    
  }

}