import 'package:flutter/material.dart';
import 'package:verzusxyz/data/controller/common/theme_controller.dart';
import 'package:get/get.dart';

/// A utility class that holds all the colors used in the application.
class MyColor {
  /// The primary color for the application.
  static const Color primaryColor = Color(0xFF6366F1);

  /// The secondary color for the application.
  static const Color secondaryColor = Color(0xffF6F7FE);

  /// The background color for cards.
  static const Color cardBgColor = Color(0xff192D36);

  /// The main background color for the application.
  static const Color backgroundColor = Color(0xff0D222B);

  /// The background color for the app bar.
  static const Color appBarBgColor = Color(0xff192D36);

  /// The background color for screens.
  static const Color screenBgColor = Color(0xff0F0F0F);

  /// The primary text color.
  static const Color primaryTextColor = Color(0xff262626);

  /// The color for content text.
  static const Color contentTextColor = Color(0xff777777);

  /// The color for lines and dividers.
  static const Color lineColor = Color(0xffECECEC);

  /// The color for borders.
  static const Color borderColor = Color(0xffD9D9D9);

  /// The color for body text.
  static const Color bodyTextColor = Color(0xFF747475);

  /// A secondary primary color.
  static const Color secondaryPrimaryColor = Color(0xFF1E293B);

  /// The general background color for the app.
  static const Color appBgColor = Color(0xFF1E1E1E);

  /// The color for inactive navigation bar buttons.
  static const Color navBarInactiveButtonColor = colorWhite;

  /// The color for active navigation bar buttons.
  static const Color navBarActiveButtonColor = Color(0xFFF8BF27);

  /// The color for inactive indicators.
  static const Color inActiveIndicatorColor = Color(0xFFF29F11);

  /// The color for active indicators.
  static const Color activeIndicatorColor = Color(0xFF6366F1);

  /// The text color for games.
  static const Color gameTextColor = Color(0xFFE3BC3F);

  /// The color for the guess number input field.
  static const Color gusessNumberFieldColor = Color(0xFF151522);

  /// The background color for the mines game field.
  static const Color minesBackFieldColor = Color(0xFF232640);

  /// An orange accent color.
  static const orange1 = Color(0xffD69317);

  /// Another orange accent color.
  static const orange2 = Color(0xffD8AC3C);

  /// The dark primary color.
  static const Color primaryColorDark = primaryColor;

  /// A secondary primary color.
  static const Color primaryColor2 = Color(0xFFF29F11);

  /// The color for titles.
  static const Color titleColor = Color(0xff373e4a);

  /// The border color for text fields.
  static const Color textFieldBorder = Color(0xff64748B);

  /// The color for labels.
  static const Color labelTextColor = Color(0xffFFFFFF);

  /// A color for small text.
  static const Color smallTextColor1 = Color(0xff555555);

  /// The background color for text fields.
  static const Color textFieldColor = Color(0x945A5A5A);

  /// A general text color.
  static const Color textColor = Color(0xB3E2E8F0);

  /// A red accent color.
  static const Color redAccent = Color(0xB3FF6C64);

  /// A secondary text color with opacity.
  static Color textColor2 = const Color(0xffFFFFFF).withOpacity(.8);

  /// The color for dividers.
  static const Color dividerColor = Color(0xffE2E8F0);

  /// A blue accent color.
  static const Color blueColor = Color(0xff0F0FD9);

  /// The text color for delete buttons.
  static const Color delteBtnTextColor = Color(0xff6C3137);

  /// The color for delete buttons.
  static const Color delteBtnColor = Color(0xffFF0000);

  /// A sky blue accent color.
  static const Color skyBlueColor = Color(0xff1E9FF2);

  /// A light blue accent color.
  static const Color lightBlueColor = Color(0xff0E97FD);

  /// A red accent color.
  static const Color redColor = Color(0xffFF0000);

  /// The color for the app bar.
  static const Color appBarColor = secondaryColor900;

  /// The color for content within the app bar.
  static const Color appBarContentColor = colorWhite;

  /// The border color for disabled text fields.
  static const Color textFieldDisableBorderColor = Color(0xffCFCEDB);

