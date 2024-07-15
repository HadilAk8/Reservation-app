import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test/base/show_custom_snackbar.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/controllers/user_controller.dart';
//import 'package:test/pages/home/main_food_page.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/app_constants.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_column.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/expandable_text_widget.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  final int catId;
  const PopularFoodDetail({Key? key , required this.pageId , required this.page , required this.catId}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    var product ;
    
    switch(catId){
      case 0 :
        product = Get.find<ProductController>().productList[pageId];
      break;
      case 1 :
        product = Get.find<ProductController>().producItalList[pageId];
      break;
      case 2 :
        product = Get.find<ProductController>().productJapList[pageId];
      break;
      case 3:
        product = Get.find<ProductController>().productDesList[pageId];
      break;
      default :
        product = Get.find<ProductController>().productDrinList[pageId];
    }
    Get.find<ProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstant.BASE_URL+AppConstant.UPLOAD_URL+product.img!
                  ),
                  ),
              ),
            ),
          ),
          //icon widgets
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    
                    if(page=="cartpage"){
                      Get.toNamed(RouteHelper.getCartPage("food"));
                    }else{
                      Get.toNamed(RouteHelper.getCategoryFood(catId , "page"));
                    }
                  } ,
                  child: 
                    AppIcon(icon: Icons.arrow_back_ios),
                ),

                GetBuilder<ProductController>(builder:(controller){
                  return GestureDetector(
                    onTap: () {
                      
                        Get.toNamed(RouteHelper.getCartPage("food"));
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_checkout_outlined),
                        Get.find<ProductController>().totalItems>=1?
                          Positioned(
                            right: 0, top: 0,
                            child: AppIcon(icon: Icons.circle , size: 20, iconColor: Colors.transparent, backgroundColor:  AppColors.mainColor,),
                                
                          ):
                            Container(),
                        Get.find<ProductController>().totalItems>=1?
                          Positioned(
                            right: 6, top: 1,
                            child: 
                              BigText(text:Get.find<ProductController>().totalItems.toString(),size: 12,color: Colors.white,),
                          ):
                            Container(),
                      ],
                    ),
                  );
                },)

              ],
            ), 
          ),
          //introduction of food
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize-20,
            child:Container(
              padding: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width20 , top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
                
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(text: product.nomP!,),
                  SizedBox(height: Dimensions.height10,),
                  BigText(text: "Introduce"),
                  SizedBox(height: Dimensions.height5,),
                  //expandable text widget 
                  Expanded(
                  child: SingleChildScrollView(
                    child: ExpandableTextWidget(text:product.description!),
                  ),
                  ),
                ],
              ),
            ), 
            ),
          

        ],
      ),
      bottomNavigationBar: GetBuilder<ProductController>(builder: (popularProduct){
        return Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(top: Dimensions.height30 , bottom: Dimensions.height30 , left: Dimensions.width20 , right: Dimensions.width20),
        decoration: BoxDecoration(
          color : AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius20*2),
            topLeft: Radius.circular(Dimensions.radius20*2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimensions.height20 , bottom: Dimensions.height20 , left: Dimensions.width20 , right: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: Colors.white,
              ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    popularProduct.setQuantity(false);
                  },
                  child: Icon(Icons.remove , color: AppColors.signColor,size: Dimensions.font20,),
                ),
                SizedBox(width: Dimensions.width10/2,),
                BigText(text: popularProduct.inCartItem.toString() ,size: Dimensions.font16,),
                SizedBox(width: Dimensions.width10/2,),
                GestureDetector(
                  onTap: () {
                    popularProduct.setQuantity(true);
                  },
                  child: Icon(Icons.add , color: AppColors.signColor,size: Dimensions.font20,),
                ),
              ],
            ),
            ),
            GestureDetector(
              onTap:(){
                if(Get.find<UserController>().isLoading){
                  popularProduct.addItem(product);
                }else{
                  showCustomSnackBar("You have to Sign in");
                }
                  
                },
              child: Container(
              padding: EdgeInsets.only(top: Dimensions.height20 , bottom: Dimensions.height20 , left: Dimensions.width20 , right: Dimensions.width20),
                
                child: BigText(text: " ${product.price!} DA| Add to cart " , color: Colors.white,size: Dimensions.font15,
                ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
              ),
            ),
            )
          ],
        ),
      );
      },),
    );
  }
}