import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/date_converter.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/game_log/game_log_controller.dart';
import 'package:verzusxyz/view/components/bottom-sheet/custom_bottom_sheet_plus.dart';
import 'package:verzusxyz/view/components/column_widget/bottom_sheet_column.dart';
import 'package:verzusxyz/view/components/custom_container/bottom_sheet_container.dart';
import 'package:verzusxyz/view/components/row_widget/bottom_sheet_top_row.dart';
import 'package:get/get.dart';

class GameLogBottomSheet {
  static void gameLogBottomSheet(BuildContext context, int index) {
    CustomBottomSheetPlus(
      bgColor: MyColor.searchFieldColor,
      child: GetBuilder<GameLogController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetTopRow(header: MyStrings.gameLogInfo),
            BottomSheetContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BottomSheetColumn(
                          header: MyStrings.gameName.tr,
                          body:
                              controller.gameLogList[index].game?.name?.tr ??
                              '',
                        ),
                      ),
                      Expanded(
                        child: BottomSheetColumn(
                          alignmentEnd: true,
                          header: MyStrings.winningAmount,
                          body:
                              '${controller.currencySym}${Converter.formatNumber(controller.gameLogList[index].winAmo ?? '')}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimensions.space20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BottomSheetColumn(
                          header: MyStrings.totalInvest,
                          body:
                              '${controller.currencySym}${Converter.formatNumber(controller.gameLogList[index].invest ?? '0')}',
                        ),
                      ),
                      Expanded(
                        child: BottomSheetColumn(
                          alignmentEnd: true,
                          header: MyStrings.date,
                          body: DateConverter.convertIsoToString(
                            controller.gameLogList[index].updatedAt ?? '0',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).show(context);
  }
}
