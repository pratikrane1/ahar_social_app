// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// // ignore: must_be_immutable
// class MyAutoPullReferalScreen extends StatefulWidget {
//   const MyAutoPullReferalScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MyAutoPullReferalScreen> createState() =>
//       _MyAutoPullReferalScreenState();
// }
//
// class _MyAutoPullReferalScreenState extends State<MyAutoPullReferalScreen> {
//   bool _isExpanded = true;
//   bool _isLoading = false;
//   List<ReferalDirectReferrals>? _referralDirectList;
//   List<ReferalDirectReferrals>? _referralDirectList2;
//
//   @override
//   void initState() {
//     super.initState();
//     Get.find<ReferController>()
//         .getAutoPullReferalsList(Get.find<AuthController>().getUserId(),'0','0',true);
//     // Get.find<ReferController>().getAutoPullReferalsList(85);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   _onExpansionChanged(bool val) {
//     setState(() {
//       _isExpanded = val;
//     });
//   }
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
//                 _referralDirectList2 = await Get.find<ReferController>()
//                     .getAutoPullReferalsList(_referralDirectList[index].id!,_referralDirectList[index].autoPullLinkedTo ?? '0',
//                   _referralDirectList[index].level!.toString(),false);
//                 _referralDirectList[currentIndex].refers!.addAll(
//                     _referralDirectList2 as Iterable<ReferalDirectReferrals>);
//                 for (int i = 0;
//                     i < _referralDirectList[currentIndex].refers!.length;
//                     i++) {
//                   _referralDirectList[currentIndex].refers![i].color = color;
//                 }
//                 if (_referralDirectList2!.isEmpty) {
//                   setState(() {
//                     _referralDirectList[index].isLoading = false;
//                   });
//                 }
//                 final ids = _referralDirectList[currentIndex]
//                     .refers!
//                     .map((e) => e.id)
//                     .toSet();
//                 _referralDirectList[currentIndex]
//                     .refers!
//                     .retainWhere((x) => ids.remove(x.id));
//                 // }
//                 setState(() {
//                   _referralDirectList[index].expanded = expanded;
//                 });
//               }
//             },
//             title: Row(
//               children: [
//                 Icon(Icons.person, color: _referralDirectList[index].color),
//                 const SizedBox(
//                   width: 4,
//                 ),
//                 Expanded(
//                   child: RichText(
//                     text: TextSpan(
//                       text: '${_referralDirectList[index].registerName}',
//                       style: TextStyle(
//                           fontSize: 12,
//                           fontFamily: 'Montserrat',
//                           fontWeight: FontWeight.w600,
//                           color: _referralDirectList[index].color),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             trailing:
//                 // _referralDirectList[index].directReferalCount == '0'
//                 //     ? const SizedBox() :
//                 _referralDirectList[index].expanded!
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
//                       padding: const EdgeInsets.only(left: 15.0),
//                       child: referListOfList(
//                           _referralDirectList[index].refers!,
//                           _referralDirectList[index]
//                               .directReferalCount
//                               .toString(),
//                           _referralDirectList[index].isLoading!))
//                   : Container(),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget referListOfList(List<ReferalDirectReferrals> referList,
//       String directCount, bool isLoading) {
//     return isLoading
//         ? referList.length > 0
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 physics: const ScrollPhysics(),
//                 scrollDirection: Axis.vertical,
//                 // padding: const EdgeInsets.only(
//                 //     bottom: 15, ),
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
//                         _referralDirectList2 = await Get.find<ReferController>()
//                             .getAutoPullReferalsList(referList[index].id!,referList[index].autoPullLinkedTo  ?? '0',
//                             referList[index].level!.toString(),false);
//                         referList[currentIndex].refers!.addAll(
//                             _referralDirectList2
//                                 as Iterable<ReferalDirectReferrals>);
//                         for (int i = 0;
//                             i < referList[currentIndex].refers!.length;
//                             i++) {
//                           referList[currentIndex].refers![i].color = color;
//                         }
//                         if (_referralDirectList2!.isEmpty) {
//                           setState(() {
//                             referList[index].isLoading = false;
//                           });
//                         }
//                         final ids = referList[currentIndex]
//                             .refers!
//                             .map((e) => e.id)
//                             .toSet();
//                         referList[currentIndex]
//                             .refers!
//                             .retainWhere((x) => ids.remove(x.id));
//                       }
//                       setState(() {
//                         referList[index].expanded = expanded;
//                       });
//                       // }
//                     },
//                     title: Row(
//                       children: [
//                         Icon(Icons.person, color: referList[index].color),
//                         const SizedBox(
//                           width: 4,
//                         ),
//                         Expanded(
//                           child: RichText(
//                             text: TextSpan(
//                               text: '${referList[index].registerName} ',
//                               style: const TextStyle(
//                                   fontSize: 12,
//                                   fontFamily: 'Montserrat',
//                                   fontWeight: FontWeight.w600,
//                                   color: ThemeColors.blackColor),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     trailing:
//                         // referList[index].directReferalCount == "0"
//                         //     ? const SizedBox() :
//                         referList[index].expanded!
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
//                         padding: const EdgeInsets.only(left: 15.0),
//                         child: referListOfList(
//                             referList[index].refers!,
//                             referList[index].directReferalCount.toString(),
//                             referList[index].isLoading!),
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
//         : Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Center(
//                 child: Text(
//               "no_new_joinees_yet".tr,
//               style: const TextStyle(
//                   fontSize: 12,
//                   fontFamily: 'Montserrat',
//                   fontWeight: FontWeight.w500,
//                   color: ThemeColors.blackColor),
//             )),
//           );
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
//             "my_autopull_referral_list".tr,
//             maxLines: 2,
//             style: Theme.of(context).textTheme.headline6!.copyWith(
//                   fontSize: Dimensions.fontSizeExtraLarge,
//                   fontWeight: FontWeight.w600,
//                   fontFamily: 'Montserrat',
//                 ),
//           ),
//           // centerTitle: true,
//           elevation: 0.0,
//           bottomOpacity: 0.0,
//         ),
//         body: RefreshIndicator(
//           color: ThemeColors.primaryColor,
//           onRefresh: () async {
//             await Get.find<ReferController>().getAutoPullReferalsList(
//                 Get.find<AuthController>().getUserId(),"0","0",true);
//           },
//           child: GetBuilder<ReferController>(builder: (referController) {
//             _referralDirectList2 = referController.autoPullReferalList;
//             _referralDirectList = referController.autoPullReferalList2;
//             _isLoading = referController.isLoading;
//             return _isLoading
//                 ? _referralDirectList!.isNotEmpty
//                     ? Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               Flexible(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         color: ThemeColors.greyTextColor),
//                                   ),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Container(
//                                         decoration: const BoxDecoration(
//                                           border: Border(
//                                               bottom: BorderSide(
//                                                   width: 1,
//                                                   color: ThemeColors
//                                                       .greyTextColor)),
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 15.0,
//                                               right: 28.0,
//                                               top: 10.0,
//                                               bottom: 10.0),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text("my_autopull_referral".tr,
//                                                   style: const TextStyle(
//                                                       fontSize: 14,
//                                                       fontFamily: 'Montserrat',
//                                                       fontWeight:
//                                                           FontWeight.w600,
//                                                       color: ThemeColors
//                                                           .blackColor)),
//                                               // Text("Level",
//                                               //     style: TextStyle(
//                                               //         fontSize: 14,
//                                               //         fontFamily: 'Montserrat',
//                                               //         fontWeight: FontWeight.w600,
//                                               //         color: ThemeColors.blackColor)),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//
//                                       ///My Autopull Referral Refer List
//                                       Flexible(
//                                         child: referList(
//                                           _referralDirectList,
//                                         ),
//                                         // ListView(
//                                         //   // children: basicTiles.map(buildTile).toList(),
//                                         //   children: referList(basicTiles),
//                                         // ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : Padding(
//                         padding: const EdgeInsets.only(top: 50.0),
//                         child: Column(
//                           // mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Center(
//                               child: Container(
//                                 // height: 40,
//                                 // width: 40,
//
//                                 child:
//                                     Image.asset(Images.referral_list_no_data),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               "youre_just_one_step_away_from_earning".tr,
//                               textAlign: TextAlign.center,
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: 'Montserrat',
//                               ),
//                             ),
//                           ],
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
// }
