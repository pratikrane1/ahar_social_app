
import 'package:aharconnect/controller/transaction_controller.dart';
import 'package:aharconnect/data/model/transaction_model.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/images.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';




class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {

  List<TransactionHistoryModel>? _transactionList;
  bool _isLoading = false;

  void initState() {
    // TODO: implement initState
    Get.find<TransactionController>().getTransactionList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        backgroundColor: ThemeColors.whiteColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            // await Get.find<MyAccountController>().profileData;
            // Get.back();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        title: Text(
          'Transaction'.tr,
          style: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: ThemeColors.blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
      ),
      body: GetBuilder<TransactionController>(builder: (transactionController) {
        _transactionList = transactionController.transactionList;
        _isLoading = transactionController.isLoading;
        return _isLoading
            ? _transactionList!.isNotEmpty
            ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 15, left: 10, right: 10),
                    itemCount: _transactionList!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, top: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              //<-- SEE HERE
                              width: 1,
                              color: ThemeColors.greyTextColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            decoration:
                                            const BoxDecoration(
                                              borderRadius:
                                              BorderRadius.all(
                                                  Radius.circular(
                                                      10)),
                                              // border: Border.all(width: 1),
                                            ),
                                            height: 40,
                                            width: 40,
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                              child: SvgPicture.asset(
                                                Images.transaction_logo,
                                                height: 20,
                                                // color: ThemeColors.primaryColor.withOpacity(1),
                                              ),
                                            )),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Paid for".tr,
                                              style: GoogleFonts.openSans(
                                                fontSize: Dimensions
                                                    .fontSizeSmall,

                                                fontWeight:
                                                FontWeight.w500,
                                                color: ThemeColors
                                                    .blackColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text("Ahar".tr,
                                              style: GoogleFonts.openSans(
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                                fontWeight:
                                                FontWeight.normal,
                                                color: ThemeColors
                                                    .blackColor,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "\u{20B9} ${_transactionList![index].amount ?? 0}",
                                          style: GoogleFonts.openSans(
                                            fontSize: Dimensions
                                                .fontSizeSmall,
                                            fontWeight: FontWeight.w600,
                                            color:
                                            ThemeColors.blackColor,
                                          ),
                                        ),
                                        Text(""),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('yMMMd').format(
                                          DateTime.parse(_transactionList![index].createdAt!)),
                                      style: GoogleFonts.openSans(
                                        fontSize: Dimensions
                                            .fontSizeSmall,
                                        fontWeight: FontWeight.w500,
                                        color:
                                        ThemeColors.greyTextColor,
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "TXN:",
                                          style: GoogleFonts.openSans(
                                            fontSize: Dimensions
                                                .fontSizeSmall,
                                            fontWeight: FontWeight.w500,
                                            color: ThemeColors
                                                .greyTextColor,
                                          ),
                                        ),
                                        Container(
                                          // width: 85,
                                          child: Text(
                                            _transactionList![index].txnId ?? "",
                                            maxLines: 3,
                                            style: GoogleFonts.openSans(
                                              // overflow:
                                              //     TextOverflow.ellipsis,
                                              fontSize: Dimensions
                                                  .fontSizeSmall,
                                              // fontWeight: FontWeight.w500,
                                              color: ThemeColors
                                                  .greyTextColor,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.circle,
                                          size: 10,
                                          color: ThemeColors.greenColor,
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "no_transaction_found".tr,
                      style: GoogleFonts.openSans(
                        // overflow:
                        //     TextOverflow.ellipsis,
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                  ],
                ))
            : const Center(
              child: CircularProgressIndicator(
                color: ThemeColors.primaryColor,
              ),
            );
        }
      ),
    );
  }
}
