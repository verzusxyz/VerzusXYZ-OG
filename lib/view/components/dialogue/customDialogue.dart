import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:get/get.dart';

class AppDialog {
  confirmDialog(
    BuildContext context, {
    required Function onfinish,
    required Function onwaiting,
    required String title,
    required Widget userDetails,
    required Widget cashDetails,
  }) {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
      builder: (_) {
        return Dialog(
          surfaceTintColor: MyColor.transparentColor,
          insetPadding: EdgeInsets.zero,
          backgroundColor: MyColor.transparentColor,
          insetAnimationCurve: Curves.easeIn,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsetsDirectional.only(
                      end: Dimensions.space5,
                      start: Dimensions.space5,
                      top: Dimensions.space30,
                      bottom: Dimensions.space20,
                    ),
                    margin: const EdgeInsets.all(Dimensions.space15),
                    decoration: BoxDecoration(
                      color: MyColor.colorWhite,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: MyColor.borderColor,
                        width: 0.6,
                      ),
                    ),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraint.maxHeight / 2,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const SizedBox(height: Dimensions.space20),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: Dimensions.space15,
                                  end: Dimensions.space15,
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [TextSpan(text: title.tr)],
                                    text: "${"MyStrings.confirmTo".tr} ",
                                    style: regularExtraLarge,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: Dimensions.space30),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: Dimensions.space15,
                                  end: Dimensions.space15,
                                ),
                                child: userDetails,
                              ),
                              const SizedBox(height: Dimensions.space20),
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  start: Dimensions.space20,
                                  end: Dimensions.space20,
                                ),
                                child: cashDetails,
                              ),
                              const SizedBox(height: Dimensions.space25),
                              //     Directionality(textDirection: TextDirection.ltr, child: SwipeAnimatedButton(onFinish: onfinish, onWaiting: onwaiting))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 30,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: MyColor.colorRed,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
