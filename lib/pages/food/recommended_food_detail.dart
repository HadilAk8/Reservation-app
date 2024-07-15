import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/base/show_custom_snackbar.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/controllers/popular_product_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/app_constants.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
 const RecommendedFoodDetail({Key? key, required this.pageId , required this.page}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<ProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      if(page=="cartpage"){
                      Get.toNamed(RouteHelper.getCartPage("food"));
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }
                    },
                    child: AppIcon(icon: Icons.clear),
                  ),
                  //AppIcon(icon: Icons.shopping_cart_outlined)
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
                            child: 
                              AppIcon(icon: Icons.circle , size: 20, iconColor: Colors.transparent, backgroundColor:  AppColors.mainColor,),
                                  
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                 child:Container(
                  child: Center(child: BigText(size:Dimensions.font26,text: product.nomP!),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5 , bottom: 10),
                  decoration: BoxDecoration(
                    color : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                 ),
                 ),
              pinned: true,
              backgroundColor: AppColors.bluev,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstant.BASE_URL+AppConstant.UPLOAD_URL+product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20 , right: Dimensions.width20),
                    child: ExpandableTextWidget(text:product.description!),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: GetBuilder<ProductController>(builder: (controller){
          return Column(
          mainAxisSize: MainAxisSize.min ,
          children: [
           Container(
            margin: EdgeInsets.only(left:Dimensions.width20*2.5 , right:Dimensions.width20*2.5 , top:Dimensions.height10 , bottom:Dimensions.height10 ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.setQuantity(false);
                  },
                  child: AppIcon(backgroundColor: AppColors.mainColor,icon: Icons.remove, iconColor: Colors.white ,iconSize: Dimensions.iconsize24,),
                ),
                BigText(text: "\$ ${product.price!}  X ${controller.inCartItem}" , color: AppColors.mainBlackColor,size: Dimensions.font24,),
                GestureDetector(
                  onTap: (){
                    controller.setQuantity(true);
                  },
                  child: AppIcon(backgroundColor: AppColors.mainColor,icon: Icons.add, iconColor: Colors.white,iconSize: Dimensions.iconsize24,),
                ),
              ],
            ),
           ),
            Container(
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
            child: Icon(
              Icons.favorite,
              color: AppColors.mainColor,
            ),
            ),
            GestureDetector(
              onTap: (){
                if(Get.find<UserController>().isLoading){
                  controller.addItem(product);
                }else{
                  showCustomSnackBar("You have to Sign in");
                }
                
              },
              child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20 , bottom: Dimensions.height20 , left: Dimensions.width20 , right: Dimensions.width20),
                      child: 
                        BigText(text: "\$ ${product.price!} | Add to cart " , color: Colors.white,size: Dimensions.font15,),
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                           color: AppColors.mainColor,
                          ),
                    ),
            ),
          ],
        ),
      ),
          ],
        );  
    
        },),
    );
  }
}