  /// The border color for enabled text fields.
  static const Color textFieldEnableBorderColor = primaryColor;

  /// The color for hint text.
  static const Color hintTextColor = Color(0xff98a1ab);

  /// The color for primary buttons.
  static const Color primaryButtonColor = Color(0xffF29F11);

  /// The text color for primary buttons.
  static const Color primaryButtonTextColor = colorWhite;

  /// The color for secondary buttons.
  static const Color secondaryButtonColor = colorWhite;

  /// The text color for secondary buttons.
  static const Color secondaryButtonTextColor = colorBlack;

  /// A general icon color.
  static const Color iconColor = Color(0xff555555);

  /// The color for enabled filter icons.
  static const Color filterEnableIconColor = primaryColor;

  /// The color for filter icons.
  static const Color filterIconColor = iconColor;

  /// The color white.
  static const Color colorWhite = Color(0xffFFFFFF);

  /// The color black.
  static const Color colorBlack = Color(0xff262626);

  /// A darker shade of black.
  static const Color colorDarkBlack = Color(0xff00060D);

  /// A darker shade of red.
  static const Color colorDarkRed = Color(0xffFF2424);

  /// The color for borders.
  static const Color colorBorder = Color(0xff334155);

  /// The background color for cards.
  static const Color colorBgCard = Color(0xff01162F);

  /// The color green.
  static const Color colorGreen = Color(0xff28C76F);

  /// The color for selected items.
  static const Color colorSelected = Color(0xff968E59);

  /// The color red.
  static const Color colorRed = Color(0xFFD92027);

  /// The color grey.
  static const Color colorGrey = Color(0xff555555);

  /// The color for cancel actions.
  static const Color colorCancel = Color(0xff715E1F);

  /// The color for number cards.
  static const Color numberCardInt = Color(0xff13202F);

  /// The color for casino dice cards.
  static const Color casinoDiceCardColor = Color(0xffF8BF27);

  /// A transparent color.
  static const Color transparentColor = Colors.transparent;

  /// The color for success states.
  static const Color greenSuccessColor = greenP;

  /// The text color for cancel actions.
  static const Color redCancelTextColor = Color(0xFFF93E2C);

  /// A purple color for high priority items.
  static const Color highPriorityPurpleColor = Color(0xFF7367F0);

  /// The color for pending states.
  static const Color pendingColor = Colors.orange;

  /// A shade of green.
  static const Color greenP = Color(0xFF34C759);

  /// A shade of red.
  static const Color redP = Color(0xFFFF3B30);

  /// The color for green text.
  static const Color greenText = Color(0xFF34C759);

  /// The background color for containers.
  static const Color containerBgColor = Color(0xffF9F9F9);

  /// The top color for gradients.
  static const Color topColor = Color(0xff04081A);

  /// The bottom color for gradients.
  static const Color bottomColor = Color(0xFF0F172A);

  /// The color for search fields.
  static const Color searchFieldColor = Color(0xFF141f38);

  /// A general field color.
  static const Color fieldColor = Color(0xFF0F172A);

  /// The color for label text.
  static const Color labelTextsColor = Color(0xff7B8FAB);

  /// The color for subtitle text.
  static const Color subTitleTextColor = Color(0xff94A3B8);

  /// The color for list tiles.
  static const Color listTileColor = Color(0xff15151C);

  /// The top color for border gradients.
  static const Color borderTop = Color(0xFF2196F3);

  /// The bottom color for border gradients.
  static const Color borderBottom = Color(0xFF291196);

  /// A light shade of the secondary color.
  static const Color secondaryColor300 = Color(0xffCBD5E1);

  /// A medium-light shade of the secondary color.
  static const Color secondaryColor400 = Color(0xff94A3B8);

  /// A medium shade of the secondary color.
  static const Color secondaryColor500 = Color(0xff64748B);

  /// A medium-dark shade of the secondary color.
  static const Color secondaryColor600 = Color(0xff475569);

  /// A dark shade of the secondary color.
  static const Color secondaryColor700 = Color(0xff334155);

  /// A darker shade of the secondary color.
  static const Color secondaryColor800 = Color(0xff1E293B);

