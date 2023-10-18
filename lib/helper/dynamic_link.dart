import 'package:aharconnect/screen/home/widget/post_detail_widget.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkService {
  // String shortDynamicLink = 'https://pulabazaarapp.page.link';
  String shortDynamicLink = 'https://aharsocial.page.link';

  @override
  void initState() {
    // super.initState();
  }

  @override
  void shareDynamicLinkProduct({itemUrl}) {
    DynamicLinkService().shareProductLink(
      url: itemUrl,
    );
  }

  DynamicLinkParameters dynamicLinkParameters(
      {Uri? url, String? title, String? image}) {
    return DynamicLinkParameters(
      uriPrefix: shortDynamicLink,
      link: url!,
      androidParameters: AndroidParameters(
        packageName: "com.ahar.social",
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: "",
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        imageUrl: Uri.parse(image!),
      ),
    );
  }

  Future<Uri> generateFirebaseDynamicLink(DynamicLinkParameters params) async {
    var dynamicLinks = FirebaseDynamicLinks.instance;

    if (dynamicLinks != null) {
      var shortDynamicLink = await dynamicLinks.buildShortLink(params);
      return shortDynamicLink.shortUrl;
    } else {
      return await dynamicLinks.buildLink(params);
    }
  }

  /// share product link that contains Dynamic link
  void shareProductLink({
    String? title,
    Uri? url,
    String? image,
  }) async {
    var productParams =
        dynamicLinkParameters(url: url!, image: image!, title: title!);
    var firebaseDynamicLink = await generateFirebaseDynamicLink(productParams);
    print('[firebase-dynamic-link] $firebaseDynamicLink');
    await Share.share(
      "$title\n${firebaseDynamicLink.toString()}",
    );
  }

  static void initDynamicLinks(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      Uri? deepLink = dynamicLinkData.link;
      print('[firebase-dynamic-link] getInitialLink: $deepLink');


      String postId = deepLink.queryParameters['postId']!;
      String zoneId = deepLink.queryParameters['zoneId']!;
      print(postId);
      print(zoneId);


      handleDynamicLink(postId,zoneId, dynamicLinkData.link.path);
    }).onError((e) {
      print('[firebase-dynamic-link] error: ${e.message}');
    });

    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      Uri deepLink = initialLink.link;

      print('[firebase-dynamic-link] getInitialLink: $deepLink');

      String postId = deepLink.queryParameters['postId']!;
      String zoneId = deepLink.queryParameters['zoneId']!;
      print(postId);
      print(zoneId);

      await handleDynamicLink(postId, zoneId, deepLink.path);
    }
  }

  static Future<void> handleDynamicLink(String postId,String zoneId, final url) async {
    bool item = url.contains('/item');
    print(item);

    Get.to(()=>PostDetailScreen(postId: postId,zoneId: zoneId,));
  }
}