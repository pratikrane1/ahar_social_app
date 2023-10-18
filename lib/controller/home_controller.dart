import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/banner_model.dart';
import 'package:aharconnect/data/repository/home_repo.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});

  bool _isBannerLoading = false;
  List<BannerModel>? _bannerList;
  String? _pdfFile;
  bool _isPDFLoading = false;

  bool get isBannerLoading => _isBannerLoading;
  List<BannerModel> get bannerList => _bannerList ?? [];
  String? get pdfFile => _pdfFile;
  bool get isPDFLoading => _isPDFLoading;


  Future<void> getBanner() async {
    _isBannerLoading = false;
    Response response = await homeRepo.getBannerList();
    if (response.statusCode == 200) {
      _bannerList = [];
      final Iterable refactorAppOfDayList = response.body!["data"] ?? [];
      _bannerList = refactorAppOfDayList.map((item) {
        return BannerModel.fromJson(item);
      }).toList();
      print(_bannerList);
      _isBannerLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    // }
  }

  Future<String> getPdfUrl() async {
    _pdfFile = "";
    _isPDFLoading = false;
    Response response = await homeRepo.getPDFFile();
    if (response.statusCode == 200) {
      _pdfFile = response.body!["data"]["url"];
      print("GainZ Pro PDF$_pdfFile");
      _isPDFLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _pdfFile!;
  }


}