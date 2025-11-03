import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color? textColor;
  final Color? color;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;

  const RoundedLoadingBtn({
    Key? key,
    this.width = 1,
    this.cornerRadius = 6,
    this.horizontalPadding = 35,
    this.verticalPadding = 15,
    this.textColor = MyColor.colorWhite,
    this.color = MyColor.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      splashColor: MyColor.getScreenBgColor(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        width: size.width * width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadius),
          color: color,
        ),
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: MyColor.colorBlack,
              strokeWidth: 2,
            ),
          ),
        ),
      ),
    );
  }
}
