import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/view/components/image/image_fall_back.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/data/controller/home/home_controller.dart';

class SliderBanner extends StatelessWidget {
  const SliderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) {
                  controller.changeCurrentSliderIndex(index);
                },
              ),
              items: controller.sliderBannerList.map((slider) {
                return ImageWidgetWithFallback(
                  imageUrl: UrlContainer.sliderImage + slider.image.toString(),
                );
              }).toList(),
            ),
            const SizedBox(height: Dimensions.space10),
            Center(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Row(
                  children: List.generate(controller.sliderBannerList.length, (
                    index,
                  ) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.space5,
                      ),
                      height: Dimensions.space3,
                      width: Dimensions.space35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.space15),
                        color: controller.currentIndex == index
                            ? MyColor.activeIndicatorColor
                            : MyColor.inActiveIndicatorColor.withOpacity(.3),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
