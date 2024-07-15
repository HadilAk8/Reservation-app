import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/controllers/popular_product_controller.dart';
import 'package:test/controllers/reservation_controller.dart';
import 'package:test/controllers/table_res_controller.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<ProductController>().getProductList();
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<ReservationController>().getReservationList();
    await Get.find<TableResController>().getTableList();
    await Get.find<CartController>().getCartElement();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(Duration(seconds: 3), () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(scale: animation, 
          child: Center(child: Image.asset("assets/image/logo2l.png",width: Dimensions.width250,))
          ),
          Center(child: Image.asset("assets/image/The_best_food-removebg-preview.png", width: Dimensions.width400,)),
        ],
      ),
    );
  }
}