import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/utils/constants.dart';
import 'package:aharconnect/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class DetailsSliverAppBar extends StatelessWidget {
  const DetailsSliverAppBar({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsProvider>(context, listen: false);
    return SliverAppBar(
      backgroundColor: settingsManager.darkMode ? kBlackColor : Colors.white,
      stretch: true,
      pinned: true,
      floating: false,
      expandedHeight: MediaQuery.of(context).size.height / 3,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: imgUrl,
          // placeholder: (context, url) => const Center(
          //   child: Icon(
          //     FontAwesomeIcons.spinner,
          //     color: Colors.white,
          //   ),
          // ),
          errorWidget: (context, url, error) => const Icon(
            Icons.circle,
            color: Colors.white,
          ),
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.9),
            child: const Icon(
              Icons.arrow_back,
              color: kGreyColor,
              size: 20,
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            debugPrint("Nothing for now.");
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white.withOpacity(0.9),
              child: const Icon(
                Icons.more_vert,
                color: kGreyColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
