import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/data/api/api_client.dart';
import 'package:test/models/reservation_model.dart';
import 'package:test/utils/app_constants.dart';

class ReservationRepo{
  
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ReservationRepo({required this.sharedPreferences , required this.apiClient});

  Future<Response> registration(ReservationModel reservationModel) async {
    return await apiClient.postData(AppConstant.ADD_RESERVATION_URI , reservationModel.toJson());
  }

  Future<Response> getReservationList()async{
    return await apiClient.getData(AppConstant.RESERVATION_URI);
  }

  
}