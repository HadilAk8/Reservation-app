import 'package:get/get.dart';
import 'package:test/data/api/api_client.dart';

class ProductRepo extends GetxService{
  final ApiClient apiClient;

  ProductRepo({required this.apiClient});

  Future<Response> getProductList(String name)async{
    return await apiClient.getData(name);
  }
}