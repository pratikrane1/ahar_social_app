
import 'package:aharconnect/utils/app_constants.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';


enum PaymentMode { mode1, mode2 }

class PaymentDialog extends StatefulWidget {
  String? amount;
  String? paidAmount;
  PaymentDialog({Key? key,required this.amount,required this.paidAmount}) : super(key: key);

  @override
  State<PaymentDialog> createState() => _PaymentDialogState();
}

// class PaymentDialog extends StatefulWidget {
  class _PaymentDialogState extends State<PaymentDialog> {

  PaymentMode? _character = PaymentMode.mode1;

  Razorpay _razorpay = Razorpay();

  static MethodChannel _channel = MethodChannel('easebuzz');

  String? _easeBuzzAccessKey;
  String? _easeBuzzPayMode;
  int? _easeBuzzTaxId;
  String? name;
  bool _isLoading = true;
  var options;
  int? amount;
  String? orderId;

  @override
  void initState(){
    super.initState();
    DateFormat dateFormat = DateFormat("yyyyMMddHHmmss");
    String orderDate = dateFormat.format(DateTime.now());
    print(orderDate);
    orderId = 'ORDS${orderDate}_${1}';
    amount = int.parse(widget.amount.toString())*100;
    // amount = widget.isGainZPro! ? 100 : 200;
    print(amount);
  }



  void handlePaymentErrorResponse(PaymentFailureResponse response){
    setState(() {
      _isLoading = true;
    });
    print(response);
    showAlertDialog(context, "Payment Failed", "Description: ${response.message}");
    // Get.find<MembershipController>().transactionResponseRazorPay(userId, phone, email, amount, txnId);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){
    setState(() {
      _isLoading = true;
    });
    var res = {"razorpay_payment_id" : response.paymentId,"razorpay_order_id" : response.orderId,"razorpay_signature" : response.signature,};
    print(res);
    // Get.find<MembershipController>().transactionResponseRazorPay(widget.profileData!.id.toString(),amount.toString(),orderId.toString(),res, widget.isGainZPro == true ? "0" : "1");
    showAlertDialog(context, "Payment Successful", "Order ID: ${response.orderId}");
    // Get.find<MembershipController>().getMembershipDetails("${Get.find<AuthController>().getUserId()}",widget.isGainZPro == true ? "0" : "1");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    setState(() {
      _isLoading = true;
    });
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }




  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ThemeColors.primaryColor)
      ),
      child: Text("continue".tr),
      onPressed:  () {
        Get.back();
        // Get.offNamed(RouteHelper.getInitialRoute(0.toString()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding:
            const EdgeInsets.only(top: 10.0, bottom: 20, left: 10, right: 10),
            margin: const EdgeInsets.only(top: 13.0, right: 0.0),
            decoration: BoxDecoration(
                color: ThemeColors.whiteColor,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                  ),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "payment_options".tr,
                    style: GoogleFonts.openSans(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.blackColor),
                  ),
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    ///Radio Button
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius:
                        BorderRadius.circular(25),
                        boxShadow: const [
                          BoxShadow(
                            color: ThemeColors.greyTextColor,
                            // blurRadius: 3,
                            spreadRadius: 0.5,
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Text('razorPay'.tr),
                        leading: Radio<PaymentMode>(
                          fillColor:
                          MaterialStateColor.resolveWith((states) => ThemeColors.primaryColor),
                          value: PaymentMode.mode1,
                          groupValue: _character,
                          onChanged: (PaymentMode? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),


                    const SizedBox(height: 25,),


                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: AppButton(
                        onPressed: () async {
                          _isLoading = false;
                          name = "Ahar";
                          print(name);
                          if(_character == PaymentMode.mode1) {
                            _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                handlePaymentErrorResponse);
                            _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                handlePaymentSuccessResponse);
                            _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                handleExternalWalletSelected);
                            // Get.find<MembershipController>().RazorPayOrderApi(amount.toString(),orderId!).
                            // then((value) {
                              options = {
                                'key': '${AppConstants.RAZORPAY_KEY}',
                                'amount': amount,
                                'name': '${"Ahar"}',
                                'order_id': '0123456', // Generate order_id using Orders API
                                'description': 'GainZ Pro Membership Renewal',
                                'retry': {'enabled': true, 'max_count': 1},
                                'send_sms_hash': true,
                                'prefill': {'contact': '${"123456789"}', 'email': "pratik.rane@desteksolutions.com"},
                                'external': {
                                  'wallets': ['paytm']
                                }
                              };
                              _razorpay.open(options);
                            // });
                            // _razorpay.open(options);
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        text:  Text(
                          widget.paidAmount != "null" ?
                          'repurchase'.tr : "purchase".tr,
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        loading: _isLoading,
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                              color: ThemeColors.buttonColor, width: 1),
                          backgroundColor: ThemeColors.buttonColor,
                          // color:Colors.red,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50))),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 15.0,
            top: 18.0,
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.cancel, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
