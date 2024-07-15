import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/data/api/api_client.dart';
import 'package:test/models/signup_body_model.dart';
import 'package:test/utils/app_constants.dart';

class AuthRepo{
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    return await apiClient.postData(AppConstant.REGISTRATION_URI, signUpBody.toJson());
  }

  bool userLoggedIn()  {
    return sharedPreferences.containsKey(AppConstant.TOKEN);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstant.TOKEN)??"None";
  }
    
  Future<Response> login(String phone , String password) async {
    return await apiClient.postData(AppConstant.LOGIN_URI, {"phone":phone, "password":password}); 
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    print("token is "+token);
    return await sharedPreferences.setString(AppConstant.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try{
      await sharedPreferences.setString(AppConstant.PHONE, number);
      await sharedPreferences.setString(AppConstant.PASSWORD, password);

    }catch(e){
      throw e;
    }
  }


  bool clearSharedData(){
    sharedPreferences.remove(AppConstant.TOKEN);
    sharedPreferences.remove(AppConstant.PASSWORD);
    sharedPreferences.remove(AppConstant.PHONE);
    apiClient.token='';
    apiClient.updateHeader('');
    return true;

  }

  
}