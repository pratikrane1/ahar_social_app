import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class TransactionRepo extends GetxService {
  final ApiClient apiClient;
  TransactionRepo({required this.apiClient});

  Future<Response> getTransactionList() async {
    return await apiClient
        .getData(AppConstants.TRANSACTION_LIST);
  }
}
