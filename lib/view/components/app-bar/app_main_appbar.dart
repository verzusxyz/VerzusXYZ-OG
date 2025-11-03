import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/dialog/exit_dialog.dart';
import 'package:get/get.dart';

class AppMainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? appBarSize;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? titleWidget;

  final bool isShowBackBtn;
  final bool showCrossIconInBackBtn;

  final Color bgColor;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;
  final List<Widget>? actions;

  final Widget? leadingWidget;
  final VoidCallback? leadingWidgetOnTap;

  const AppMainAppBar({
    super.key,
    this.fromAuth = false,
    this.isTitleCenter = true,
    this.bgColor = MyColor.primaryColorDark,
    this.isShowBackBtn = true,
    this.title,
    required this.isProfileCompleted,
    this.actions,
    this.titleStyle,
    this.titleWidget,
    this.appBarSize,
    this.leadingWidget,
    this.leadingWidgetOnTap,
    this.showCrossIconInBackBtn = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(appBarSize ?? 60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: MyColor.textColor2,
        systemNavigationBarColor: MyColor.textColor2,
      ),
      surfaceTintColor: Colors.transparent,
      backgroundColor: bgColor,
      leading: (isShowBackBtn)
          ? Padding(
              padding: const EdgeInsetsDirectional.only(
                start: Dimensions.space15,
              ),
              child: Ink(
                decoration: const ShapeDecoration(
                  color: MyColor.bottomColor,
                  shape: CircleBorder(),
                ),
                child: FittedBox(
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      if (leadingWidgetOnTap != null) {
                        leadingWidgetOnTap!();
                      } else {
                        if (fromAuth) {
                          Get.offAllNamed(RouteHelper.registrationScreen);
                        } else if (isProfileCompleted == false) {
                          showExitDialog(Get.context!);
                        } else {
                          String previousRoute = Get.previousRoute;
                          if (previousRoute == '/splash-screen') {
                            Get.offAndToNamed(RouteHelper.homeScreen);
                          } else {
                            Get.back();
                          }
                        }
                      }
                    },
                    icon:
                        leadingWidget ??
                        Icon(
                          showCrossIconInBackBtn
                              ? Icons.close
                              : Icons.arrow_back,
                          color: MyColor.getAppBarContentColor(),
                          size: 25,
                        ),
                  ),
                ),
              ),
            )
          : const SizedBox(),
      centerTitle: isTitleCenter,
      title:
          titleWidget ??
          Text(
            (title ?? '').tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                titleStyle ??
                boldMediumLarge.copyWith(color: MyColor.textColor2),
          ),
      actions: actions,
    );
  }
}
