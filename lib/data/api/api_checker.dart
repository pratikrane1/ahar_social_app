import 'package:aharconnect/view/widget/custom_snackbar.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showCustomSnackBar(response.statusText.toString());
    } else {
      showCustomSnackBar(response.statusText.toString());
    }
  }
}
