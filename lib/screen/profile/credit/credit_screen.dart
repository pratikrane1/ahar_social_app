import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aharconnect/utils/theme_colors.dart';

class CreditScreen extends StatelessWidget {
  const CreditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        title: Text(
          'Credits'.tr,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: false,
        elevation: 3.0,
        bottomOpacity: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Ahar App Team",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.blackColor)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CreditWidget1(context, "Concept By",
                "Mandar Lande,\nAnirudha Kotgire,\nShweta Dugad"),
            const SizedBox(
              height: 20,
            ),
            CreditWidget2(context, "UI UX Designer ", "Arpan Kumar"),
            const SizedBox(
              height: 20,
            ),
            CreditWidget1(context, "Technology Architect ", "Pankaj Dhote"),
            const SizedBox(
              height: 20,
            ),
            CreditWidget2(context, "Project Manager", "Nikhil Kamble"),
            const SizedBox(
              height: 20,
            ),
            CreditWidget1(context, "Backend Developer",
                "Numair Antule,\nAkansha Shrivastava, \nAjay Singh"),
            const SizedBox(
              height: 20,
            ),
            CreditWidget2(context, "Mobile Developer",
                "Pratik Rane,\nDhanshri Gunjawate"),
            const SizedBox(
              height: 20,
            ),
            CreditWidget1(context, "QA Engineer", "Pramod Gaikwad"),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget CreditWidget1(BuildContext context, String designation, String name) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Container(
                height: 125,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: const BoxDecoration(
                  color: ThemeColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.greyTextColor,
                      blurRadius: 3,
                      spreadRadius: 0.2,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //     decoration: const BoxDecoration(
                      //       borderRadius: BorderRadius.all(Radius.circular(100)),
                      //       // border: Border.all(width: 1),
                      //     ),
                      //     height: 60,
                      //     width: 60,
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(100),
                      //       child:  SvgPicture.asset(
                      //         Images.avtar_icon, height: 25,
                      //         // color: ThemeColors.greyTextColor,
                      //       ),
                      //     )),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text("$name",
                            style: const TextStyle(
                                height: 1.4,
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.blackColor)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 40,
            child: Center(
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.9,
                decoration: const BoxDecoration(
                  color: ThemeColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: Text("$designation",
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: ThemeColors.whiteColor)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CreditWidget2(BuildContext context, String designation, String name) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: Container(
                height: 125,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: const BoxDecoration(
                  color: ThemeColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.greyTextColor,
                      blurRadius: 3,
                      spreadRadius: 0.2,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //     decoration: const BoxDecoration(
                      //       borderRadius: BorderRadius.all(Radius.circular(100)),
                      //       // border: Border.all(width: 1),
                      //     ),
                      //     height: 60,
                      //     width: 60,
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(100),
                      //       child:  SvgPicture.asset(
                      //         Images.avtar_icon, height: 25,
                      //         // color: ThemeColors.greyTextColor,
                      //       ),
                      //     )),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text("$name",
                            style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                color: ThemeColors.blackColor)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 60,
            child: Center(
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width / 1.9,
                decoration: const BoxDecoration(
                  color: ThemeColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("$designation",
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            color: ThemeColors.whiteColor)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
