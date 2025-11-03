import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:get/get.dart';

class WinnerDialog extends StatefulWidget {
  final String result;
  final String adminSelectedNumber;
  final bool isShowResult;
  final bool iskenoResult;
  const WinnerDialog({
    super.key,
    required this.result,
    this.isShowResult = true,
    this.iskenoResult = false,
    this.adminSelectedNumber = '',
  });

  @override
  State<WinnerDialog> createState() => _WinnerDialogState();
}

class _WinnerDialogState extends State<WinnerDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 650),
    );

    _controller.forward();
    super.initState();
    AudioPlayer().play(AssetSource(MyAudio.winnerAudio));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [MyColor.colorBgCard, MyColor.colorBgCard],
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(MyImages.win),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              widget.isShowResult || widget.iskenoResult
                  ? const Divider(thickness: 0.3)
                  : const SizedBox.shrink(),
              widget.isShowResult
                  ? Text(
                      widget.result != ""
                          ? '${MyStrings.theResultIs.tr} ${widget.result}'
                          : "",
                      style: semiBoldLarge.copyWith(
                        color: MyColor.colorWhite,
                        fontFamily: "Inter",
                      ),
                    )
                  : const SizedBox(),
              widget.iskenoResult
                  ? Text(
                      '${MyStrings.total.tr} ${widget.adminSelectedNumber}${MyStrings.numberMatched.tr}',
                      style: semiBoldLarge.copyWith(
                        color: MyColor.colorWhite,
                        fontFamily: "Inter",
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 10),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Material(
              color: MyColor.appBgColor,
              child: InkWell(
                highlightColor: MyColor.transparentColor,
                splashColor: MyColor.transparentColor,
                onTap: () {
                  Get.back();
                },
                child: Image.asset(
                  MyImages.cancel,
                  height: 20,
                  color: MyColor.colorWhite,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
