import 'package:get/get.dart';
import 'package:test/data/api/api_client.dart';
import 'package:test/utils/app_constants.dart';

class UserRepo{
  final ApiClient apiClient;
  UserRepo({required this.apiClient});


  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstant.USER_INFO_URI);

  }

}