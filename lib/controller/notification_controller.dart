import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/notification_model.dart';
import 'package:aharconnect/data/repository/notification_repo.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  List<NotificationModel>? _notificationList;
  bool _hasNotification = false;
  String? _fcmNotificationTitle;
  List<NotificationModel> get notificationList => _notificationList ?? [];
  bool get hasNotification => _hasNotification;
  String get fcmNotificationTitle => _fcmNotificationTitle ?? "";

  Future<List<NotificationModel>> getNotificationList() async {
    _hasNotification=false;
    Response response = await notificationRepo.getNotificationList();
    if (response.statusCode == 200) {
      _notificationList = [];
      final Iterable refactorNotificationList = response.body!["data"] ?? [];
      _notificationList = refactorNotificationList.map((item) {
        return NotificationModel.fromJson(item);
      }).toList();
      _hasNotification = true;
      print(_notificationList);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    // }
    return _notificationList!;
  }

  Future<String> getFcmNotificationTitle(String fcmTitle) async {
    _fcmNotificationTitle = fcmTitle;
    update();
    // }
    return _fcmNotificationTitle!;
  }
}