  /// The darkest shade of the secondary color.
  static const Color secondaryColor900 = Color(0xff0F172A);

  /// The very darkest shade of the secondary color.
  static const Color secondaryColor950 = Color(0xff020617);

  /// A linear gradient for backgrounds.
  static const LinearGradient gradientBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [topColor, bottomColor],
  );

  /// A linear gradient for borders.
  static const LinearGradient gradientBorder = LinearGradient(
    colors: [Color(0xFF2196F3), Color(0xFF291196)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  /// A list of colors for symbol plates.
  static List<Color> symbolPlate = [
    const Color(0xffDE3163),
    const Color(0xffC70039),
    const Color(0xff900C3F),
    const Color(0xff581845),
    const Color(0xffFF7F50),
    const Color(0xffFF5733),
    const Color(0xff6495ED),
    const Color(0xffCD5C5C),
    const Color(0xffF08080),
    const Color(0xffFA8072),
    const Color(0xffE9967A),
    const Color(0xff9FE2BF),
  ];

  /// Returns a secondary text color based on the current theme.
  ///
  /// - [isReverse]: Whether to reverse the color selection logic.
  static Color getSecondaryTextColor({bool isReverse = false}) {
    return Get.find<ThemeController>().darkTheme
        ? (!isReverse)
            ? secondaryColor300
            : secondaryColor600
        : (!isReverse)
            ? secondaryColor600
            : secondaryColor300;
  }

  /// Returns the primary color.
  static Color getPrimaryColor() {
    return primaryColor;
  }

  /// Returns the screen background color.
  static Color getScreenBgColor() {
    return screenBgColor;
  }

  /// Returns a grey text color.
  static Color getGreyText() {
    return MyColor.colorBlack.withOpacity(0.5);
  }

  /// Returns the app bar color.
  static Color getAppBarColor() {
    return appBarColor;
  }

  /// Returns the app bar content color.
  static Color getAppBarContentColor() {
    return appBarContentColor;
  }

  /// Returns the heading text color.
  static Color getHeadingTextColor() {
    return primaryTextColor;
  }

  /// Returns the content text color.
  static Color getContentTextColor() {
    return contentTextColor;
  }

  /// Returns the label text color.
  static Color getLabelTextColor() {
    return labelTextColor;
  }

  /// Returns the hint text color.
  static Color getHintTextColor() {
    return hintTextColor;
  }

  /// Returns the border color for disabled text fields.
  static Color getTextFieldDisableBorder() {
    return textFieldDisableBorderColor;
  }

  /// Returns the border color for enabled text fields.
  static Color getTextFieldEnableBorder() {
    return textFieldEnableBorderColor;
  }

  /// Returns the color for primary buttons.
  static Color getPrimaryButtonColor() {
    return primaryButtonColor;
  }

  /// Returns the text color for primary buttons.
  static Color getPrimaryButtonTextColor() {
    return primaryButtonTextColor;
  }

  /// Returns the color for secondary buttons.
  static Color getSecondaryButtonColor() {
    return secondaryButtonColor;
  }

  /// Returns the text color for secondary buttons.
  static Color getSecondaryButtonTextColor() {
    return secondaryButtonTextColor;
  }

  /// Returns the icon color.
  static Color getIconColor() {
    return iconColor;
  }

  /// Returns the color for disabled filter icons.
  static Color getFilterDisableIconColor() {
    return filterIconColor;
  }

  /// Returns the color for enabled search icons.
  static Color getSearchEnableIconColor() {
    return colorRed;
  }

  /// Returns a transparent color.
  static Color getTransparentColor() {
    return transparentColor;
  }

  /// Returns a white text color.
  static Color getTextColor() {
    return colorWhite;
  }

  /// Returns the background color for cards.
  static Color getCardBgColor() {
    return cardBgColor;
  }

  /// Returns a color from the symbol plate based on the given index.
  ///
  /// - [index]: The index of the color to retrieve.
  static getSymbolColor(int index) {
    int colorIndex = index > 10 ? index % 10 : index;
    return symbolPlate[colorIndex];
  }
}
