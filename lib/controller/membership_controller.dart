import 'package:aharconnect/data/api/api_checker.dart';
import 'package:aharconnect/data/model/membership_model.dart';
import 'package:aharconnect/data/repository/membership_repo.dart';
import 'package:get/get.dart';

class MembershipController extends GetxController implements GetxService {
  final MembershipRepo membershipRepo;
  MembershipController({required this.membershipRepo});

  bool _isLoading = false;
  MembershipModel? _membershipDetails;
  String? _easeBuzzAccessKey;
  String? _easeBuzzPayMode;
  int? _easeBuzzTaxId;
  String? _easeBuzzTransResult;
  String? _razorPayTransResult;
  String? _easeBuzzTransMessage;
  String? _razorPayOrderApiResponse;

  bool get isLoading => _isLoading;
  MembershipModel? get membershipDetails => _membershipDetails;
  String get easeBuzzAccessKey => _easeBuzzAccessKey ?? "";
  String? get easeBuzzPayMode => _easeBuzzPayMode ?? "";
  String? get easeBuzzTransResult => _easeBuzzTransResult ?? "";
  String? get razorPayTransResult => _razorPayTransResult ?? "";
  String? get easeBuzzTransMessage => _easeBuzzTransMessage ?? "";
  String? get razorPayOrderApiResponse => _razorPayOrderApiResponse ?? "";
  int? get easeBuzzTaxId => _easeBuzzTaxId ?? 0;

  Future<void> getMembershipDetails() async {
    _isLoading = false;
    _membershipDetails = null;
    Response response = await membershipRepo.getMembershipDetails();
    if (response.statusCode == 200) {
      _membershipDetails;
      _membershipDetails = MembershipModel.fromJson(response.body!["data"]);
      print(_membershipDetails);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  // Future<String> RazorPayOrderApi(String amount,String salerOrderId) async {
  //   _isLoading = false;
  //   Response response = await membershipRepo.RazorPayOrderApi(amount,salerOrderId);
  //   if (response.statusCode == 200) {
  //     _razorPayOrderApiResponse = response.body!["id"];
  //     _isLoading = true;
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return _razorPayOrderApiResponse!;
  // }

  // Future<String> transactionResponseRazorPay(String userId,String amount,String txnId,var responseRazorpay, String isGainzPro) async {
  //   _isLoading = false;
  //   Response response = await membershipRepo.transactionResponseRazorpay(userId,amount,txnId,responseRazorpay,isGainzPro);
  //   if (response.statusCode == 200) {
  //     _razorPayTransResult = response.body!["Result"];
  //     _isLoading = true;
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  //   return _razorPayTransResult!;
  // }
}
