import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/transaction/transactions_controller.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchTrx extends StatelessWidget {
  const SearchTrx({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionsController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MyStrings.transactionHistory,
            style: regularLarge.copyWith(color: MyColor.colorWhite),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomTextField(
                  onChanged: () {},
                  controller: controller.trxController,
                  fillColor: MyColor.searchFieldColor,
                  labelTextColor: MyColor.labelTextsColor,
                  needOutlineBorder: true,
                  animatedLabel: false,
                  isSearch: false,
                  hintText: MyStrings.searchTransaction.tr,
                  labelText: "",
                  borderRadious: 80,
                  isIcon: true,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: Dimensions.space8,
                  top: 25,
                ),
                child: InkWell(
                  onTap: () {
                    controller.filterData();
                  },
                  child: CircleAvatar(
                    minRadius: 25,
                    backgroundColor: MyColor.searchFieldColor,
                    child: SvgPicture.asset(
                      MyImages.searchIconSvg,
                      colorFilter: const ColorFilter.mode(
                        MyColor.activeIndicatorColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
