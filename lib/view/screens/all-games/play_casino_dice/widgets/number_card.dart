import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:get/get.dart';

class NumberCard extends StatelessWidget {
  final int number;
  final bool isShuffling;

  NumberCard({required this.number, required this.isShuffling});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: Dimensions.space120,
        child: Card(
          color: MyColor.casinoDiceCardColor.withOpacity(.06),
          child: Center(
            child: Text(
              number.toString().tr,
              style: semiBoldOverLarge.copyWith(
                color: MyColor.navBarActiveButtonColor,
                fontSize: Dimensions.space40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
