import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/roulette/roulette_controller_.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSpinWheel extends StatefulWidget {
  const CustomSpinWheel({super.key});
  @override
  State<CustomSpinWheel> createState() => _CustomSpinWheelState();
}

class _CustomSpinWheelState extends State<CustomSpinWheel>
    with TickerProviderStateMixin {
  late final AnimationController _defaultLottieController;
  late final AnimationController _coinsLottieController;
  late final AnimationController _goldenConfettiLottieController;
  @override
  void initState() {
    final controller = Get.find<RouletteControllers>();
    _defaultLottieController = AnimationController(vsync: this)
      ..duration = Duration(seconds: controller.roatationDuration);
    _coinsLottieController = AnimationController(vsync: this)
      ..duration = Duration(seconds: controller.roatationDuration);
    _goldenConfettiLottieController = AnimationController(vsync: this)
      ..duration = Duration(seconds: controller.roatationDuration);

    super.initState();
  }

  @override
  void dispose() {
    _coinsLottieController.dispose();
    _goldenConfettiLottieController.dispose();
    _defaultLottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var wheelSize = size.width / 3;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        //NEW CODE
        GetBuilder<RouletteControllers>(
          builder: (controller) {
            if (controller.limitOver) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                controller.fortuneWheelNotifier.close();
              });
            }
            return AbsorbPointer(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    MyImages.wheelBorder,
                    height: wheelSize,
                    width: wheelSize,
                    fit: BoxFit.cover,
                  ),
                  controller.name.isEmpty
                      ? const SizedBox()
                      : Stack(
                          children: [
                            SizedBox(
                              height: wheelSize / 1.156,
                              width: wheelSize / 1.156,
                              child: FortuneWheel(
                                animateFirst: false,
                                duration: Duration(
                                  seconds: controller.roatationDuration,
                                ),
                                selected:
                                    controller.fortuneWheelNotifier.stream,
                                rotationCount: controller.rotationCount,
                                indicators: const [],
                                items: List.generate(
                                  controller.name.length,
                                  (index) => FortuneItem(
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsetsDirectional.all(
                                        Dimensions.space5,
                                      ),
                                      child: Text(
                                        "${Converter.formatNumber(controller.name[index])} "
                                            .replaceAll(".00", "")
                                            .tr,
                                        textAlign: TextAlign.end,
                                        style: GoogleFonts.crimsonText(
                                          color: index.isEven
                                              ? const Color(0xffFDEF9A)
                                              : const Color(0xff690101),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ), //attention: use custom item
                                    style: FortuneItemStyle(
                                      color:
                                          Converter.formatNumber(
                                                controller.name[index],
                                              ).replaceAll(".00", "") ==
                                              "0"
                                          ? MyColor.greenP
                                          : index.isEven
                                          ? const Color(
                                              0xffCE0005,
                                            ).withOpacity(0.8)
                                          : MyColor.colorWhite,
                                      borderColor: MyColor.transparentColor,
                                      textStyle: regularSmall,
                                    ),
                                  ),
                                ),
                                onAnimationEnd: () {
                                  // MyUtils.closeSound();

                                  controller.setIsSpinning(false);
                                  //  _spinListener(context, controller.isWinner);
                                },
                                onAnimationStart: () {},
                              ),
                            ),
                          ],
                        ),
                  Positioned.fill(
                    top: Dimensions.space5,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        MyImages.spinningPointer,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
