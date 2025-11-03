import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all_games/spin_wheel/spin_wheel_controller.dart';
import 'package:get/get.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});
  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> with TickerProviderStateMixin {
  late final AnimationController _defaultLottieController;
  late final AnimationController _coinsLottieController;
  late final AnimationController _goldenConfettiLottieController;
  @override
  void initState() {
    final controller = Get.find<SpinWheelControllers>();
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
    var wheelSize = size.width / 2;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        GetBuilder<SpinWheelControllers>(
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
                                    ),
                                    style: FortuneItemStyle(
                                      color: index.isEven
                                          ? MyColor.redColor
                                          : MyColor.blueColor,
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
