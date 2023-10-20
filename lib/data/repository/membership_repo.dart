import 'dart:convert';

import 'package:aharconnect/data/api/api_client.dart';
import 'package:aharconnect/utils/app_constants.dart';
import 'package:get/get.dart';

class MembershipRepo extends GetxService {
  final ApiClient apiClient;
  MembershipRepo({required this.apiClient});

  Future<Response> getMembershipDetails() async {
    return await apiClient
        .getData(AppConstants.MEMBERSHIP_DETAILS,);
  }


  Future<Response> RazorPayOrderApi(String amount,String salerOrderId) async {
    return await apiClient.postRazorPayOrderId(AppConstants.INITIATE_RAZORPAY,
        {
      "amount": amount,
      "currency": "INR",
      "receipt": "$salerOrderId",
      "notes": {"shopping_order_id": "$salerOrderId",}
      }
    );
  }

  Future<Response> transactionResponseRazorpay(String userId, String amount, String txnId,var response, String payWith) async {
    return await apiClient.postRazorPayData(AppConstants.TRANSACTION_RAZORPAY, {
      "user_id": userId,
      "amount": amount,
      "txn_id": txnId,
      "dsc" : jsonEncode(response),
      "payment_status": "Paid",
      "pay_with" : payWith
    });
  }
}
