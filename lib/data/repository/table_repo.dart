import 'package:get/get_connect/http/src/response/response.dart';
import 'package:test/data/api/api_client.dart';
import 'package:test/utils/app_constants.dart';

class TableRepo {

final ApiClient apiClient;
TableRepo({required this.apiClient});

Future<Response> getTableList()async{
    return await apiClient.getData(AppConstant.TABLE_URI);
  }

}