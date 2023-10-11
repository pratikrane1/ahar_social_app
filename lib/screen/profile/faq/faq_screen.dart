import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:aharconnect/utils/theme_colors.dart';


// ignore: must_be_immutable
class HelpCentreScreen extends StatefulWidget {
  const HelpCentreScreen({Key? key}) : super(key: key);

  @override
  State<HelpCentreScreen> createState() => _HelpCentreScreenState();
}

class _HelpCentreScreenState extends State<HelpCentreScreen> {
  // List<FaqModel>? _faqList;
  @override
  void initState() {
    super.initState();
    // Get.find<MyAccountController>().getFaqList();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          backgroundColor: ThemeColors.whiteColor,
          surfaceTintColor: ThemeColors.whiteColor,
          // leadingWidth: 200,
          leading: IconButton(
                splashRadius: 20,
                onPressed: () {
                  Navigator.pop(context);
                  // Get.offNamed(RouteHelper.getInitialRoute(3.toString()));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 24,
                ),
              ),
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "FAQS".tr,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          // centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  // padding: const EdgeInsets.only(
                  //     bottom: 15, ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      surfaceTintColor: Colors.white,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const ExpansionTile(
                        backgroundColor: ThemeColors.whiteColor,
                        tilePadding: EdgeInsets.only(
                            left: 10, top: 10, bottom: 5,right: 15),
                        title: Text(
                            "Question",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat-Regular',
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20.0,right: 10,bottom: 5),
                            child: Text(
                                "Answer",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat-Regular',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
    );
  }
}
