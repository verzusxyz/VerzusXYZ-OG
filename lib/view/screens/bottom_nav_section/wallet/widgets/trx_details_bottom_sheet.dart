import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/transaction/transactions_controller.dart';
import 'package:verzusxyz/view/components/bottom-sheet/custom_bottom_sheet_plus.dart';
import 'package:verzusxyz/view/components/column_widget/bottom_sheet_column.dart';
import 'package:verzusxyz/view/components/row_widget/bottom_sheet_top_row.dart';
import 'package:get/get.dart';

import '../../../../components/custom_container/bottom_sheet_container.dart';

class TrxDetailsBottomSheet {
  static void trxDetailsBottomSheet(BuildContext context, int index) {
    CustomBottomSheetPlus(
      bgColor: MyColor.searchFieldColor,
      child: GetBuilder<TransactionsController>(
        builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BottomSheetTopRow(header: MyStrings.transectionInfo),
            BottomSheetContainer(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: BottomSheetColumn(
                          header: MyStrings.remark,
                          body:
                              controller.transactionList[index].remark
                                  ?.replaceAll("_", " ")
                                  .capitalizeFirst ??
                              "",
                        ),
                      ),
                      Expanded(
                        child: BottomSheetColumn(
                          alignmentEnd: true,
                          header: MyStrings.amount,
                          body:
                              '${Converter.formatNumber(controller.transactionList[index].amount ?? '')}${controller.currency}',
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
                          header: MyStrings.transactionId,
                          body:
                              '${Converter.formatNumber(controller.transactionList[index].trx ?? '0')}${controller.currency}',
                        ),
                      ),
                      Expanded(
                        child: BottomSheetColumn(
                          alignmentEnd: true,
                          header: MyStrings.postBalance,
                          body:
                              '${Converter.formatNumber(controller.transactionList[index].postBalance ?? '0')}${controller.currency}',
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
                          header: MyStrings.details,
                          body: '${controller.transactionList[index].details}',
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
