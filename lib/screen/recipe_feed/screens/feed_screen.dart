import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/utils/constants.dart';
import 'package:socialrecipe/src/models/user_model.dart';
import 'package:socialrecipe/screen/recipe_feed/screens/activity_tab.dart';
import 'package:socialrecipe/providers/auth_provider.dart';
import 'package:socialrecipe/providers/settings_provider.dart';
import 'package:socialrecipe/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialrecipe/utils/images.dart';
import 'package:socialrecipe/utils/theme_colors.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _phoneController= TextEditingController();

  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context, listen: false).getUser;
    final appProvider = Provider.of<AuthProvider>(context, listen: false);
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);

    return Theme(
      data: Theme.of(context).copyWith(
        useMaterial3: false,
      ),
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //App Bar
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Expanded(
                        //   flex: 4,
                        //   child: Theme(
                        //     data: ThemeData(
                        //       splashColor: Colors.transparent,
                        //       highlightColor: Colors.transparent,
                        //     ),
                        //     child: TabBar(
                        //       controller: _tabController,
                        //       labelStyle: Theme.of(context)
                        //           .textTheme
                        //           .headline2!
                        //           .copyWith(
                        //             fontSize: 18,
                        //           ),
                        //       tabs: const [
                        //         Tab(text: 'Post'),
                        //       ],
                        //       indicatorPadding:
                        //           const EdgeInsets.only(right: 10),
                        //       labelColor: kOrangeColorTint,
                        //       unselectedLabelColor: settingsManager.darkMode
                        //           ? Colors.white
                        //           : Colors.white,
                        //       indicatorColor: kGreyColor4,
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Row(
                            children: [
                              Image.asset(Images.logo),
                              SizedBox(width: 5,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'AHAR',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Bold',
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    'Connect',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Light',
                                      fontWeight: FontWeight.w400
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){},
                              child: Icon(Icons.notifications,size: 25,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      appProvider.gotToTab(3);
                                    },
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: user == null
                                          ? const Center(
                                              child: LinearProgressIndicator(
                                                color: kOrangeColor,
                                                backgroundColor: Colors.white,
                                              ),
                                            )
                                          : user.photoUrl == ""
                                              ? SizedBox(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(100),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/default_image.jpg'),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(100),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                        color: settingsManager
                                                                .darkMode
                                                            ? kBlackColor
                                                            : Colors.grey.shade400,
                                                        width: 1.5,
                                                      )),
                                                      child: CachedNetworkImage(
                                                        imageUrl: user.photoUrl,
                                                        fit: BoxFit.cover,
                                                        errorWidget:
                                                            (context, url, error) =>
                                                                const Center(
                                                          child: FaIcon(
                                                              FontAwesomeIcons
                                                                  .circleExclamation),
                                                        ),
                                                        placeholder:
                                                            (context, url) =>
                                                                Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.grey.shade400,
                                                          highlightColor:
                                                              Colors.grey.shade300,
                                                          child: SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  3.3,
                                                              width:
                                                                  double.infinity),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 15,),
                    //Search Field
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: TextFormField(
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Search';
                                  }
                                  return null;
                                },
                                controller: _phoneController,
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                style: Theme.of(context).textTheme.headline3!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                // controller: _nameController,
                                cursorColor: kOrangeColor,
                                autofocus: false,
                                autocorrect: false,
                                keyboardType: TextInputType.text,

                                obscureText: false,
                                textInputAction: TextInputAction.done,
                                decoration:
                                InputDecoration(
                                  counterText: ' ',
                                  fillColor: settingsManager.darkMode
                                      ? kGreyColor
                                      : ThemeColors.textFieldBackgroundColor,
                                  filled: true,
                                  // isCollapsed: true,
                                  contentPadding: const EdgeInsets.all(18),
                                  hintText: 'Search',
                                  hintStyle:
                                  Theme.of(context).textTheme.headline4!.copyWith(
                                    fontSize: 16,
                                    color: ThemeColors.greyTextColor,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  focusedErrorBorder: kFocusedErrorBorder,
                                  errorBorder: kErrorBorder,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColors.textFieldBackgroundColor),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColors.textFieldBackgroundColor),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColors.textFieldBackgroundColor),
                                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0,right: 8),
                            child: Container(
                                height: 60,
                                width: 60,
                                // margin: const EdgeInsets.all(15.0),
                                // padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  color: ThemeColors.textFieldBackgroundColor,
                                    // border: Border.all(color: Colors.blueAccent),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(15.0) //                 <--- border radius here
                                  ),                            ),
                                child: ImageIcon(AssetImage('assets/filter.png'))),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Feed ',
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: double.maxFinite,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          ActivityTab(user: user),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
