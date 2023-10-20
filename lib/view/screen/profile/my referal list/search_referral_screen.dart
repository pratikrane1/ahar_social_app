// import 'package:destek_pro/controller/search_controller.dart';
// import 'package:destek_pro/data/model/product_model.dart';
// import 'package:destek_pro/util/dimensions.dart';
// import 'package:destek_pro/util/theme_colors.dart';
// import 'package:destek_pro/view/base/custom_snackbar.dart';
// import 'package:destek_pro/view/base/search_field.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SearchReferralScreen extends StatefulWidget {
//   const SearchReferralScreen({super.key});
//
//   @override
//   State<SearchReferralScreen> createState() => _SearchReferralScreenState();
// }
//
// class _SearchReferralScreenState extends State<SearchReferralScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   List<SearchUserModel>? _searchUserList;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _searchController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if(Get.find<SearchController>().isSearchMode) {
//           return true;
//         }else {
//           Get.find<SearchController>().setSearchMode(true);
//           return false;
//         }
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
//             child: GetBuilder<SearchController>(builder: (searchController) {
//               _searchController.text = searchController.searchText;
//               _searchUserList = searchController.searchUserList;
//               _isLoading = searchController.isLoading;
//                 return Column(
//                   children: [
//                     Center(
//                         child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Row(children: [
//                       const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//                       Expanded(child: SearchField(
//                         controller: _searchController,
//                         hint: 'search_referral_name'.tr,
//                         suffixIcon: Icons.search,
//                         iconPressed: () => _actionSearch(true, _searchController.text.trim(), false),
//                         onSubmit: (text) => _actionSearch(true, _searchController.text.trim(), false),
//                       )),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: InkWell(
//                           onTap: () => searchController.isSearchMode ? Navigator.pop(context) : searchController.setSearchMode(true),
//                           child: Text("cancel".tr,style: const TextStyle(
//                               fontSize: 14,
//                               fontFamily:
//                               'Montserrat',
//                               fontWeight:
//                               FontWeight.w600,
//                               color: ThemeColors.blackColor,
//                           ),
//                           ),
//                         ),
//                       ),
//
//                     ]))),
//                     const SizedBox(height: 20.0,),
//                     Get.find<SearchController>().isSearchMode ? const SizedBox() : _isLoading ? _searchUserList!.isNotEmpty ?
//                     Expanded(
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.vertical,
//                           child: DataTable(
//                             dividerThickness: 1.0,
//                             headingRowHeight: 25,
//                             columnSpacing: 20.0,
//                             columns: [
//                               DataColumn(
//                                 label: Text('name'.tr,
//                                   maxLines: 2,softWrap: true,
//                                   style:const TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'Montserrat-Medium',
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600),),
//                               ),
//                               DataColumn(
//                                 label: Text('referred_by'.tr,
//                                   maxLines: 2,softWrap: true,
//                                   style:const TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: 'Montserrat-Medium',
//                                       fontSize: 11,
//                                       fontWeight: FontWeight.w600),),
//                               ),
//                             ],
//                             rows:  List.generate(_searchUserList!.length, (_) {
//                               return _payOutBreakThrough(_searchUserList![_]);
//                             }),
//                           ),
//                         ),
//                       ),
//                     ) :  Padding(
//                       padding: EdgeInsets.only(top: 200.0),
//                       child: Center(child: Text("no_such_person_in_your_referral_network".tr,
//                           textAlign: TextAlign.center,
//                           style:const TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Montserrat-Medium',
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600)),),
//                     ) : const Padding(
//                       padding: EdgeInsets.only(top: 200.0),
//                       child: Center(child: CircularProgressIndicator(color: ThemeColors.primaryColor,),),
//                     )
//                   ],
//                 );
//               }
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   void _actionSearch(bool isSubmit, String queryText, bool fromHome) {
//     if(Get.find<SearchController>().isSearchMode || isSubmit) {
//       if(queryText.isNotEmpty) {
//         Get.find<SearchController>().searchData(queryText,);
//       }else {
//         showCustomSnackBar('enter_referral_name'.tr);
//       }
//     }
//   }
//
//   DataRow _payOutBreakThrough(SearchUserModel? _searchUserList) {
//     return DataRow(
//       cells: <DataCell>[
//         DataCell(SizedBox(width: MediaQuery.of(context).size.width/4,
//           child: Text(_searchUserList!.registerName ?? "",
//             // maxLines: 3,
//             style: const TextStyle(
//                 color: Colors.black,
//                 fontFamily: 'Montserrat',
//                 fontSize: 11,
//                 fontWeight: FontWeight.w500),),
//         )),
//         DataCell(Text(_searchUserList.ref ?? "",
//           style: const TextStyle(
//               color: Colors.black,
//               fontFamily: 'Montserrat',
//               fontSize: 11,
//               fontWeight: FontWeight.w500),)),
//       ],
//     );
//   }
//
// }
