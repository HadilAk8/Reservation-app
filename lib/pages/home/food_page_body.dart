import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test/controllers/product_controller.dart';
import 'package:test/controllers/popular_product_controller.dart';
//import 'package:test/models/products_model.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/app_constants.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/app_column.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/widgets/icon_and_text_widget.dart';
import 'package:test/widgets/small_text.dart';
import 'package:dots_indicator/dots_indicator.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key:key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  // ignore: unused_field
  var _currPageValue=0.0;
  double _scaleFactor= 0.8;
  double _height = Dimensions.PageViewContainer;
  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState ((){   
      _currPageValue = pageController.page!;
      });
    });
  }
  List category = [ 
    ["Algerian Food" , "assets/image/Alg.jpg" , "Algeria"] , 
    ["Italian Food" , "assets/image/Pasta.jpg" , "Italy" ] ,
    ["Japanese Food" , "assets/image/ramen.jpg" ,"Japan" ],
    ["Dessert" , "assets/image/dessert.jpg" , "Dessert" ],
    ["Drinks" , "assets/image/Drinks.jpg" ,"Drink" ]
  ];
  @override
  
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        //slider section
       GetBuilder<ProductController>(builder: (products){
        return products.isLoaded?Container(
           height : Dimensions.PageView,

            child:  PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context , position){
            return _buildPageItem(position);
           }),

      ):CircularProgressIndicator(
        color: AppColors.mainColor ,
      );
       }),
        //dots
       GetBuilder<ProductController>(builder:(popularProducts){
        return  DotsIndicator(
          dotsCount: 5 ,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        );
       }),

        //Popular text
        SizedBox(height: Dimensions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Populer",),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3,),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: 2,),
                child: SmallText(text: "Food pairing"),
              )
            ],

          ),
        ),
        //list of food and images 
        GetBuilder<PopularProductController>(builder:(popularProduct){
          return popularProduct.isLoaded?ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: popularProduct.popularProductList.length,
          itemBuilder: (context , index){
            return GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getRecommendedFood(index , "home"));
              },
              child: Container(
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10 , bottom: Dimensions.height10),
              child: Column(
                children: [
                  Row(
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
                        image:NetworkImage(
                           AppConstant.BASE_URL+AppConstant.UPLOAD_URL+popularProduct.popularProductList[index].img!
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
                          BigText(text: popularProduct.popularProductList[index].nomP!,),
                          SizedBox(height :Dimensions.height10),
                          SmallText(text: "Fast Food"),
                          SizedBox(height :Dimensions.height10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                              IconAndTextWidget(icon: Icons.location_on, text: "American", iconColor: AppColors.mainColor),
                              //IconAndTextWidget(icon: Icons.access_time_rounded, text: "min", iconColor: AppColors.iconColor2),
                             ],
                          ),
                        ],
                        ),
                      ),
                  ), 
                  ),
              ],
              ),
                ],
              ),
            ),
            );
        }):CircularProgressIndicator(
          color: AppColors.mainColor,
        );
        }),
        
      ],
    );
  }
  Widget _buildPageItem(int index){
    // ignore: unused_local_variable
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()){
      // ignore: unused_local_variable
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      // ignore: unused_local_variable
      var currTrans = _height*(1-currScale)/2 ;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
      
    }else if(index == _currPageValue.floor()+1){
      // ignore: unused_local_variable
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      // ignore: unused_local_variable
      var currTrans = _height*(1-currScale)/2 ;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else if(index == _currPageValue.floor()-1){
      // ignore: unused_local_variable
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTrans = _height*(1-currScale)/2 ;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }else{
      // ignore: unused_local_variable
      var currScale = 0.8 ;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0 , _height*(1-_scaleFactor)/2,1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
      children: [
        GestureDetector(
          onTap: (){

            Get.toNamed(RouteHelper.getCategoryFood(index , "main"));
          },
          child :Container(
            height: Dimensions.PageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10 , right: Dimensions.width10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc) ,
              image:DecorationImage(
                fit:BoxFit.cover,
                image: AssetImage(category[index][1]),
              )
            ),
          ),
        ),
       
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
      height: Dimensions.PageViewTextContainer,
      margin: EdgeInsets.only(left: Dimensions.width30 , right: Dimensions.width30 , bottom: Dimensions.height30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius20),
        color: Colors.white ,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFe8e8e8),
            blurRadius:5.0,
            offset: Offset(0,5),
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-5,0),
          ),
           BoxShadow(
            color: Colors.white,
            offset: Offset(5,0),
          ),
        ]
      ),
      child: Container(
        padding: EdgeInsets.only(top: Dimensions.height10 , left: Dimensions.height15 , right: Dimensions.height15),
        child: AppColumn(text: category[index][0] ,loc: category[index][2]),
      ),
    ),
        )
      ],
    ),
    );
  }
}