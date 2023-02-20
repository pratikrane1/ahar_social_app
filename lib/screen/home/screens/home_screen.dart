import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/providers/dynamic_link.dart';
import 'package:socialrecipe/screen/create_recipe_post/screens/add_recipe_post_screen.dart';
import 'package:socialrecipe/screen/recipe_feed/screens/feed_screen.dart';
import 'package:socialrecipe/screen/profile/screens/profile_screen.dart';
import 'package:socialrecipe/screen/search_user/screens/search_user_screen.dart';
import 'package:socialrecipe/providers/auth_provider.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

import '../../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  // PersistentTabController? _controller;
  PageController? _pageController;
  int _pageIndex = 0;
  List<Widget>? _screens;



  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    await userProvider.refreshUser().whenComplete(() {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    DynamicLinkService.initDynamicLinks(context);
    // _controller = PersistentTabController(initialIndex: 0);
    _pageController = PageController(initialPage: 0);
    _screens = [
      const FeedScreen(),
      Container(),
      const AddRecipePostScreen(),
      const SearchUserScreen(),
      ProfileScreen(
        userId: auth?.uid,
      ),
    ];

  }



  static User? auth = FirebaseAuth.instance.currentUser;


  void _setPage(int pageIndex) {
    setState(() {
      _pageController!.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Consumer<AuthProvider>(
            builder: (context, manager, child) {
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
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: ThemeColors.blackColor,
                      child: const Icon(Icons.add_circle_outline_rounded,size: 30,),
                      onPressed: () {
                        _setPage(2);
                        _pageIndex == 2;
                      },
                    ),
                    bottomNavigationBar: BottomAppBar(
                      shape: CircularNotchedRectangle(),
                      elevation: 5,
                      notchMargin: 10,
                      clipBehavior: Clip.antiAlias,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: ImageIcon(AssetImage('assets/home_icon.png')),
                            onPressed: () {_setPage(0);_pageIndex == 0;},
                            color: _pageIndex == 0 ? ThemeColors.selectedIconColor : ThemeColors.blackColor,
                          ),
                          IconButton(
                            icon:ImageIcon(AssetImage('assets/noticeboard.png')),
                            onPressed: () {_setPage(1);_pageIndex == 1;},
                            color: _pageIndex == 1 ? ThemeColors.selectedIconColor : ThemeColors.blackColor,

                          ),
                          IconButton(
                            icon:SizedBox(),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: ImageIcon(AssetImage('assets/person.png')),
                            onPressed: () {_setPage(3);_pageIndex==3;},
                            color: _pageIndex == 3 ? ThemeColors.selectedIconColor : ThemeColors.blackColor,

                          ),

                          IconButton(
                            icon: ImageIcon(AssetImage('assets/chat.png')),
                            onPressed: () {_setPage(4);_pageIndex==4;},
                            color: _pageIndex == 4 ? ThemeColors.selectedIconColor : ThemeColors.blackColor,

                          )
                        ],
                      ),
                    ),
                    // PersistentTabView(
                    //   context,
                    //   controller: _controller,
                    //   screens: _buildScreens(),
                    //   items: _navBarsItems(),
                    //   confineInSafeArea: true,
                    //   backgroundColor: Colors.white, // Default is Colors.white.
                    //   handleAndroidBackButtonPress: true, // Default is true.
                    //   resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
                    //   stateManagement: true, // Default is true.
                    //   hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
                    //   decoration: NavBarDecoration(
                    //     borderRadius: BorderRadius.circular(10.0),
                    //     colorBehindNavBar: Colors.white,
                    //   ),
                    //   popAllScreensOnTapOfSelectedTab: true,
                    //   popActionScreens: PopActionScreensType.all,
                    //   itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
                    //     duration: Duration(milliseconds: 200),
                    //     curve: Curves.ease,
                    //   ),
                    //   screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
                    //     animateTabTransition: true,
                    //     curve: Curves.ease,
                    //     duration: Duration(milliseconds: 200),
                    //   ),
                    //   navBarStyle: NavBarStyle.style16, // Choose the nav bar style with this property.
                    // )
                    // ClipRect(
                    //   child: BackdropFilter(
                    //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 20),
                    //     child: BottomNavigationBar(
                    //       backgroundColor: Colors.white,
                    //       elevation: 1,
                    //       unselectedItemColor: kGreyColor3,
                    //       showSelectedLabels: false,
                    //       showUnselectedLabels: true,
                    //       onTap: (index) {
                    //         manager.gotToTab(index);
                    //       },
                    //       currentIndex: manager.selectedTab,
                    //       type: BottomNavigationBarType.fixed,
                    //       iconSize: 20,
                    //       items: const [
                    //         BottomNavigationBarItem(
                    //           icon: FaIcon(
                    //             FontAwesomeIcons.houseCircleCheck,
                    //           ),
                    //           label: 'Home',
                    //         ),
                    //         BottomNavigationBarItem(
                    //           icon: FaIcon(
                    //             FontAwesomeIcons.userGroup,
                    //           ),
                    //           label: 'Friends',
                    //         ),
                    //         BottomNavigationBarItem(
                    //           icon: FaIcon(
                    //             FontAwesomeIcons.solidSquarePlus,
                    //           ),
                    //           label: 'Add Recipe',
                    //         ),
                    //         BottomNavigationBarItem(
                    //           icon: FaIcon(
                    //             FontAwesomeIcons.solidUser,
                    //           ),
                    //           label: 'Profile',
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              );
            },
          );
  }
}
