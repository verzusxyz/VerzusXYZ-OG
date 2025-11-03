import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/action_button_icon_widget.dart';
import 'package:verzusxyz/view/components/dialog/exit_dialog.dart';

/// A custom app bar widget.
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  /// The title of the app bar.
  final String title;

  /// Whether to show the back button.
  final bool isShowBackBtn;

  /// The background color of the app bar.
  final Color bgColor;

  /// Whether to show the action button.
  final bool isShowActionBtn;

  /// Whether to center the title.
  final bool isTitleCenter;

  /// Whether the app bar is used in an authentication screen.
  final bool fromAuth;

  /// Whether the user's profile is completed.
  final bool isProfileCompleted;

  /// The icon for the action button.
  final dynamic actionIcon;

  /// The callback function for the action button.
  final VoidCallback? actionPress;

  /// Whether to align the action icon to the end.
  final bool isActionIconAlignEnd;

  /// The text for the action button.
  final String actionText;

  /// Whether the action button is an image.
  final bool isActionImage;

  /// Creates a new [CustomAppBar] instance.
  const CustomAppBar({
    Key? key,
    this.isProfileCompleted = false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.bgColor = MyColor.appBarColor,
    this.isShowBackBtn = true,
    required this.title,
    this.isShowActionBtn = false,
    this.actionText = '',
    this.actionIcon,
    this.actionPress,
    this.isActionIconAlignEnd = false,
    this.isActionImage = true,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification = false;
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isShowBackBtn
        ? AppBar(
            elevation: 0,
            titleSpacing: 0,
            leading: widget.isShowBackBtn
                ? IconButton(
                    onPressed: () {
                      if (widget.fromAuth) {
                        Get.offAllNamed(RouteHelper.loginScreen);
                      } else if (widget.isProfileCompleted) {
                        showExitDialog(Get.context!);
                      } else {
                        String previousRoute = Get.previousRoute;
                        if (previousRoute == '/splash-screen') {
                          Get.offAndToNamed(RouteHelper.bottomNavBar);
                        } else {
                          Get.back();
                        }
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: MyColor.getAppBarContentColor(),
                      size: 20,
                    ),
                  )
                : const SizedBox.shrink(),
            backgroundColor: widget.bgColor,
            title: Text(
              widget.title.tr,
              style: regularDefault.copyWith(
                color: MyColor.getAppBarContentColor(),
              ),
            ),
            centerTitle: widget.isTitleCenter,
            actions: [
              widget.isShowActionBtn
                  ? ActionButtonIconWidget(
                      pressed: widget.actionPress!,
                      isImage: widget.isActionImage,
                      icon: widget.isActionImage
                          ? Icons.add
                          : widget.actionIcon,
                      imageSrc: widget.isActionImage ? widget.actionIcon : '',
                    )
                  : const SizedBox.shrink(),
              const SizedBox(width: 5),
            ],
          )
        : AppBar(
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: widget.bgColor,
            title: Text(
              widget.title.tr,
              style: regularLarge.copyWith(color: MyColor.getTextColor()),
            ),
            actions: [
              widget.isShowActionBtn
                  ? InkWell(
                      onTap: () {
                        Get.toNamed(RouteHelper.headAndTailScreen)?.then((
                          value,
                        ) {
                          setState(() {
                            hasNotification = false;
                          });
                        });
                      },
                      child: const SizedBox.shrink(),
                    )
                  : const SizedBox(),
            ],
            automaticallyImplyLeading: false,
          );
  }
}
