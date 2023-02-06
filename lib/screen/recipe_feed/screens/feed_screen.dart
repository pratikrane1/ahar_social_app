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

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: TabBar(
                              controller: _tabController,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline2!
                                  .copyWith(
                                    fontSize: 18,
                                  ),
                              tabs: const [
                                Tab(text: 'Social Recipe'),
                              ],
                              indicatorPadding:
                                  const EdgeInsets.only(right: 10),
                              labelColor: kOrangeColorTint,
                              unselectedLabelColor: settingsManager.darkMode
                                  ? Colors.white
                                  : Colors.white,
                              indicatorColor: kGreyColor4,
                            ),
                          ),
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
