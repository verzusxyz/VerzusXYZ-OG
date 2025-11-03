import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/date_converter.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/transaction/transactions_controller.dart';
import 'package:verzusxyz/data/repo/transaction/transaction_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/action_button_icon_widget.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/wallet/widgets/trx_details_bottom_sheet.dart';
import 'package:verzusxyz/view/screens/transaction/widget/bottom_sheet.dart';
import 'package:verzusxyz/view/screens/transaction/widget/filter_row_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../components/text/label_text.dart';
import '../../components/will_pop_widget.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<TransactionsController>().loadTransaction();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<TransactionsController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller = Get.put(
      TransactionsController(transactionRepo: Get.find()),
    );

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: GetBuilder<TransactionsController>(
        builder: (controller) => Container(
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: Scaffold(
            backgroundColor: MyColor.transparentColor,
            appBar: AppBar(
              backgroundColor: MyColor.bottomColor,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: MyColor.colorWhite,
                  size: 20,
                ),
              ),
              title: Text(
                MyStrings.transaction.tr,
                style: regularLarge.copyWith(color: MyColor.colorWhite),
              ),
              actions: [
                ActionButtonIconWidget(
                  pressed: () => controller.changeSearchIcon(),
                  icon: controller.isSearch
                      ? Icons.clear
                      : Icons.filter_alt_sharp,
                ),
              ],
            ),
            body: controller.isLoading
                ? const CustomLoader(loaderColor: MyColor.colorWhite)
                : Padding(
                    padding: Dimensions.screenPaddingHV,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: controller.isSearch,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 13,
                            ),
                            margin: const EdgeInsets.only(
                              bottom: Dimensions.cardMargin,
                            ),
                            decoration: BoxDecoration(
                              color: MyColor.colorBgCard,
                              borderRadius: BorderRadius.circular(
                                Dimensions.defaultRadius,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const LabelText(text: MyStrings.type),
                                          const SizedBox(
                                            height: Dimensions.space10,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: FilterRowWidget(
                                              fromTrx: true,
                                              bgColor:
                                                  MyColor.secondaryPrimaryColor,
                                              text:
                                                  controller
                                                      .selectedTrxType
                                                      .isEmpty
                                                  ? MyStrings.trxType
                                                  : controller.selectedTrxType,
                                              press: () {
                                                showTrxBottomSheet(
                                                  controller.transactionTypeList
                                                      .map((e) => e.toString())
                                                      .toList(),
                                                  1,
                                                  MyStrings.selectTrxType,
                                                  context: context,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.space15),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const LabelText(
                                            text: MyStrings.remark,
                                          ),
                                          const SizedBox(
                                            height: Dimensions.space10,
                                          ),
                                          SizedBox(
                                            height: 40,
                                            child: FilterRowWidget(
                                              fromTrx: true,
                                              bgColor:
                                                  MyColor.secondaryPrimaryColor,
                                              text:
                                                  Converter.replaceUnderscoreWithSpace(
                                                    controller
                                                            .selectedRemark
                                                            .isEmpty
                                                        ? MyStrings.any
                                                        : controller
                                                              .selectedRemark,
                                                  ),
                                              press: () {
                                                showTrxBottomSheet(
                                                  controller.remarksList
                                                      .map(
                                                        (e) =>
                                                            e.remark.toString(),
                                                      )
                                                      .toList(),
                                                  2,
                                                  MyStrings.selectRemarks,
                                                  context: context,
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.space15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const LabelText(
                                            text: MyStrings.trxNo,
                                          ),
                                          const SizedBox(
                                            height: Dimensions.space10,
                                          ),
                                          SizedBox(
                                            height: 45,
                                            width: MediaQuery.of(
                                              context,
                                            ).size.width,
                                            child: TextFormField(
                                              cursorColor: MyColor.primaryColor,
                                              style: regularSmall.copyWith(
                                                color: MyColor.colorWhite,
                                              ),
                                              keyboardType: TextInputType.text,
                                              controller:
                                                  controller.trxController,
                                              decoration: InputDecoration(
                                                hintText: '',
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 15,
                                                    ),
                                                hintStyle: regularSmall
                                                    .copyWith(
                                                      color:
                                                          MyColor.hintTextColor,
                                                    ),
                                                filled: true,
                                                fillColor: MyColor
                                                    .secondaryPrimaryColor,
                                                border:
                                                    const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            MyColor.colorGrey,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: MyColor
                                                        .inActiveIndicatorColor
                                                        .withOpacity(.6),
                                                    width: 0.5,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: MyColor
                                                        .inActiveIndicatorColor
                                                        .withOpacity(.6),
                                                    width: 0.5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.space10),
                                    InkWell(
                                      onTap: () {
                                        controller.filterData();
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          color: MyColor.activeIndicatorColor,
                                        ),
                                        child: const Icon(
                                          Icons.search_outlined,
                                          color: MyColor.colorBlack,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        controller.transactionList.isEmpty &&
                                controller.filterLoading == false
                            ? const Center(
                                child: NoDataTile(
                                  title: MyStrings.notransectionFound,
                                ),
                              )
                            : Expanded(
                                child: controller.filterLoading
                                    ? const CustomLoader(
                                        loaderColor: MyColor.colorWhite,
                                      )
                                    : SizedBox(
                                        height: MediaQuery.of(
                                          context,
                                        ).size.height,
                                        child: ListView.separated(
                                          controller: scrollController,
                                          physics:
                                              const AlwaysScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              controller
                                                  .transactionList
                                                  .length +
                                              1,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                height: Dimensions.space10,
                                              ),
                                          itemBuilder: (context, index) {
                                            if (controller
                                                    .transactionList
                                                    .length ==
                                                index) {
                                              return controller.hasNext()
                                                  ? Container(
                                                      height: 40,
                                                      width: MediaQuery.of(
                                                        context,
                                                      ).size.width,
                                                      margin:
                                                          const EdgeInsets.all(
                                                            5,
                                                          ),
                                                      child:
                                                          const CustomLoader(),
                                                    )
                                                  : const SizedBox();
                                            }
                                            return ListTile(
                                              tileColor: MyColor.bottomColor,
                                              onTap: () {
                                                TrxDetailsBottomSheet.trxDetailsBottomSheet(
                                                  context,
                                                  index,
                                                );
                                              },
                                              leading: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      controller
                                                              .transactionList[index]
                                                              .trxType
                                                              .toString() ==
                                                          "+"
                                                      ? MyColor.greenP
                                                      : MyColor.redP,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    Dimensions.space10,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    controller
                                                                .transactionList[index]
                                                                .trxType
                                                                .toString() ==
                                                            "+"
                                                        ? MyImages.depositSvg
                                                        : MyImages.withdraw,
                                                    height: Dimensions.space20,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller
                                                        .transactionList[index]
                                                        .trx
                                                        .toString(),
                                                    style: regularMediumLarge
                                                        .copyWith(
                                                          color: MyColor
                                                              .colorWhite,
                                                          fontFamily: 'Inter',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize:
                                                              Dimensions
                                                                  .fontMediumLarge -
                                                              1,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DateConverter.convertIsoToString(
                                                      controller
                                                          .transactionList[index]
                                                          .updatedAt
                                                          .toString(),
                                                    ),
                                                    style: regularDefault
                                                        .copyWith(
                                                          color: MyColor
                                                              .subTitleTextColor,
                                                          fontFamily: 'Inter',
                                                        ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                              trailing: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    Converter.formatNumber(
                                                          controller
                                                              .transactionList[index]
                                                              .amount
                                                              .toString(),
                                                        ) +
                                                        controller.currency,
                                                    style: regularMediumLarge
                                                        .copyWith(
                                                          color: MyColor
                                                              .colorWhite,
                                                          fontFamily: 'Inter',
                                                        ),
                                                  ),
                                                  Text(
                                                    controller
                                                            .transactionList[index]
                                                            .remark
                                                            .toString()
                                                            .replaceAll(
                                                              "_",
                                                              " ",
                                                            )
                                                            .tr
                                                            .capitalizeFirst ??
                                                        "",
                                                    style: regularDefault
                                                        .copyWith(
                                                          color: MyColor
                                                              .subTitleTextColor,
                                                          fontFamily: 'Inter',
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
