import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_audio.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:get/get.dart';

class LoseDialog extends StatefulWidget {
  final bool isShowResult;
  final String result;
  final String adminSelectedNumber;
  final bool iskenoResult;
  const LoseDialog({
    super.key,
    this.isShowResult = false,
    this.result = "",
    this.iskenoResult = false,
    this.adminSelectedNumber = '',
  });

  @override
  State<LoseDialog> createState() => _LoseDialogState();
}

class _LoseDialogState extends State<LoseDialog> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _controller.forward();
    super.initState();
    AudioPlayer().play(AssetSource(MyAudio.looserAudio));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: MyColor.redP,

                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [MyColor.colorBgCard, MyColor.colorBgCard],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(MyImages.loose),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const Divider(thickness: 0.3),
                  widget.isShowResult
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${MyStrings.theResultIs} ${widget.result}',
                            style: semiBoldLarge.copyWith(
                              color: MyColor.colorWhite,
                              fontFamily: "Inter",
                            ),
                          ),
                        )
                      : const SizedBox(),
                  widget.iskenoResult
                      ? Text(
                          '${MyStrings.total} ${widget.adminSelectedNumber} ${MyStrings.numberMatched}',
                          style: semiBoldLarge.copyWith(
                            color: MyColor.colorWhite,
                            fontFamily: "Inter",
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
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
            ),
          ],
        ),
      ],
    );
  }
}
