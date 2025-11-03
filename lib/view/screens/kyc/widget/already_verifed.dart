import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_icons.dart';
import 'package:verzusxyz/view/components/image/custom_svg_picture.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';

class AlreadyVerifiedWidget extends StatefulWidget {
  final bool isPending;

  const AlreadyVerifiedWidget({super.key, this.isPending = false});

  @override
  State<AlreadyVerifiedWidget> createState() => _AlreadyVerifiedWidgetState();
}

class _AlreadyVerifiedWidgetState extends State<AlreadyVerifiedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: MyColor.gradientBackground,
      ),
      padding: const EdgeInsets.all(Dimensions.space20),
      margin: const EdgeInsets.all(5),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvgPicture(
            image: widget.isPending
                ? MyIcons.pendingIcon
                : MyIcons.verifiedIcon,
            height: 100,
            width: 100,
            color: MyColor.getPrimaryColor(),
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 25),
          Text(
            widget.isPending
                ? MyStrings.kycUnderReviewMsg.tr
                : MyStrings.kycAlreadyVerifiedMsg.tr,
            style: regularDefault.copyWith(
              color: MyColor.colorWhite,
              fontSize: Dimensions.fontExtraLarge,
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
