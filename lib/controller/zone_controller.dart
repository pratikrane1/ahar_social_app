import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/data/repository/zone_repo.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ZoneController extends GetxController implements GetxService {
  final ZoneRepo zoneRepo;
  ZoneController({required this.zoneRepo});

  bool _isLoading = false;
  List<ZoneModel>? _zoneList;

  bool get isLoading => _isLoading;
  List<ZoneModel>? get zoneList => _zoneList;


  Future<List<ZoneModel>> getZoneList() async {
    _isLoading = false;
    Response response = await zoneRepo.getZoneList();
    if (response.statusCode == 200) {
      final Iterable refactorZoneList = response.body!["data"] ?? [];
      _zoneList = refactorZoneList.map((item) {
        return ZoneModel.fromJson(item);
      }).toList();
      _zoneList!.sort((a,b){
        return a.id!.compareTo(b.id!);
      });
      print(_zoneList);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _zoneList!;
  }


}