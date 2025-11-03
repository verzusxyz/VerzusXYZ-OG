import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/date_converter.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/transaction/transactions_controller.dart';
import 'package:verzusxyz/data/controller/wallet/wallet_screen_controller.dart';
import 'package:verzusxyz/data/repo/transaction/transaction_repo.dart';
import 'package:verzusxyz/data/repo/wallet/wallet_screen_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/image/custom_svg_picture.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/wallet/widgets/search_trx.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/wallet/widgets/trx_details_bottom_sheet.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/wallet/widgets/wallet_balance_section.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
    Get.put(WalletScreenRepo(apiClient: Get.find()));
    Get.put(TransactionRepo(apiClient: Get.find()));
    final controller = Get.put(
      WalletScreencontroller(walletScreenRepo: Get.find()),
    );
    final trxController = Get.put(
      TransactionsController(transactionRepo: Get.find()),
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getWalletScreenData();
      trxController.initialSelectedValue();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WalletScreencontroller>(
        builder: (controller) => Container(
          height: double.infinity,
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: controller.isLoading
              ? const CustomLoader(loaderColor: MyColor.primaryColor)
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.space10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.space25),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: Dimensions.space40,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                MyImages.walletPng,
                                height: Dimensions.space25,
                              ),
                              const SizedBox(width: Dimensions.space3),
                              Text(
                                MyStrings.wallet.tr.toUpperCase(),
                                style: semiBoldExtraLarge.copyWith(
                                  color: MyColor.colorWhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space25),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: Dimensions.space100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(MyImages.walletBalancesBg),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(
                                Dimensions.space8,
                              ),
                              border: Border.all(
                                color: MyColor.navBarActiveButtonColor,
                              ),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.space8,
                                    ),
                                    child: Image.asset(
                                      MyImages.blurImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        MyStrings.walletBalances.tr,
                                        style: regularDefault.copyWith(
                                          color: MyColor.colorWhite,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      Text(
                                        "${controller.defaultCurrency}${Converter.formatNumber(controller.walletBalance, precision: 2)}",
                                        style: semiBoldOverLarge.copyWith(
                                          color:
                                              MyColor.navBarActiveButtonColor,
                                          fontSize: Dimensions.space40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space20),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.depositsScreen);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.space10,
                                    vertical: Dimensions.space15,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.space8,
                                    ),
                                    color: MyColor.greenP,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CustomSvgPicture(
                                        image: MyImages.depositSvg,
                                        height: 20,
                                        width: 20,
                                        color: MyColor.colorWhite,
                                      ),
                                      Text(
                                        MyStrings.deposit.tr,
                                        style: semiBoldLarge.copyWith(
                                          color: MyColor.colorWhite,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: Dimensions.space15),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(RouteHelper.withdrawScreen);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.space10,
                                    vertical: Dimensions.space15,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.space8,
                                    ),
                                    color: MyColor.redP,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const CustomSvgPicture(
                                        image: MyImages.withdraw,
                                        height: 20,
                                        width: 20,
                                        color: MyColor.colorWhite,
                                      ),
                                      Text(
                                        MyStrings.withdraws.tr,
                                        style: semiBoldLarge.copyWith(
                                          color: MyColor.colorWhite,
                                          fontFamily: "Inter",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: Dimensions.space20),
                            WalletBalance(),
                            SizedBox(height: Dimensions.space20),
                            SearchTrx(),
                            SizedBox(height: Dimensions.space20),
                          ],
                        ),
                        GetBuilder<TransactionsController>(
                          builder: (trxController) => Column(
                            children: [
                              trxController.filterLoading
                                  ? const CustomLoader(
                                      loaderColor: MyColor.primaryColor,
                                    )
                                  : trxController.transactionList.isEmpty
                                  ? NoDataTile(title: MyStrings.notrxToShow.tr)
                                  : ListView.separated(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          trxController.transactionList.length +
                                          1,
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                            height: Dimensions.space10,
                                          ),
                                      itemBuilder: (context, index) {
                                        if (trxController
                                                .transactionList
                                                .length ==
                                            index) {
                                          return trxController.hasNext()
                                              ? Container(
                                                  height: 40,
                                                  width: MediaQuery.of(
                                                    context,
                                                  ).size.width,
                                                  margin: const EdgeInsets.all(
                                                    5,
                                                  ),
                                                  child: const CustomLoader(),
                                                )
                                              : const SizedBox();
                                        }

                                        return ListTile(
                                          onTap: () {
                                            TrxDetailsBottomSheet.trxDetailsBottomSheet(
                                              context,
                                              index,
                                            );
                                          },
                                          leading: Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  trxController
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
                                                trxController
                                                            .transactionList[index]
                                                            .trxType
                                                            .toString() ==
                                                        "+"
                                                    ? MyImages.withdraw
                                                    : MyImages.depositSvg,
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
                                                trxController
                                                    .transactionList[index]
                                                    .trx
                                                    .toString()
                                                    .tr,
                                                style: regularMediumLarge
                                                    .copyWith(
                                                      color: MyColor.colorWhite,
                                                      fontFamily: 'Inter',
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                  trxController
                                                      .transactionList[index]
                                                      .updatedAt
                                                      .toString(),
                                                ),
                                                style: regularDefault.copyWith(
                                                  color:
                                                      MyColor.subTitleTextColor,
                                                  fontFamily: 'Inter',
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Visibility(
                                                visible:
                                                    index ==
                                                        trxController
                                                            .selectedItemIndex &&
                                                    trxController.showDetails,
                                                child: Text(
                                                  trxController
                                                      .transactionList[index]
                                                      .details
                                                      .toString()
                                                      .tr,
                                                  style: regularDefault
                                                      .copyWith(
                                                        color: MyColor
                                                            .subTitleTextColor,
                                                        fontFamily: 'Inter',
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                trxController.curSymbol +
                                                    Converter.formatNumber(
                                                      trxController
                                                          .transactionList[index]
                                                          .amount
                                                          .toString(),
                                                    ),
                                                style: regularMediumLarge
                                                    .copyWith(
                                                      color: MyColor.colorWhite,
                                                      fontFamily: 'Inter',
                                                    ),
                                              ),
                                              Text(
                                                trxController
                                                        .transactionList[index]
                                                        .remark
                                                        .toString()
                                                        .replaceAll("_", " ")
                                                        .tr
                                                        .capitalizeFirst ??
                                                    "",
                                                style: regularDefault.copyWith(
                                                  color:
                                                      MyColor.subTitleTextColor,
                                                  fontFamily: 'Inter',
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                              const SizedBox(height: Dimensions.space20),
                            ],
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
