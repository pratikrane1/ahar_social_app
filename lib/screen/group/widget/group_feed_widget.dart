import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialrecipe/screen/profile/screens/profile_screen.dart';
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

class GroupFeedWidget extends StatefulWidget {
  const GroupFeedWidget({Key? key}) : super(key: key);

  @override
  State<GroupFeedWidget> createState() => _GroupFeedWidgetState();
}

class _GroupFeedWidgetState extends State<GroupFeedWidget>
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
                child: SizedBox(
                  height: double.maxFinite,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ActivityTab(user: user),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
