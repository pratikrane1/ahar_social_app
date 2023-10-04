
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/theme_colors.dart';


class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {

  String dropdownvalue = 'today'.tr;

  bool isToday = true;
  bool isWeek = false;
  bool isWeekLoading = false;
  bool isMonth = false;
  bool isAll = false;

  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();

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
          'Transaction',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            color: ThemeColors.blackColor,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        // actions: [
        //   Row(
        //     children: [
        //       Container(
        //           decoration: const BoxDecoration(
        //             borderRadius: BorderRadius.all(Radius.circular(80)),
        //             // border: Border.all(width: 1),
        //           ),
        //           height: 25,
        //           width: 25,
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.circular(80),
        //             child: SvgPicture.asset(
        //               Images.filter, height: 25,
        //               color: ThemeColors.blackColor,
        //             ),
        //             // leaderData!.profileImage != null
        //             //       ? CustomImage(
        //             //          image: leaderData.profileImage,
        //             //        fit: BoxFit.cover,
        //             //       )
        //             //          : SvgPicture.asset(
        //             //       Images.avtar_icon, height: 25,
        //             //               // color: ThemeColors.greyTextColor,
        //             //    ),
        //           )),
        //       SizedBox(width: 7,),
        //     ],
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.only(
                    top: 0, bottom: 15, left: 10, right: 10),
                itemCount: 4,
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
                                          style: TextStyle(
                                            fontSize: Dimensions
                                                .fontSizeSmall,
                                            fontFamily:
                                            'Montserrat-Bold',
                                            fontWeight:
                                            FontWeight.w500,
                                            color: ThemeColors
                                                .blackColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text("Ahar",
                                          style: TextStyle(
                                            fontSize: Dimensions
                                                .fontSizeExtraSmall,
                                            fontFamily:
                                            'Montserrat-Medium',
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
                                      "\u{20B9}3999",
                                      style: TextStyle(
                                        fontSize: Dimensions
                                            .fontSizeSmall,
                                        fontFamily:
                                        'Montserrat-Bold',
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
                                      DateTime.parse(DateTime.now().toString())),
                                  style: TextStyle(
                                    fontSize: Dimensions
                                        .fontSizeSmall,
                                    fontFamily: 'Montserrat-Medium',
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
                                      style: TextStyle(
                                        fontSize: Dimensions
                                            .fontSizeSmall,
                                        fontFamily:
                                        'Montserrat-Medium',
                                        fontWeight: FontWeight.w500,
                                        color: ThemeColors
                                            .greyTextColor,
                                      ),
                                    ),
                                    Container(
                                      // width: 85,
                                      child: Text(
                                        "12345678",
                                        maxLines: 3,
                                        style: TextStyle(
                                          // overflow:
                                          //     TextOverflow.ellipsis,
                                          fontSize: Dimensions
                                              .fontSizeSmall,
                                          fontFamily:
                                          'Montserrat-Light',
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
      ),
    );
  }

  // DataRow _usersList(LeaderBoardModel? leaderData, indexValue) {
  //   int index = indexValue + 1;
  //   return DataRow(
  //     cells: <DataCell>[
  //       DataCell(Text(
  //         "#$index",
  //         maxLines: 3,
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(
  //             color: Colors.black,
  //             fontFamily: 'Montserrat',
  //             fontSize: 15,
  //             fontWeight: FontWeight.w500),
  //       )),
  //       DataCell(Padding(
  //         padding: EdgeInsets.only(left: 20.0),
  //         child: Row(
  //           children: [
  //             Container(
  //                 decoration: const BoxDecoration(
  //                   borderRadius: BorderRadius.all(Radius.circular(100)),
  //                   // border: Border.all(width: 1),
  //                 ),
  //                 height: 40,
  //                 width: 40,
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(100),
  //                   child: leaderData!.profileImage != null
  //                       ? CustomImage(
  //                     image: leaderData.profileImage,
  //                     fit: BoxFit.cover,
  //                   )
  //                       : SvgPicture.asset(
  //                     Images.avtar_icon, height: 25,
  //                     // color: ThemeColors.greyTextColor,
  //                   ),
  //                 )),
  //             const SizedBox(
  //               width: 4,
  //             ),
  //             Flexible(
  //               child: Text(
  //                 leaderData.leaderboardName ?? "",
  //                 maxLines: 2,
  //                 textAlign: TextAlign.start,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: const TextStyle(
  //                     color: Colors.black,
  //                     fontFamily: 'Montserrat',
  //                     fontSize: 15,
  //                     fontWeight: FontWeight.w500),
  //               ),
  //             ),
  //           ],
  //         ),
  //       )),
  //       DataCell(Align(
  //         alignment: Alignment.centerRight,
  //         child: Text(
  //           leaderData.leaderboardPoints.toString() ?? "0",
  //           textAlign: TextAlign.right,
  //           style: const TextStyle(
  //               color: Colors.black,
  //               fontFamily: 'Montserrat',
  //               fontSize: 15,
  //               fontWeight: FontWeight.w500),
  //         ),
  //       )),
  //     ],
  //   );
  //   ;
  // }
}
