import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/data/controller/all_games/slot_machine/number_slot_controller.dart';
import 'package:get/get.dart';
import 'package:roller_list/roller_list.dart';

class SlotMachinePage extends StatefulWidget {
  const SlotMachinePage({Key? key}) : super(key: key);

  @override
  _SlotMachinePageState createState() => _SlotMachinePageState();
}

class _SlotMachinePageState extends State<SlotMachinePage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlayNumberSlotController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space70),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.space2,
                ),
                decoration: const BoxDecoration(
                  gradient: MyColor.gradientBorder,
                ),
                child: Container(
                  margin: const EdgeInsets.all(Dimensions.space5),
                  decoration: const BoxDecoration(color: MyColor.colorBgCard),
                  child: RollerList(
                    height: Dimensions.space70,
                    items: controller.buildItems(),
                    enabled: false,
                    key: controller.leftRoller,
                    onSelectedIndexChanged: (value) {
                      controller.firstSlotUpdate(value);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.space2,
                ),
                decoration: const BoxDecoration(
                  gradient: MyColor.gradientBorder,
                ),
                child: Container(
                  margin: const EdgeInsets.all(Dimensions.space5),
                  decoration: const BoxDecoration(color: MyColor.colorBgCard),
                  child: RollerList(
                    height: 70,
                    dividerColor: MyColor.transparentColor,
                    items: controller.buildItems(),
                    enabled: false,
                    key: controller.centerRoller,
                    onSelectedIndexChanged: (value) {
                      controller.secondSlotUpdate(value);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.space2,
                ),
                decoration: const BoxDecoration(
                  gradient: MyColor.gradientBorder,
                ),
                child: Container(
                  margin: const EdgeInsets.all(Dimensions.space5),
                  decoration: const BoxDecoration(color: MyColor.colorBgCard),
                  child: RollerList(
                    height: 70,
                    dividerColor: Colors.transparent,
                    items: controller.buildItems(),
                    enabled: false,
                    key: controller.rightRoller,
                    onSelectedIndexChanged: (value) {
                      controller.thirdSlotUpdate(value);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
