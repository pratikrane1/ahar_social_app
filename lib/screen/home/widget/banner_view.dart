import 'package:aharconnect/controller/home_controller.dart';
import 'package:aharconnect/data/model/banner_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/widget/custom_image.dart';
import 'package:shimmer/shimmer.dart';

class BannerView extends StatelessWidget {
  BannerView();

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    List<BannerModel>? bannerList;

    return GetBuilder<HomeController>(builder: (homeController) {
      bannerList = homeController.bannerList;
      _isLoading = homeController.isBannerLoading;
      return _isLoading
          ? bannerList!.length != 0
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: GetPlatform.isDesktop
                      ? 500
                      : MediaQuery.of(context).size.width * 0.45,
                  padding: const EdgeInsets.only(
                      top: Dimensions.PADDING_SIZE_DEFAULT),
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
                          itemCount: bannerList!.length,
                          itemBuilder: (context, index, _) {
                            return InkWell(
                              onTap: () {},
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL),
                                child: CustomImage(
                                  image: bannerList![index].url ?? "",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ))
              : Container()
          : Shimmer.fromColors(
              baseColor: Colors.grey.withOpacity(0.3),
              highlightColor: Colors.white,
              enabled: bannerList!.isEmpty,
              child: Container(
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    color: Colors.grey[300],
                  )),
            );
    });
  }
}
