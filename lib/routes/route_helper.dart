import 'package:get/get.dart';
import 'package:test/pages/cart/cart_page.dart';
import 'package:test/pages/food/category_products_detail.dart';
import 'package:test/pages/food/popular_food_detail.dart';
import 'package:test/pages/food/recommended_food_detail.dart';
import 'package:test/pages/home/home_page.dart';
import 'package:test/pages/home/main_food_page.dart';
import 'package:test/pages/reservation/cal_res_page.dart';
import 'package:test/pages/reservation/confarmation_page.dart';
import 'package:test/pages/reservation/reser_page.dart';
import 'package:test/pages/reservation/table_res_page.dart';
import 'package:test/pages/splash/splash_page.dart';
import 'package:test/pages/account/auth/sign_in_page.dart';


class RouteHelper{
  static const String splashPage = "/splash_page"; 
  static const String initial ="/";
  static const String categoryFood ="/category_food";
  static const String popularFood ="/popular_food";
  static const String recommendedFood ="/recommended_food";
  static const String cartPage = "/cart_page";
  static const String calResPage = "/cal_res_page";
  static const String resPage = "/res_page";
  static const String tableResPage = "/_table_res_page";
  static const String signIn = "/sign-in";
  static const String confarmation = "/conformation";
  static const String menuPage = "/Menu";

  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getCategoryFood(int pageId , String page )=>'$categoryFood?pageId=$pageId&page=$page';
  static String getPopularFood(int pageId , String page , int catId)=>'$popularFood?pageId=$pageId&page=$page&catId=$catId';
  static String getRecommendedFood(int pageId , String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage(String page)=>'$cartPage?page=$page';
  static String getCalResPage()=>'$calResPage';
  static String getCResPage()=>'$resPage';
  static String getTableResPage()=>'$tableResPage';
  static String getSignInPage()=>'$signIn';
  static String getConfarmationPage()=>'$confarmation';
  static String getMenuPage()=>'$menuPage';

  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name:initial , page:()=>HomePage()),
    GetPage(name:menuPage , page:()=>MainFoodPage()),
    GetPage(name: signIn, page: ()=>SignInPage(), transition: Transition.fade),
    GetPage(name: confarmation, page: ()=>ConfarmationPage(), transition: Transition.fade),

    GetPage(name:categoryFood ,page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return CategoryProductsDetail(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name:popularFood ,page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      var catId = Get.parameters['catId'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page:page! , catId: int.parse(catId!) );
    },
      transition: Transition.fadeIn,
    ),

    GetPage(name:recommendedFood ,page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendedFoodDetail(pageId: int.parse(pageId!), page:page!);
    },
      transition: Transition.fadeIn,
    ),
    GetPage(name:cartPage, page: () {
      var page = Get.parameters['page'];
      return CartPage(page:page!);
    },
    transition: Transition.fadeIn,
    ),
    GetPage(name:calResPage, page: () {
      return CalResPage();
    },
    transition: Transition.fadeIn,
    ),
    GetPage(name:resPage, page: () {
      return ResarvationPage();
    },
    transition: Transition.fadeIn,
    ),
    GetPage(name:tableResPage, page: () {
      return TableResPage();
    },
    transition: Transition.fadeIn,
    ),
  ];
}