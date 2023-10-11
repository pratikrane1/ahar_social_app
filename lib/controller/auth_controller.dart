import 'dart:convert';
import 'dart:io';
import 'package:aharconnect/data/model/login_model.dart';
import 'package:aharconnect/data/repository/auth_repo.dart';
import 'package:aharconnect/widget/custom_snackbar.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo}) {
    _notification = authRepo.isNotificationActive();
  }

  bool _notification = true;
  bool _isLoading = false;
  bool _isVerifyEmailLoading = false;
  bool _isVerifyOtpLoading = false;
  LoginModel? _loginModel;
  // LoginModel? _forgetPassword;
  bool get notification => _notification;


  bool get isLoading => _isLoading;
  bool get isVerifyEmailLoading => _isVerifyEmailLoading;
  bool get isVerifyOtpLoading => _isVerifyOtpLoading;
  LoginModel? get loginModel => _loginModel;
  // LoginModel? get forgetPassword => _forgetPassword;

  Future<LoginModel> login(String phone,) async {
    Response response = await authRepo.login(
      phone: phone,
    );
    if (response.statusCode == 200) {
      _loginModel = LoginModel.fromJson(response.body);
      if(_loginModel!.success == true){
        // showCustomSnackBar(_loginModel!.message.toString(), isError: false);
      }else{
        // showCustomSnackBar(_loginModel!.message.toString(), isError: true);
      }
    }
    _isLoading = true;
    update();
    return _loginModel!;
  }

  Future<LoginModel> verifyOTP(String userId,String otp) async {

    Response response = await authRepo.verifyOTP(userId: userId,otp: otp);
    if (response.statusCode == 200) {
      _loginModel = LoginModel.fromJson(response.body);
      if(_loginModel!.success == true){
        authRepo.saveUserToken(_loginModel!.data!.token!);
      }
    } else {
    }
    _isVerifyOtpLoading = true;
    update();
    return _loginModel!;
  }
  //
  // Future<LoginModel> verifySMSOTP(String mobileNumber,String otp) async {
  //
  //   Response response = await authRepo.verifySMSOTP(mobileNumber: mobileNumber,otp: otp);
  //   // LoginModel loginModel;
  //   if (response.statusCode == 200) {
  //     _forgetPassword = LoginModel(response.body['status'], response.body['user_id'], '${response.body['message']}', );
  //   } else {
  //     _forgetPassword = LoginModel(0, 0, '${response.body['message']}', );
  //   }
  //   _isVerifyOtpLoading = true;
  //   update();
  //   return _forgetPassword!;
  // }
  //
  // Future<LoginModel> resetPassword(String userId,String password) async {
  //
  //   Response response = await authRepo.resetPassword(userId: userId,password: password);
  //   // LoginModel loginModel;
  //   if (response.statusCode == 200) {
  //     _loginModel = LoginModel(response.body['status'], response.body['id'],
  //         '${response.body['message']}', );
  //   } else {
  //     _loginModel = LoginModel(0, 0, '${response.body['message']}', );
  //   }
  //   _isLoading = true;
  //   update();
  //   return _loginModel!;
  // }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  bool setNotificationActive(bool isActive) {
    _notification = isActive;
    authRepo.setNotificationActive(isActive);
    update();
    return _notification;
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  void saveUserNumber(
    String number,
  ) {
    authRepo.saveUserNumber(number.trim());
  }

  void saveNumberTemp(
      String number,
      ) {
    authRepo.saveNumberTemporary(number.trim());
  }

  void saveUserId(
    int id,
  ) {
    authRepo.saveUserId(id);
  }

  void saveReferalCode(String referalCode) {
    authRepo.saveReferalCode(referalCode);
  }

  int getUserId() {
    return authRepo.getUserId() ?? 0;
  }

  String getUserNumber() {
    return authRepo.getUserNumber() ?? "";
  }

  String getNumberTemporary() {
    return authRepo.getNumberTemporary() ?? "";
  }

  Future<bool> clearUserNumber() async {
    return authRepo.clearUserNumber();
  }

  // Future<String> getUniqueDeviceId() async {
  //   String uniqueDeviceId = '';
  //
  //   var deviceInfo = DeviceInfoPlugin();
  //
  //   if (Platform.isIOS) {
  //     // import 'dart:io'
  //     var iosDeviceInfo = await deviceInfo.iosInfo;
  //     uniqueDeviceId =
  //         '${iosDeviceInfo.name}:${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
  //   } else if (Platform.isAndroid) {
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     uniqueDeviceId =
  //         '${androidDeviceInfo.model}:${androidDeviceInfo.id}'; // unique ID on Android
  //   }
  //
  //   return uniqueDeviceId;
  // }
}
