import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:test/data/repository/table_repo.dart';
import 'package:test/models/table_model.dart';

class TableResController extends GetxController implements GetxService{
  final TableRepo tableRepo ;
  TableResController({required this.tableRepo});

  List<dynamic> _tableList = [];
  List<dynamic> get tableList => _tableList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getTableList()async {
    Response response = await tableRepo.getTableList();
    if(response.statusCode==200){
      _tableList=[];
      _tableList = (response.body)
         .map((table) => TableModel.fromJson(table))
         .toList();
      _isLoaded = true;
      update();
    }else{
      print("there is no data");
  }
  }

  TableModel? findTableList(String nameTable){
    for(var table in _tableList){
      if(table.nameT==nameTable){
        return table;
      }
    }
    return null ;
  }

}