import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialrecipe/utils/dimensions.dart';
import 'package:socialrecipe/widget/custom_image.dart';

class BannerView extends StatelessWidget {
  BannerView();

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    List? bannerList;

    return Container(
        width: MediaQuery.of(context).size.width,
        height: GetPlatform.isDesktop
            ? 500
            : MediaQuery.of(context).size.width * 0.45,
        padding:
        EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
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
                itemCount: 1,
                itemBuilder: (context, index, _) {
                  return InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          Dimensions.RADIUS_SMALL),
                      child: CustomImage(
                        image: 'https://picsum.photos/seed/picsum/200/300',
                        // image: bannerList[index].imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            ),

            // const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: bannerList.map((bnr) {
            //     int index = bannerList.indexOf(bnr);
            //     return TabPageSelectorIndicator(
            //       backgroundColor: index == bannerController.currentIndex ? Theme.of(context).primaryColor
            //           : Theme.of(context).primaryColor.withOpacity(0.5),
            //       borderColor: Theme.of(context).backgroundColor,
            //       size: index == bannerController.currentIndex ? 10 : 7,
            //     );
            //   }).toList(),
            // ),
          ],
        ));
  }
}
