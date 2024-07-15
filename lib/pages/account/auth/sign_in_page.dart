import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/controllers/auth_controller.dart';
import 'package:test/base/custom_loader.dart';
import 'package:test/pages/account/auth/sign_up_page.dart';
import 'package:test/routes/route_helper.dart';
import 'package:test/widgets/app_text_field.dart';
import 'package:test/utils/colors.dart';
import 'package:test/utils/dimensions.dart';
import 'package:test/widgets/big_text.dart';
import 'package:test/base/show_custom_snackbar.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
   
    void _login(AuthController authController){
     
      
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      

      if(phone.isEmpty){
        showCustomSnackBar("Type in your phone number", title: "phone");

      }else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "password");

      }else if(password.length<6){
        showCustomSnackBar("Password can not be less than six characters", title: "Password");

      }else{
       
        authController.login(phone, password).then((status){
          if(status.isSuccess){
            Get.toNamed(RouteHelper.getInitial());
            
          }else{
            showCustomSnackBar(status.message);
             print("Error: ${status.message}");
          }


        });
        


      }

    }
   
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
       return !authController.isLoading? SingleChildScrollView(
        physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: Dimensions.screenHeight*0.05,),
          //app logo
          Container(
            height: Dimensions.screenHeight*0.25, 
            child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              backgroundImage: AssetImage(
                "assets/image/logo2.png",
              ),
            )),
          ),
          //welcome
          Container(
            margin: EdgeInsets.only(left: Dimensions.width20),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(
                    fontSize: Dimensions.font20*3+Dimensions.font20/2,
                    fontWeight: FontWeight.bold
                  ),
                  

                ),
                Text(
                  "Sign into your account",
                  style: TextStyle(
                    fontSize: Dimensions.font20,
                    //fontWeight: FontWeight.bold
                    color: Colors.grey[500],
                  ),

                ),
              ],
            ),
          ),
          SizedBox(height: Dimensions.height20,),
          //your email
          AppTextField(textController: phoneController,
           hintText: "Phone",
            icon: Icons.phone,),
            SizedBox(height: Dimensions.height20,),
            //your password
            AppTextField(textController: passwordController,
           hintText: "Password",
            icon: Icons.password_sharp, isObscure: true,),
            SizedBox(height: Dimensions.height20,),
           

            
            
            //tag line
            Row(
              children: [
                Expanded(child: Container()),
                RichText(
              text: TextSpan(
                
                text: "Sign into your account",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,

                ),

              ),
            ),
            SizedBox(height: Dimensions.width20,),
              ],
            ),
            SizedBox(height: Dimensions.screenHeight*0.05,),
             //sign in button
            GestureDetector(
              onTap: () {
                _login(authController);
                
              },
             child: Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: AppColors.mainColor
              ),
              child: Center(
              child: BigText(text: "Sign in",
              size: Dimensions.font20+Dimensions.font20/2,
              color: Colors.white,
              ),
             ),

            )),
            SizedBox(height: Dimensions.screenHeight*0.05,),
            //sign up options

            RichText(
              text: TextSpan(
                
                text: "Don't have an account?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20,

                ),
                children: [
                  TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                text: "Create",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                  fontSize: Dimensions.font20,

                )),

                ],

              ),
            ),
            
            

            



        ],
      )):CustomLoader();
    
    }),
    );

 
 }
} 