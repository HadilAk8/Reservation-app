import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/auth_controller.dart';
import 'package:test/controllers/cart_controller.dart';
import 'package:test/controllers/user_controller.dart';
import 'package:test/base/custom_loader.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/account_widget.dart';
import 'package:test/widgets/app_icon.dart';
import 'package:test/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
      
    }
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text:"Profile", color: Colors.white, size: 24, 

          ),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return _userLoggedIn?(userController.isLoading?Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
      child: Column(
        children: [
          //profile icon
          AppIcon(icon: Icons.person,
          backgroundColor: AppColors.mainColor,
          iconColor: Colors.white,
          iconSize: Dimensions.height45+Dimensions.height30,
          size: Dimensions.height15*10, 
          ),
          SizedBox(height: Dimensions.height30,),

          Expanded(
          child: SingleChildScrollView(
           child: Column(
            children: [
              //name
          AccountWidget(
            appIcon:  AppIcon(icon: Icons.person,
          backgroundColor: AppColors.mainColor,
          iconColor: Colors.white,
          iconSize: Dimensions.height10*5/2,
          size: Dimensions.height10*5, 
          ),
            bigText: BigText(text: userController.userModel.name, color: Colors.black,),
            ),
            SizedBox(height: Dimensions.height20,),
            //phone
             AccountWidget(
            appIcon:  AppIcon(icon: Icons.phone,
          backgroundColor: AppColors.orangeColor,
          iconColor: Colors.white,
          iconSize: Dimensions.height10*5/2,
          size: Dimensions.height10*5, 
          ),
            bigText: BigText(text: userController.userModel.phone, color: Colors.black,),
            ),
            SizedBox(height: Dimensions.height20,),
            //email
             AccountWidget(
            appIcon:  AppIcon(icon: Icons.email,
          backgroundColor: AppColors.orangeColor,
          iconColor: Colors.white,
          iconSize: Dimensions.height10*5/2,
          size: Dimensions.height10*5, 
          ),
            bigText: BigText(text: userController.userModel.email, color: Colors.black,),
            ),
            SizedBox(height: Dimensions.height20,),
            //Log out
            GestureDetector(
              onTap: () {
                if(Get.find<AuthController>().userLoggedIn()){
                 Get.find<AuthController>().clearSharedData();
                 Get.find<CartController>().clear();
                 Get.find<CartController>().clearCartHistory();
                 Get.offNamed(RouteHelper.getSignInPage());

                }else{
                  print("you are already logged out.");
                }
                
              },
              child: AccountWidget(
            appIcon:  AppIcon(icon: Icons.logout,
          backgroundColor: Colors.redAccent,
          iconColor: Colors.white,
          iconSize: Dimensions.height10*5/2,
          size: Dimensions.height10*5, 
          ),
            bigText: BigText(text: "Logout", color: Colors.black,),
            ),
            ),
            SizedBox(height: Dimensions.height20,),

            ],
          ),
          ),
          ),

            

        ],
      ),
      ):CustomLoader()):Container(child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
        width: Dimensions.width20*20,
        height: Dimensions.height20*15,
        margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/image/velo.jpg"
            )),
        ),
      ),
      GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getSignInPage());
          
        },
       child: Container(
        width: double.maxFinite,
        height: Dimensions.height20*3,
        margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20,),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Shadow color
                  spreadRadius: 1, // Spread radius
                  blurRadius: 10, // Blur radius
                  offset: Offset(0, 5), // Changes position of shadow
                ),
              ],
        ),
        child: Center(child: BigText(text: "Sign in",color: Colors.white,size: Dimensions.font26,)),
      )),
        ],
      )));
      }),
    );
  }
}