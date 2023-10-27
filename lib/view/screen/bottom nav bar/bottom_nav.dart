import 'dart:async';
import 'dart:ui';
import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/view/screen/create_post/screens/add_post_screen.dart';
import 'package:aharconnect/view/screen/group/group_listing_screen.dart';
import 'package:aharconnect/view/screen/home/screens/home_screen1.dart';
import 'package:aharconnect/view/screen/profile/profile.dart';
import 'package:aharconnect/view/screen/zone/zone_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aharconnect/helper/dynamic_link.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key, this.index,this.tabIndex}) : super(key: key);
  int? index;
  int? tabIndex;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController? _pageController;
  int _pageIndex = 0;
  int _tabIndex = 0;
  List<Widget>? _screens;
  bool _canExit = GetPlatform.isWeb ? true : false;

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      _pageIndex = widget.index!.toInt();
    }
    if (widget.tabIndex != null) {
      _tabIndex = widget.tabIndex!.toInt();
    }
    DynamicLinkService.initDynamicLinks(context);
    _pageController = PageController(
        initialPage: widget.index != null ? widget.index!.toInt() : 0);
    _screens = [
      const HomeTab(),
      ZoneScreen(tabIndex: _tabIndex),
      // (Get.find<AuthController>().getUserRole() != "Member") ?
      const AddPostScreen(),
      // : SizedBox(),
      const GroupListScreen(),
      const ProfileScreen()
    ];
    // if(Get.find<AuthController>().getUserRole() != "Member"){
    //   _screens.removeAt(index)
    // }
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          if (_pageIndex != 0) {
            _setPage(0);
            return false;
          } else {
            if(_canExit) {
              return true;
            }else {
              var value = await showExitPopup();
              return value;
            }
          }
        },
        child: Scaffold(
          extendBody: false,
          resizeToAvoidBottomInset: false,
          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens![index];
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              (Get.find<AuthController>().getUserRole() != "Member")
                  ? FloatingActionButton(
                      backgroundColor: ThemeColors.blackColor,
                      child: const Icon(
                        Icons.add_circle_outline_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        _setPage(2);
                        _pageIndex == 2;
                      },
                    )
                  : null,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.white,
                backgroundColor: Colors.white,
                bottomAppBarColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.white)),
            child: BottomAppBar(
              color: Colors.white,
              shape: CircularNotchedRectangle(),
              elevation: 5,
              notchMargin: 10,
              clipBehavior: Clip.antiAlias,
              child: Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.home_outlined,
                          size: 28,
                        ),
                        onPressed: () {
                          _setPage(0);
                          _pageIndex == 0;
                        },
                        color: _pageIndex == 0
                            ? ThemeColors.selectedIconColor
                            : ThemeColors.blackColor,
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          'assets/noticeboard.svg',
                          color: _pageIndex == 1
                              ? ThemeColors.selectedIconColor
                              : ThemeColors.blackColor,
                        ),
                        onPressed: () {
                          _setPage(1);
                          _pageIndex == 1;
                        },
                        color: _pageIndex == 1
                            ? ThemeColors.selectedIconColor
                            : ThemeColors.blackColor,
                      ),
                      if (Get.find<AuthController>().getUserRole() != "Member")
                        IconButton(
                          icon: SizedBox(),
                          onPressed: () {},
                        ),
                      IconButton(
                        icon: const Icon(
                          Icons.group,
                          size: 25,
                        ),
                        onPressed: () {
                          _setPage(3);
                          _pageIndex == 3;
                        },
                        color: _pageIndex == 3
                            ? ThemeColors.selectedIconColor
                            : ThemeColors.blackColor,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.account_circle,
                          size: 25,
                        ),
                        onPressed: () {
                          _setPage(4);
                          _pageIndex == 4;
                        },
                        color: _pageIndex == 4
                            ? ThemeColors.selectedIconColor
                            : ThemeColors.blackColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
      //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) => AlertDialog(
        title: Text('exit_app'.tr),
        content: Text('do_you_want_to_exit'.tr),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                  color: ThemeColors.primaryColor, width: 1),
              backgroundColor: ThemeColors.primaryColor,
              // color:Colors.red,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            //return false when click on "NO"
            child: Text('no'.tr),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              side: const BorderSide(
                  color: ThemeColors.primaryColor, width: 1),
              backgroundColor: ThemeColors.primaryColor,
              // color:Colors.red,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            //return true when click on "Yes"
            child: Text('yes'.tr),
          ),
        ],
      ),
    ) ??
        false; //if showDialouge had returned null, then return false
  }

}
