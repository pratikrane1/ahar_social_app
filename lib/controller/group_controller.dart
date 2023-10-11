import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/data/repository/group_repo.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../screen/group/group_screen.dart';

class GroupController extends GetxController implements GetxService {
  final GroupRepo groupRepo;
  GroupController({required this.groupRepo});

  bool _isLoading = false;
  List<GroupModel>? _officeBearers;

  bool get isLoading => _isLoading;
  List<GroupModel>? get officeBearers => _officeBearers ?? [];




}