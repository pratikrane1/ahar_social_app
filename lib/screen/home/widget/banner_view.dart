import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/widget/custom_image.dart';

class BannerView extends StatelessWidget {
  BannerView();

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    List? bannerList = [
      "http://ahar.ezii.live/public/assets/img/img1.png",
      "https://www.ahar.in/wp-content/uploads/2023/01/Office-Bearers-AHAR-Team-2023.jpg",
      "https://www.ahar.in/wp-content/uploads/2023/01/WhatsApp-Image-2023-01-21-at-11.11.42-AM-1.jpeg",
    ];

    return Container(
        width: MediaQuery.of(context).size.width,
        height: GetPlatform.isDesktop
            ? 500
            : MediaQuery.of(context).size.width * 0.45,
        padding:
        const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: 0.9,
                  autoPlayInterval: Duration(seconds: 7),
                  onPageChanged: (index, reason) {
                    // bannerController.setCurrentIndex(index, true);
                  },
                ),
                itemCount: bannerList.length,
                itemBuilder: (context, index, _) {
                  return InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          Dimensions.RADIUS_SMALL),
                      child: CustomImage(
                        // image: 'https://picsum.photos/seed/picsum/200/300',
                        image: bannerList[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
