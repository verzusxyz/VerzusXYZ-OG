import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/buttons/custom_round_border_shape.dart';
import '../../core/utils/dimensions.dart';
import 'image/custom_svg_picture.dart';

class NoDataOrInternetScreen extends StatefulWidget {
  final String message;
  final double paddingTop;
  final double imageHeight;
  final bool fromReview;
  final bool hasActionButton;
  final bool isNoInternet;
  final Function? onChanged;
  final String message2;
  final String buttonText;
  final String image;
  final VoidCallback? onTap;

  const NoDataOrInternetScreen({
    Key? key,
    this.message = MyStrings.noData,
    this.paddingTop = 6,
    this.imageHeight = .5,
    this.fromReview = false,
    this.hasActionButton = false,
    this.isNoInternet = false,
    this.onChanged,
    this.buttonText = "",
    this.message2 = MyStrings.noDataToShow,
    this.image = MyImages.noDataImage,
    this.onTap,
  }) : super(key: key);

  @override
  State<NoDataOrInternetScreen> createState() => _NoDataOrInternetScreenState();
}

class _NoDataOrInternetScreenState extends State<NoDataOrInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ListView(
          physics: widget.fromReview
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).size.height * widget.imageHeight,
                  width: widget.isNoInternet
                      ? MediaQuery.of(context).size.width * .6
                      : MediaQuery.of(context).size.width * .4,
                  child: widget.isNoInternet
                      ? Lottie.asset(
                          MyImages.noInternet,
                          height:
                              MediaQuery.of(context).size.height *
                              widget.imageHeight,
                          width: MediaQuery.of(context).size.width * .6,
                        )
                      : CustomSvgPicture(
                          image: widget.image,
                          height: 100,
                          width: 100,
                          color: MyColor.colorGrey,
                        ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6, left: 30, right: 30),
                    child: Column(
                      children: [
                        Text(
                          widget.isNoInternet
                              ? MyStrings.noInternet.tr
                              : widget.message.tr,
                          textAlign: TextAlign.center,
                          style: semiBoldDefault.copyWith(
                            color: widget.isNoInternet
                                ? MyColor.colorRed
                                : MyColor.getTextColor(),
                            fontSize: Dimensions.fontExtraLarge,
                          ),
                        ),
                        const SizedBox(height: 5),
                        widget.isNoInternet
                            ? const SizedBox()
                            : Text(
                                widget.message2,
                                style: regularDefault.copyWith(
                                  fontFamily: "Inter",
                                  color: MyColor.colorWhite,
                                  fontSize: Dimensions.fontLarge,
                                ),
                                textAlign: TextAlign.center,
                              ),
                        widget.isNoInternet
                            ? const SizedBox(height: 15)
                            : const SizedBox(),
                        widget.isNoInternet
                            ? InkWell(
                                onTap: () async {
                                  if (await Connectivity()
                                          .checkConnectivity() !=
                                      ConnectivityResult.none) {
                                    widget.onChanged!(true);
                                  }
                                },
                                child: RoundedBorderContainer(
                                  text: MyStrings.retry.tr,
                                  bgColor: MyColor.colorRed,
                                  borderColor: MyColor.colorRed,
                                  textColor: MyColor.colorWhite,
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(height: 15),
                        widget.hasActionButton
                            ? RoundedButton(
                                hasCornerRadious: true,
                                isColorChange: true,
                                textColor: MyColor.colorBlack,
                                verticalPadding: Dimensions.space15,
                                cornerRadius: Dimensions.space8,
                                color: MyColor.primaryButtonColor,
                                text: widget.buttonText,
                                press: widget.onTap ?? () {},
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
