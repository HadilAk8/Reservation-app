import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/app_constants.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/icon_and_text_widget.dart';
import 'package:test/widgets/small_text.dart';

class CategoryProductsDetail extends StatelessWidget {
  final int pageId;
  final String page;
  CategoryProductsDetail( {Key? key , required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List category = [ 
      ["assets/image/Alg.jpg","Algeria" ],
      ["assets/image/Pasta.jpg", "Italian"],
      ["assets/image/ramen.jpg", "Japanese"],
      ["assets/image/dessert.jpg", "Dessert"],
      ["assets/image/Drinks.jpg" , "Drinks"]
    ];
    // ignore: unused_local_variable
    var product ;
    switch(pageId){
      case 0 :
        product = Get.find<ProductController>().productList;
      break;
      case 1 :
        product = Get.find<ProductController>().producItalList;
      break;
      case 2 :
        product = Get.find<ProductController>().productJapList;
      break;
      case 3:
      product = Get.find<ProductController>().productDesList;
      break;
      default :
      product = Get.find<ProductController>().productDrinList;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //image
          Positioned(
            left: 0,
            right: 0,
            child:  Container(
              width: double.maxFinite,
              height: Dimensions.popularFoodImgSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(category[pageId][0]),
                  ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    
                    if(page=="main"){
                      Get.toNamed(RouteHelper.getInitial());
                    }else{
                      Get.toNamed(RouteHelper.getMenuPage());
                    }
                    
                  } ,
                  child: 
                    AppIcon(icon: Icons.arrow_back_ios),
                ),

                Stack(
                  children: [
                    AppIcon(icon: Icons.category),
                  ],
                )

              ],
            ), 
          ),
          //list Product
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize-100,
            child:Container(
              padding: EdgeInsets.only(left: Dimensions.width10 , right: Dimensions.width10 , top: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimensions.radius20),
                  topLeft: Radius.circular(Dimensions.radius20),
                ),
                color: Colors.white,
              ),
              child: GetBuilder<ProductController>( builder: (context) {
                  return ListView.builder(
                      itemCount: product.length,
                      itemBuilder: (context , index){
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getPopularFood(index , "main" , pageId));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: Dimensions.height10),
                            child: Row(
                    children: [
                      //image section 
                      Container(
                        width: Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white38,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              AppConstant.BASE_URL+AppConstant.UPLOAD_URL+product[index].img!
                             ),
                          ),
                        ),
                      ),
                      //text container 
                     Expanded(
                      child:  Container(
                        height: Dimensions.listViewTextContSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimensions.radius20),
                            bottomRight: Radius.circular(Dimensions.radius20),
                          ),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10 , right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BigText(text: product[index].nomP ,),
                              SizedBox(height :Dimensions.height10),
                              SmallText(text: "Traditional Food"),
                              SizedBox(height :Dimensions.height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                  IconAndTextWidget(icon: Icons.location_on, text: category[pageId][1], iconColor: AppColors.mainColor),
                                  //IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2),
                                 ],
                              ),
                            ],
                            ),
                          ),
                      ), 
                      ),
                  ],
                  ),
                          ),
                        );
                      },
                      );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}