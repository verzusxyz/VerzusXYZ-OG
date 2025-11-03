import 'package:flutter/material.dart';
import 'package:verzusxyz/view/components/divider/custom_divider.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/transaction/transactions_controller.dart';
import '../../../components/animated_widget/expanded_widget.dart';
import '../../../components/column_widget/card_column.dart';

class CustomTransactionCard extends StatelessWidget {
  final String trxData;
  final String dateData;
  final String amountData;
  final String detailsText;
  final String postBalanceData;
  final int index;
  final int expandIndex;
  final String trxType;

  const CustomTransactionCard({
    Key? key,
    required this.index,
    required this.trxData,
    required this.dateData,
    required this.amountData,
    required this.postBalanceData,
    required this.expandIndex,
    required this.detailsText,
    required this.trxType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: Dimensions.space5),
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.space15,
          horizontal: Dimensions.space14,
        ),
        decoration: BoxDecoration(
          color: MyColor.bottomColor,
          borderRadius: BorderRadius.circular(Dimensions.space10),
          border: Border.all(color: MyColor.activeIndicatorColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CardColumn(header: MyStrings.trxId, body: trxData),
                ),
                Expanded(
                  child: CardColumn(
                    alignmentEnd: true,
                    header: MyStrings.date,
                    body: dateData,
                    isDate: true,
                  ),
                ),
              ],
            ),
            const CustomDivider(space: Dimensions.space15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CardColumn(
                    header: MyStrings.amount,
                    body: '$amountData ${controller.currency}',
                    textColor: controller.changeTextColor(trxType),
                  ),
                ),
                Expanded(
                  child: CardColumn(
                    alignmentEnd: true,
                    header: MyStrings.postBalance,
                    body: '$postBalanceData ${controller.currency}',
                  ),
                ),
              ],
            ),
            ExpandedSection(
              expand: expandIndex == index,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomDivider(space: Dimensions.space15),
                  CardColumn(header: MyStrings.details, body: detailsText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
