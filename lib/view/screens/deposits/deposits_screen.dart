import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/deposit/deposit_history_controller.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:verzusxyz/view/screens/deposits/widget/custom_deposits_card.dart';
import 'package:verzusxyz/view/screens/deposits/widget/deposit_bottom_sheet.dart';
import 'package:verzusxyz/view/screens/deposits/widget/deposit_history_top.dart';
import 'package:get/get.dart';

import '../../../core/helper/date_converter.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/repo/deposit/deposit_repo.dart';
import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';
import '../../components/will_pop_widget.dart';

class DepositsScreen extends StatefulWidget {
  const DepositsScreen({Key? key}) : super(key: key);

  @override
  State<DepositsScreen> createState() => _DepositsScreenState();
}

class _DepositsScreenState extends State<DepositsScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      if (Get.find<DepositController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller = Get.put(DepositController(depositRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.beforeInitLoadData();
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositController>(
      builder: (controller) => WillPopWidget(
        child: Container(
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                MyStrings.deposit,
                style: regularDefault.copyWith(color: MyColor.colorWhite),
              ),
              backgroundColor: MyColor.bottomColor,
              elevation: 0,
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
              actions: [
                GestureDetector(
                  onTap: () {
                    controller.changeIsPress();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.space7),
                    decoration: const BoxDecoration(
                      color: MyColor.searchFieldColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      controller.isSearch ? Icons.clear : Icons.search,
                      color: MyColor.colorWhite,
                      size: 15,
                    ),
                  ),
                ),
                const SizedBox(width: Dimensions.space7),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.newDepositScreenScreen);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 7,
                      right: 10,
                      bottom: 7,
                      top: 7,
                    ),
                    padding: const EdgeInsets.all(Dimensions.space7),
                    decoration: const BoxDecoration(
                      color: MyColor.searchFieldColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.add,
                      color: MyColor.colorWhite,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
            body: controller.isLoading
                ? const CustomLoader()
                : Padding(
                    padding: const EdgeInsets.only(
                      top: Dimensions.space20,
                      left: Dimensions.space15,
                      right: Dimensions.space15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: controller.isSearch,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DepositHistoryTop(),
                              SizedBox(height: Dimensions.space15),
                            ],
                          ),
                        ),
                        controller.depositList.isEmpty &&
                                controller.searchLoading == false
                            ? NoDataTile(
                                title: MyStrings.noDepositFound.tr,
                                hasActionButton: true,
                                onTap: () {
                                  Get.toNamed(
                                    RouteHelper.newDepositScreenScreen,
                                  );
                                },
                                buttonText: MyStrings.makeDeposit.tr,
                              )
                            : Expanded(
                                child: controller.searchLoading
                                    ? const Center(child: CustomLoader())
                                    : SizedBox(
                                        height: MediaQuery.of(
                                          context,
                                        ).size.height,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          controller: scrollController,
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          padding: EdgeInsets.zero,
                                          itemCount:
                                              controller.depositList.length + 1,
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                height: Dimensions.space10,
                                              ),
                                          itemBuilder: (context, index) {
                                            if (controller.depositList.length ==
                                                index) {
                                              return controller.hasNext()
                                                  ? SizedBox(
                                                      height: 40,
                                                      width: MediaQuery.of(
                                                        context,
                                                      ).size.width,
                                                      child: const Center(
                                                        child: CustomLoader(),
                                                      ),
                                                    )
                                                  : const SizedBox();
                                            }
                                            return CustomDepositsCard(
                                              onPressed: () {
                                                DepositBottomSheet.depositBottomSheet(
                                                  context,
                                                  index,
                                                );
                                              },
                                              trxValue:
                                                  controller
                                                      .depositList[index]
                                                      .trx ??
                                                  "",
                                              date:
                                                  DateConverter.isoToLocalDateAndTime(
                                                    controller
                                                            .depositList[index]
                                                            .createdAt ??
                                                        "",
                                                  ),
                                              status: controller.getStatus(
                                                index,
                                              ),
                                              statusBgColor: controller
                                                  .getStatusColor(index),
                                              amount:
                                                  "${Converter.formatNumber(controller.depositList[index].amount ?? " ")} ${controller.currency}",
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
