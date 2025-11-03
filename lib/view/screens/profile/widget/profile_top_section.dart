import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/account/profile_controller.dart';
import 'package:verzusxyz/view/components/circle_button_with_icon.dart';
import 'package:verzusxyz/view/components/column_widget/card_column.dart';
import 'package:verzusxyz/view/components/divider/custom_divider.dart';
import 'package:verzusxyz/view/components/image/circle_shape_image.dart';

class ProfileTopSection extends StatefulWidget {
  const ProfileTopSection({Key? key}) : super(key: key);

  @override
  State<ProfileTopSection> createState() => _ProfileTopSectionState();
}

class _ProfileTopSectionState extends State<ProfileTopSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space15,
          horizontal: Dimensions.space15,
        ),
        decoration: BoxDecoration(
          color: MyColor.colorBgCard,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonWithIcon(
                  circleSize: 50,
                  imageSize: 40,
                  padding: 0,
                  borderColor: MyColor.bottomColor,
                  isIcon: false,
                  isAsset: false,
                  imagePath: controller.imageUrl,
                  isProfile: true,
                  press: () {},
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.editProfileScreen),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.space5,
                      horizontal: Dimensions.space15,
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColor.navBarActiveButtonColor,
                      borderRadius: BorderRadius.circular(
                        Dimensions.defaultRadius,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: MyColor.colorBlack,
                          size: 20,
                        ),
                        const SizedBox(width: Dimensions.space10),
                        Text(
                          MyStrings.editProfile.tr,
                          style: regularSmall.copyWith(
                            color: MyColor.colorBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.space25),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.user2,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.username.tr,
                  body: controller.model.data?.user?.username ?? "",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.user2,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.name.tr,
                  body:
                      "${controller.model.data?.user?.firstname ?? ""} ${controller.model.data?.user?.lastname ?? ""}",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.email,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.email.tr,
                  body: controller.model.data?.user?.email ?? "",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.phone,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.phone.tr,
                  body: controller.model.data?.user?.mobile ?? "",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.address,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.address.tr,
                  body: controller.model.data?.user?.address ?? "",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.state,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.state.tr,
                  body: controller.model.data?.user?.state ?? "",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.zipCode,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.zipCode.tr,
                  body: controller.model.data?.user?.zip ?? "",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.city,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.city.tr,
                  body: controller.model.data?.user?.city ?? "",
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              children: [
                const CircleShapeImage(
                  imageColor: MyColor.colorBlack,
                  image: MyImages.country,
                  backgroundColor: MyColor.navBarActiveButtonColor,
                ),
                const SizedBox(width: Dimensions.space15),
                CardColumn(
                  header: MyStrings.country.tr,
                  body: controller.model.data?.user?.countryName ?? "",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
