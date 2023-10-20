import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/transaction_model.dart';
import 'package:aharconnect/data/repository/transaction_repo.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TransactionController extends GetxController implements GetxService {
  final TransactionRepo transactionRepo;
  TransactionController({required this.transactionRepo});

  bool _isLoading = false;
  List<TransactionHistoryModel>? _transactionList;

  bool get isLoading => _isLoading;
  List<TransactionHistoryModel> get transactionList => _transactionList ?? [];


  Future<List<TransactionHistoryModel>> getTransactionList() async {
    _isLoading = false;
    // _transactionList = [];
    Response response = await transactionRepo.getTransactionList();
    if (response.statusCode == 200) {

      final Iterable refactorProductList = response.body!["data"] ?? [];
      _transactionList = refactorProductList.map((item) {
        return TransactionHistoryModel.fromJson(item);
      }).toList();

      print(_transactionList);
      _isLoading = true;

    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _transactionList!;
  }



}
