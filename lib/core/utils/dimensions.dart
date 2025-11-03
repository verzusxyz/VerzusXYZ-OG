import 'package:flutter/cupertino.dart';

/// A utility class that holds all the dimensions used in the application.
class Dimensions {
  /// Font size: 7.00
  static const double fontOverSmall = 7.00;

  /// Font size: 9.00
  static const double fontExtraSmall = 9.00;

  /// Font size: 11.00
  static const double fontSmall = 11.00;

  /// Font size: 13.00 (default)
  static const double fontDefault = 13.00;

  /// Font size: 14.00
  static const double fontLarge = 14.00;

  /// Font size: 17.00
  static const double fontMediumLarge = 17.00;

  /// Font size: 19.00
  static const double fontExtraLarge = 19.00;

  /// Font size: 21.00
  static const double fontOverLarge = 21.00;

  /// Default button height: 45
  static const double defaultButtonH = 45;

  /// Default radius: 8
  static const double defaultRadius = 8;

  /// Card margin: 12
  static const double cardMargin = 12;

  /// Button radius: 4
  static const double buttonRadius = 4;

  /// Alternative button radius: 8
  static const double buttonRadius2 = 8;

  /// Card radius: 8
  static const double cardRadius = 8;

  /// Bottom sheet radius: 15
  static const double bottomSheetRadius = 15;

  /// Space between text elements: 8
  static const double textToTextSpace = 8;

  /// Space value: 1
  static const double space1 = 1;

  /// Space value: 5
  static const double space5 = 5;

  /// Space value: 6
  static const double space6 = 6;

  /// Space value: 4
  static const double space4 = 4;

  /// Space value: 7
  static const double space7 = 7;

  /// Space value: 8
  static const double space8 = 8;

  /// Space value: 3
  static const double space3 = 3;

  /// Space value: 2
  static const double space2 = 2;

  /// Space value: 10
  static const double space10 = 10;

  /// Space value: 14
  static const double space14 = 14;

  /// Space value: 15
  static const double space15 = 15;

  /// Space value: 55
  static const double space55 = 55;

  /// Space value: 17
  static const double space17 = 17;

  /// Space value: 18
  static const double space18 = 18;

  /// Space value: 12
  static const double space12 = 12;

  /// Space value: 20
  static const double space20 = 20;

  /// Space value: 25
  static const double space25 = 25;

  /// Space value: 24
  static const double space24 = 24;

  /// Space value: 30
  static const double space30 = 30;

  /// Space value: 35
  static const double space35 = 35;

  /// Space value: 40
  static const double space40 = 40;

  /// Space value: 45
  static const double space45 = 45;

  /// Space value: 50
  static const double space50 = 50;

  /// Space value: 28
  static const double space28 = 28;

  /// Space value: 80
  static const double space80 = 80;

  /// Space value: 60
  static const double space60 = 60;

  /// Space value: 70
  static const double space70 = 70;

  /// Space value: 75
  static const double space75 = 75;

  /// Space value: 185
  static const double space185 = 185;

  /// Space value: 190
  static const double space190 = 190;

  /// Space value: 200
  static const double space200 = 200;

  /// Space value: 100
  static const double space100 = 100;

  /// Space value: 160
  static const double space160 = 160;

  /// Space value: 120
  static const double space120 = 120;

  /// Horizontal screen padding: 15
  static const double screenPaddingH = 15;

  /// Vertical screen padding: 15
  static const double screenPaddingV = 15;

  /// Horizontal screen padding: 15
  static const double horizontalScreenPadding = 15;

  /// Vertical screen padding: 15
  static const double verticalScreenPadding = 15;

  /// EdgeInsets for horizontal and vertical screen padding.
  static const EdgeInsets screenPaddingHV =
      EdgeInsets.symmetric(horizontal: space15, vertical: space20);

  /// Default EdgeInsets for horizontal and vertical padding.
  static const EdgeInsets defaultPaddingHV =
      EdgeInsets.symmetric(vertical: space20, horizontal: space15);

  /// EdgeInsets for padding insets.
  static const EdgeInsets paddingInset = EdgeInsets.symmetric(
      vertical: Dimensions.screenPaddingV * 4,
      horizontal: Dimensions.screenPaddingH);

  /// Alternative EdgeInsets for horizontal and vertical screen padding.
  static const EdgeInsets screenPaddingHV1 =
      EdgeInsets.symmetric(vertical: 20, horizontal: 17);

  /// EdgeInsets for preview padding.
  static const EdgeInsets previewPaddingHV =
      EdgeInsets.symmetric(vertical: 17, horizontal: Dimensions.space15);

  /// EdgeInsets for screen padding.
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
      horizontal: horizontalScreenPadding, vertical: verticalScreenPadding);
}
