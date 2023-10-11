import 'package:get/get.dart';
import 'package:aharconnect/widget/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showCustomSnackBar(response.statusText.toString());
    } else {
      showCustomSnackBar(response.statusText.toString());
    }
  }
}
