import 'package:flutter/material.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/home/home_controller.dart';
import 'package:verzusxyz/view/components/circle_image_button.dart';
import 'package:get/get.dart';

class TopSection extends StatefulWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColor.secondaryPrimaryColor,
              border: Border.all(color: MyColor.navBarActiveButtonColor),
              borderRadius: BorderRadius.circular(Dimensions.space50),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(Dimensions.space5),
                  padding: const EdgeInsets.all(Dimensions.space2),
                  decoration: const BoxDecoration(
                    color: MyColor.navBarActiveButtonColor,
                    shape: BoxShape.circle,
                  ),
                  child: CircleImageWidget(
                    height: Dimensions.space25,
                    width: Dimensions.space25,
                    isProfile: true,
                    isAsset: false,
                    imagePath: MyImages.profile,
                    press: () {
                      Get.toNamed(RouteHelper.profileScreen);
                    },
                  ),
                ),
                const SizedBox(width: Dimensions.space10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Text(
                    controller.firstName,
                    style: regularExtraLarge.copyWith(
                      color: MyColor.colorWhite,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: Dimensions.space15),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(RouteHelper.gameLog);
            },
            child: Image.asset(MyImages.notification, width: 40),
          ),
        ],
      ),
    );
  }
}
