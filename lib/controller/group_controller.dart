import 'dart:io';

import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/office_bearers_model.dart';
import 'package:aharconnect/data/model/sub_committee_model.dart';
import 'package:aharconnect/data/repository/group_repo.dart';
import 'package:aharconnect/view/widget/custom_snackbar.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:url_launcher/url_launcher.dart';

class GroupController extends GetxController implements GetxService {
  final GroupRepo groupRepo;
  GroupController({required this.groupRepo});

  bool _isLoading = false;
  bool _isSubComLoading = false;
  bool _isOffBearLoading = false;
  List<OfficeBearers>? _officeBearers;
  List<SubCommitteeModel>? _subCommitteeList;

  bool get isLoading => _isLoading;
  bool get isSubComLoading => _isSubComLoading;
  bool get isOffBearLoading => _isOffBearLoading;
  List<OfficeBearers>? get officeBearers => _officeBearers ?? [];
  List<SubCommitteeModel>? get subCommitteeList => _subCommitteeList ?? [];

  Future<List<OfficeBearers>> getOfficersBearersList() async {
    _isOffBearLoading = false;
    // _postDataList = [];
    Response response = await groupRepo.getOfficeBearersList();
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"] ?? [];
      _officeBearers = refactorPostDataList.map((item) {
        return OfficeBearers.fromJson(item);
      }).toList();
      print(_officeBearers);
      _isOffBearLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _officeBearers!;
  }

  Future<List<SubCommitteeModel>> getSubCommitteeList() async {
    _isSubComLoading = false;
    Response response = await groupRepo.getSubCommitteeList();
    if (response.statusCode == 200) {
      final Iterable refactorPostDataList = response.body!["data"] ?? [];
      _subCommitteeList = refactorPostDataList.map((item) {
        return SubCommitteeModel.fromJson(item);
      }).toList();
      print(_subCommitteeList);
      _isSubComLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _subCommitteeList!;
  }


  launchWhatsapp(String mobileNumber) async {
    var whatsapp = mobileNumber;

    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp;
    var whatsappURL_WEB = "https://wa.me/$whatsapp";
    var whatappURL_ios = "https://wa.me/$whatsapp";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        showCustomSnackBar("Could not launch", isError: true);
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        showCustomSnackBar("Could not launch", isError: true);
      }
    }
  }

  launchMain(String email) async {
    Uri mail = Uri.parse('mailto:$email');
    if (await canLaunchUrl(mail)) {
      launchUrl(mail);
    } else {
      showCustomSnackBar("Could not launch", isError: true);
      throw 'Could not launch $mail';
    }
  }

  launchPhone(String mobileNo) async {
    final call = Uri.parse('tel:$mobileNo');
    if (await canLaunchUrl(call)) {
      launchUrl(call);
    } else {
      showCustomSnackBar("Could not launch", isError: true);
      throw 'Could not launch $call';
    }
  }
}
