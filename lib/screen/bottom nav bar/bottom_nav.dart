import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aharconnect/providers/dynamic_link.dart';
import 'package:aharconnect/screen/create_recipe_post/screens/add_recipe_post_screen.dart';
import 'package:aharconnect/screen/group/group_listing_screen.dart';
import 'package:aharconnect/screen/group/group_screen.dart';
import 'package:aharconnect/screen/home/screens/home_screen1.dart';
import 'package:aharconnect/screen/profile/profile.dart';
import 'package:aharconnect/utils/theme_colors.dart';


class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key? key,
    this.index
  }) : super(key: key);
  int? index;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;


  @override
  void initState() {
    super.initState();
    if(widget.index != null){
      _pageIndex = widget.index!.toInt();
    }
    DynamicLinkService.initDynamicLinks(context);
    _pageController = PageController(initialPage: widget.index != null ? widget.index!.toInt() : 0);
    _screens = [
      const HomeTab(),
      const ZoneScreen(),
      const AddRecipePostScreen(),
      const GroupListScreen(),
      const ProfileScreen()
    ];
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
          return false;
        },
        child: Scaffold(
          extendBody: false,
          resizeToAvoidBottomInset: false,
          body: PageView.builder(
            controller: _pageController,
            itemCount: _screens!.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _screens![index];
            },
          ),
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: ThemeColors.blackColor,
            child: const Icon(
              Icons.add_circle_outline_rounded,
              size: 30,
            ),
            onPressed: () {
              _setPage(2);
              _pageIndex == 2;
            },
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.white,
                primaryColor: Colors.white,
                backgroundColor: Colors.white,
                bottomAppBarColor: Colors.white,
                bottomNavigationBarTheme:
                const BottomNavigationBarThemeData(
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
                  padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0),
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
}
