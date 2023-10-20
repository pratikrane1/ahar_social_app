// import 'dart:math';
//
// import 'package:destek_pro/controller/my_account_controller.dart';
// import 'package:destek_pro/controller/refer_controller.dart';
// import 'package:destek_pro/data/model/profile_model.dart';
// import 'package:destek_pro/data/model/referal_model.dart';
// import 'package:destek_pro/helper/route_helper.dart';
// import 'package:destek_pro/util/dimensions.dart';
// import 'package:destek_pro/util/images.dart';
// import 'package:destek_pro/util/theme_colors.dart';
// import 'package:destek_pro/view/screens/profile/my%20referal%20list/search_referral_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../../controller/auth_controller.dart';
//
// // ignore: must_be_immutable
// class ReferalListScreen extends StatefulWidget {
//   const ReferalListScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ReferalListScreen> createState() => _ReferalListScreenState();
// }
//
// class _ReferalListScreenState extends State<ReferalListScreen> {
//   bool _isExpanded = false;
//   ReferalMainMaster? _referralMaster;
//   List<ReferalDirectReferrals>? _referralDirectList;
//   List<ReferalDirectReferrals>? _referralDirectList2;
//   Profile? _profileData;
//   Profile? get profileData => _profileData;
//   bool _isReferalLoading = false;
//   List<dynamic>? _referralLevelCount;
//   ScrollController _scrollControllerHorizontal = ScrollController();
//   ScrollController _scrollControllerVertical = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUserProfile();
//     Get.find<ReferController>()
//         .getReferalsList(Get.find<AuthController>().getUserId(), "0");
//     Get.find<ReferController>().getReferralLevelCount(
//       Get.find<AuthController>().getUserId(),
//     );
//   }
//
//   void fetchUserProfile() async {
//     _profileData = await Get.find<MyAccountController>().profileData;
//     if (_profileData == null) {
//       _profileData = await Get.find<MyAccountController>().getProfileData();
//     }
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//
//   Widget referList(List<ReferalDirectReferrals>? _referralDirectList) {
//     return ListView.builder(
//       shrinkWrap: true,
//       // physics: const ScrollPhysics(),
//       physics:
//           const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
//       scrollDirection: Axis.vertical,
//       itemCount: _referralDirectList!.length,
//       itemBuilder: (context, index) {
//         int index0 = 0;
//         return Container(
//           decoration: BoxDecoration(
//             border: Border(
//                 bottom: BorderSide(
//                     width: index == _referralDirectList.length - 1 ? 0 : 1,
//                     color: ThemeColors.greyTextColor)),
//           ),
//           child: ExpansionTile(
//             initiallyExpanded:
//                 _referralDirectList[index].expanded! ? true : false,
//             maintainState: true,
//             shape: Border.all(color: Colors.transparent),
//             onExpansionChanged: (bool expanded) async {
//               int currentIndex = index;
//               print(currentIndex);
//
//               setState(() {
//                 _referralDirectList[index].expanded = expanded;
//                 _referralDirectList[index].isLoading = true;
//               });
//
//               // Color? color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
//               Color? color =
//                   Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
//
//               ///Function for Api Call And Add Data To Array
//               if (expanded == true) {
//                 if (_referralDirectList[index].isTreeData == "1") {
//                   _referralDirectList2 = await Get.find<ReferController>()
//                       .getReferalsList(_referralDirectList[index].id!,
//                           _referralDirectList[index].level.toString());
//                   _referralDirectList[currentIndex].refers!.addAll(
//                       _referralDirectList2 as Iterable<ReferalDirectReferrals>);
//                   for (int i = 0;
//                       i < _referralDirectList[currentIndex].refers!.length;
//                       i++) {
//                     _referralDirectList[currentIndex].refers![i].color = color;
//                   }
//                   if (_referralDirectList2!.isEmpty) {
//                     setState(() {
//                       _referralDirectList[index].isLoading = false;
//                     });
//                   }
//                   final ids = _referralDirectList[currentIndex]
//                       .refers!
//                       .map((e) => e.id)
//                       .toSet();
//                   _referralDirectList[currentIndex]
//                       .refers!
//                       .retainWhere((x) => ids.remove(x.id));
//                   // }
//                   setState(() {
//                     _referralDirectList[index].expanded = expanded;
//                   });
//                 }
//               }
//             },
//             title: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 2.0),
//                   child: SizedBox(
//                       height: 45,
//                       width: 50,
//                       child: Column(
//                         children: [
//                           const Icon(
//                             Icons.star_border,
//                             color: ThemeColors.redColor,
//                           ),
//                           Text(
//                               "${'level'.tr} ${_referralDirectList[index].level.toString()}",
//                               style: const TextStyle(
//                                   color: ThemeColors.redColor, fontSize: 11)),
//                         ],
//                       ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Flexible(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: RichText(
//                       text: TextSpan(
//                         text: '${_referralDirectList[index].registerName} ',
//                         style: const TextStyle(
//                             fontSize: 12,
//                             fontFamily: 'Montserrat',
//                             fontWeight: FontWeight.w500,
//                             color: ThemeColors.blackColor),
//                         children: <TextSpan>[
//                           const TextSpan(text: "("),
//                           TextSpan(
//                               text:
//                                   "${'direct'.tr} ${_referralDirectList[index].directReferalCount} ${'total'.tr} ${_referralDirectList[index].totalReferalCount ?? 0} "),
//                           TextSpan(text: "|| ${'payment_status'.tr}"),
//                           TextSpan(
//                               text:
//                                   ' ${_referralDirectList[index].paymentStatus} ',
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontFamily: 'Montserrat',
//                                   fontWeight: FontWeight.w500,
//                                   color: _referralDirectList[index]
//                                               .paymentStatus ==
//                                           "${'PAID'}"
//                                       ? ThemeColors.primaryColor
//                                       : ThemeColors.redColor)),
//                           TextSpan(text: "|| ${_referralDirectList[index].plan}"),
//                           const TextSpan(text: ")"),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             trailing: _referralDirectList[index].isTreeData == '0'
//                 ? const SizedBox()
//                 : _referralDirectList[index].expanded!
//                     ? const Icon(
//                         Icons.minimize,
//                         color: Colors.black,
//                         size: 30,
//                       )
//                     : const Icon(
//                         Icons.add,
//                         color: Colors.black,
//                         size: 30,
//                       ),
//             children: [
//               _referralDirectList[index].expanded!
//                   ? Padding(
//                       padding: const EdgeInsets.only(left: 0.0),
//                       child: _referralDirectList[index].refers != null
//                           ? referListOfList(_referralDirectList[index].refers!,
//                               _referralDirectList[index].isTreeData.toString())
//                           : const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                     )
//                   : Container(),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget referListOfList(
//       List<ReferalDirectReferrals> referList, String directCount) {
//     return directCount != '0'
//         ? referList.isNotEmpty
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: const ScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 itemCount: referList.length,
//                 itemBuilder: (context, index) {
//                   return ExpansionTile(
//                     initiallyExpanded:
//                         referList[index].expanded! ? true : false,
//                     shape: Border.all(color: Colors.transparent),
//                     onExpansionChanged: (bool expanded) async {
//                       int currentIndex = index;
//                       print(currentIndex);
//                       setState(() {
//                         referList[index].expanded = expanded;
//                         referList[index].isLoading = true;
//                       });
//
//                       // Color? color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
//                       Color? color =
//                           Color(Random().nextInt(0xffffffff)).withAlpha(0xff);
//
//                       ///Function for Api Call And Add Data To Array
//                       if (expanded == true) {
//                         if (referList[index].isTreeData == "1") {
//                           _referralDirectList2 =
//                               await Get.find<ReferController>().getReferalsList(
//                                   referList[index].id!,
//                                   referList[index].level.toString());
//                           referList[currentIndex].refers!.addAll(
//                               _referralDirectList2
//                                   as Iterable<ReferalDirectReferrals>);
//                           for (int i = 0;
//                               i < referList[currentIndex].refers!.length;
//                               i++) {
//                             referList[currentIndex].refers![i].color = color;
//                           }
//                           if (_referralDirectList2!.isEmpty) {
//                             setState(() {
//                               referList[index].isLoading = false;
//                             });
//                           }
//                           final ids = referList[currentIndex]
//                               .refers!
//                               .map((e) => e.id)
//                               .toSet();
//                           referList[currentIndex]
//                               .refers!
//                               .retainWhere((x) => ids.remove(x.id));
//                         }
//                       }
//                       setState(() {
//                         referList[index].expanded = expanded;
//                       });
//                     },
//                     title: Row(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 2.0),
//                           child: SizedBox(
//                             height: 45,
//                             width: 50,
//                             child: Column(
//                               children: [
//                                 Icon(
//                                   Icons.star_border,
//                                   color: referList[index].color,
//                                 ),
//                                 Text(
//                                     "${'level'.tr} ${referList[index].level.toString()}",
//                                     style:  TextStyle(
//                                         color: referList[index].color, fontSize: 11)),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: RichText(
//                             text: TextSpan(
//                               text: '${referList[index].registerName} ',
//                               style: const TextStyle(
//                                   fontSize: 12,
//                                   fontFamily: 'Montserrat',
//                                   fontWeight: FontWeight.w500,
//                                   color: ThemeColors.blackColor),
//                               children: <TextSpan>[
//                                 const TextSpan(text: "("),
//                                 TextSpan(
//                                     text:
//                                         "${'direct'.tr} ${referList[index].directReferalCount} ${'total'.tr} ${referList[index].totalReferalCount ?? 0} "),
//                                 TextSpan(text: "|| ${'payment_status'.tr}"),
//                                 TextSpan(
//                                     text: ' ${referList[index].paymentStatus} ',
//                                     style: TextStyle(
//                                         fontSize: 12,
//                                         fontFamily: 'Montserrat',
//                                         fontWeight: FontWeight.w500,
//                                         color: referList[index].paymentStatus ==
//                                                 "${'PAID'.tr}"
//                                             ? ThemeColors.primaryColor
//                                             : ThemeColors.redColor)),
//                                 TextSpan(text: "|| ${referList[index].plan}"),
//                                 const TextSpan(text: ")"),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     trailing: referList[index].isTreeData == '0'
//                         ? const SizedBox()
//                         : referList[index].expanded!
//                             ? const Icon(
//                                 Icons.minimize,
//                                 color: Colors.black,
//                                 size: 30,
//                               )
//                             : const Icon(
//                                 Icons.add,
//                                 color: Colors.black,
//                                 size: 30,
//                               ),
//                     children: [
//                       Padding(
//                         // padding: EdgeInsets.only(left: referList[index].level == "10" ? 0.0 : referList[index].level == "20" ? 0.0 : 10.0),
//                         padding: EdgeInsets.only(left: 0.0),
//                         child: referListOfList(referList[index].refers!,
//                             referList[index].isTreeData.toString()),
//                       ),
//                     ],
//                   );
//                 },
//               )
//             : const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Center(
//                   child: SizedBox(
//                     height: 10,
//                     width: 10,
//                     child: CircularProgressIndicator(
//                       color: ThemeColors.primaryColor,
//                     ),
//                   ),
//                 ),
//               )
//         : const SizedBox();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: ThemeColors.whiteColor,
//           leading: IconButton(
//             splashRadius: 20,
//             onPressed: () async {
//               // Get.back();
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//               size: 24,
//             ),
//           ),
//           title: Text(
//             "referral_list".tr,
//             style: Theme.of(context).textTheme.headline6!.copyWith(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Montserrat',
//                 ),
//           ),
//           actions: [
//             IconButton(
//               onPressed: ()async{
//                 // Get.to(()=>SearchReferralScreen());
//                 Navigator.push(context,
//                 MaterialPageRoute(builder: (context)=>const SearchReferralScreen()));
//               },
//               icon: const Icon(Icons.search_rounded,color: ThemeColors.blackColor,),
//             ),
//           ],
//           elevation: 2.0,
//           bottomOpacity: 0.0,
//         ),
//         body: RefreshIndicator(
//           color: ThemeColors.primaryColor,
//           onRefresh: () async {
//             await Get.find<MyAccountController>().getProfileData();
//             await Get.find<ReferController>()
//                 .getReferalsList(Get.find<AuthController>().getUserId(), "0");
//             await Get.find<ReferController>()
//                 .getReferralLevelCount(Get.find<AuthController>().getUserId());
//           },
//           child: GetBuilder<ReferController>(builder: (referController) {
//             _referralDirectList = referController.referalList1;
//             _referralDirectList2 = referController.referalList2;
//             _isReferalLoading = referController.isReferalLoading;
//             _referralLevelCount = referController.referralLevelCount;
//             return _profileData != null
//                 ? _isReferalLoading
//                     ? _referralDirectList2!.isNotEmpty
//                         ? Column(
//                             children: [
//                               _referralLevelCount != null
//                                   ? Container(
//                                       height: 80,
//                                       child: ListView.builder(
//                                         shrinkWrap: true,
//                                         physics: const ScrollPhysics(),
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: _referralLevelCount!.length,
//                                         itemBuilder: (context, index) {
//                                           return Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Container(
//                                               height: 70,
//                                               width: 80,
//                                               decoration: BoxDecoration(
//                                                 color:
//                                                     Theme.of(context).cardColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         Dimensions
//                                                             .RADIUS_SMALL),
//                                                 gradient: const LinearGradient(
//                                                   begin: Alignment.centerLeft,
//                                                   end: Alignment.bottomRight,
//                                                   colors: [
//                                                     ThemeColors.whiteColor,
//                                                     ThemeColors.primaryColor
//                                                   ],
//                                                 ),
//                                                 boxShadow: const [
//                                                   BoxShadow(
//                                                     color: ThemeColors
//                                                         .greyTextColor,
//                                                     blurRadius: 1,
//                                                     spreadRadius: 0.1,
//                                                   )
//                                                 ],
//                                               ),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   Text(
//                                                       "${'level'.tr} ${index + 1}",
//                                                       style: const TextStyle(
//                                                           fontSize: 14,
//                                                           fontFamily:
//                                                               'Montserrat',
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: ThemeColors
//                                                               .blackColor)),
//                                                   Text(
//                                                       "${_referralLevelCount![index]}",
//                                                       style: const TextStyle(
//                                                           fontSize: 14,
//                                                           fontFamily:
//                                                               'Montserrat',
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           color: ThemeColors
//                                                               .blackColor))
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     )
//                                   : Container(),
//                               Expanded(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     padding: const EdgeInsets.all(16.0),
//                                     child: Column(
//                                       children: [
//                                         Flexible(
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   color: ThemeColors
//                                                       .greyTextColor),
//                                             ),
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               children: [
//                                                 Container(
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                     border: Border(
//                                                         bottom: BorderSide(
//                                                             width: 1,
//                                                             color: ThemeColors
//                                                                 .greyTextColor)),
//                                                   ),
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 15.0,
//                                                             right: 28.0,
//                                                             top: 10.0,
//                                                             bottom: 10.0),
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Text("referrals".tr,
//                                                             style: const TextStyle(
//                                                                 fontSize: 14,
//                                                                 fontFamily:
//                                                                     'Montserrat',
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600,
//                                                                 color: ThemeColors
//                                                                     .blackColor)),
//                                                         // Text("level".tr,
//                                                         //     style: const TextStyle(
//                                                         //         fontSize: 14,
//                                                         //         fontFamily:
//                                                         //             'Montserrat',
//                                                         //         fontWeight:
//                                                         //             FontWeight
//                                                         //                 .w600,
//                                                         //         color: ThemeColors
//                                                         //             .blackColor)),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//
//                                                 ///Master User Data
//                                                 _profileData != null
//                                                     ? Container(
//                                                         decoration:
//                                                             const BoxDecoration(
//                                                           border: Border(
//                                                               bottom: BorderSide(
//                                                                   width: 1,
//                                                                   color: ThemeColors
//                                                                       .greyTextColor)),
//                                                         ),
//                                                         child: ExpansionTile(
//                                                           maintainState: true,
//                                                           shape: Border.all(
//                                                               color: Colors
//                                                                   .transparent),
//                                                           onExpansionChanged:
//                                                               (bool expanded) {
//                                                             setState(() {
//                                                               _referralMaster!
//                                                                       .expanded =
//                                                                   expanded;
//                                                             });
//                                                           },
//                                                           title: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 child: RichText(
//                                                                   text:
//                                                                       TextSpan(
//                                                                     text:
//                                                                         '${_profileData!.name} ',
//                                                                     style: const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontFamily:
//                                                                             'Montserrat',
//                                                                         fontWeight:
//                                                                             FontWeight
//                                                                                 .w500,
//                                                                         color: ThemeColors
//                                                                             .blackColor),
//                                                                     children: <
//                                                                         TextSpan>[
//                                                                       TextSpan(
//                                                                           text:
//                                                                               "(${'direct'.tr} ${_profileData!.directRefers ?? "0"} ${'total'.tr} ${_profileData!.totalReferalCount ?? 0} || ${'payment_status'.tr}"),
//                                                                       TextSpan(
//                                                                         text:
//                                                                             ' ${_profileData!.paymentStatus} ',
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontFamily:
//                                                                               'Montserrat',
//                                                                           fontWeight:
//                                                                               FontWeight.w500,
//                                                                           color: _profileData!.paymentStatus == "${'paid'.tr}"
//                                                                               ? ThemeColors.primaryColor
//                                                                               : ThemeColors.redColor,
//                                                                         ),
//                                                                       ),
//                                                                       TextSpan(text: "|| ${_profileData!.plan}"),
//                                                                       const TextSpan(
//                                                                           text:
//                                                                               ")"),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           trailing:
//                                                               const SizedBox(),
//                                                         ),
//                                                       )
//                                                     : Container(),
//
//                                                 ///Refer List
//                                                 Flexible(
//                                                   child: referList(
//                                                       _referralDirectList2
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.only(top: 50.0),
//                             child: Column(
//                               // mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Center(
//                                   child: Container(
//                                     // height: 40,
//                                     // width: 40,
//
//                                     child: Image.asset(
//                                         Images.referral_list_no_data),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   "youre_just_one_step_away_from_earning".tr,
//                                   textAlign: TextAlign.center,
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'Montserrat',
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                     : const Center(
//                         child: CircularProgressIndicator(
//                           color: ThemeColors.primaryColor,
//                         ),
//                       )
//                 : const Center(
//                     child: CircularProgressIndicator(
//                       color: ThemeColors.primaryColor,
//                     ),
//                   );
//           }),
//         ));
//   }
//
//   Widget MyListTable() {
//     return Scrollbar(
//         thumbVisibility: true,
//         trackVisibility: true,
//         controller: _scrollControllerVertical,
//         child: SingleChildScrollView(
//           controller: _scrollControllerVertical,
//           scrollDirection: Axis.vertical,
//           child: Scrollbar(
//             thumbVisibility: true,
//             trackVisibility: true,
//             controller: _scrollControllerHorizontal,
//             child: SingleChildScrollView(
//               controller: _scrollControllerHorizontal,
//               scrollDirection: Axis.horizontal,
//               child: Wrap(
//                 direction: Axis.vertical,
//                 children: List.generate(
//                   40,
//                       (index) => Container(
//                     width: 400,
//                     height: 100,
//                     color: Colors.blue,
//                     margin: EdgeInsets.all(4),
//                     child: Text("oke ${index}"),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }
//
// }
