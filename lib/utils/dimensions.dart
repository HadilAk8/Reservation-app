import "package:get/get.dart";


class Dimensions {

   static double screenHeight = Get.context!.height;
   static double screenWidth = Get.context!.width;

   static double PageView = screenHeight / 2.38;
   static double PageViewContainer = screenHeight / 3.46;
   static double PageViewTextContainer = screenHeight / 6.35;
   
   //dynamic height padding and margin
   static double height5 = screenHeight / 152.4;
   static double height10 = screenHeight / 76.2;
   static double height13 = screenHeight / 58.61;
   static double height15 = screenHeight / 50.8;
   static double height18 = screenHeight / 42.33;
   static double height20 = screenHeight / 38.1;
   static double height30 = screenHeight / 25.4;
   static double height45 = screenHeight / 16.93;
   
  //dynamic widthpadding and margin
   static double width10 = screenHeight / 76.2;
   static double width15 = screenHeight / 47.625;
   static double width20 = screenHeight/ 38.1;
   static double width23 = screenHeight/ 33.13;
   static double width26 = screenHeight/ 29.307;
   static double width30 = screenHeight/25.4;
   static double width96 = screenHeight/7.9375;
   static double width250 = screenHeight/3.048;
   static double width400 = screenHeight/1.905;

  //font size
  static double font13 = screenHeight/58.61;
   static double font15 = screenHeight/50.8;
   static double font16 = screenHeight/50.8;
   static double font20 = screenHeight/38.1;
   static double font24 = screenHeight/31.75;
   static double font26 = screenHeight/29.3;

   //radius
   static double radius15 = screenHeight/50.8;
   static double radius20 = screenHeight/38.1;
   static double radius30 = screenHeight/25.4;

  //icons size 
   static double iconsize24 = screenHeight/31.75;
   static double iconsize16 = screenHeight/47.625;

  //liste view size 
  static double listViewImgSize = screenWidth/3;
  static double listViewTextContSize = screenWidth/3.6;

  //popular food
  static double popularFoodImgSize = screenHeight/2.17;

  //buttom height
  static double bottomHeightBar = screenHeight/6.35 ; 
}