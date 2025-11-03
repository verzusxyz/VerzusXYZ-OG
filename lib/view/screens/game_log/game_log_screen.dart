import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/game_log/game_log_controller.dart';
import 'package:verzusxyz/data/repo/gamelog/gamelog_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/animated_widget/expanded_widget.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:verzusxyz/view/screens/game_log/widgets/log_details_bottom_sheet.dart';
import 'package:get/get.dart';

class GameLogScreen extends StatefulWidget {
  const GameLogScreen({Key? key}) : super(key: key);

  @override
  State<GameLogScreen> createState() => _GameLogScreenState();
}

class _GameLogScreenState extends State<GameLogScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(GameLogRepo(apiClient: Get.find()));
    final controller = Get.put(GameLogController(gameLogRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gameLogData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const CustomAppBar(
          title: MyStrings.gameLogs,
          bgColor: MyColor.searchFieldColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Dimensions.space12,
            horizontal: Dimensions.space10,
          ),
          child: GetBuilder<GameLogController>(
            builder: (controller) {
              if (controller.isLoading) {
                return const Center(
                  child: CustomLoader(loaderColor: MyColor.colorWhite),
                );
              } else {
                return controller.gameLogList.isEmpty
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [NoDataTile(title: MyStrings.noGameLogFound)],
                      )
                    : ListView.builder(
                        itemCount: controller.gameLogList.length,
                        itemBuilder: (context, index) {
                          var gameLog = controller.gameLogList[index];
                          return InkWell(
                            highlightColor: MyColor.transparentColor,
                            splashColor: MyColor.transparentColor,
                            onTap: () {
                              GameLogBottomSheet.gameLogBottomSheet(
                                context,
                                index,
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.all(Dimensions.space5),
                              padding: const EdgeInsets.all(Dimensions.space10),
                              decoration: BoxDecoration(
                                color: MyColor.searchFieldColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            gameLog.game?.name ?? "",
                                            style: regularDefault.copyWith(
                                              color: MyColor.colorWhite,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            controller.currencySym +
                                                Converter.formatNumber(
                                                  gameLog.invest ?? "",
                                                ),
                                            style: regularDefault.copyWith(
                                              color: MyColor.colorWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.all(
                                          Dimensions.space2,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: gameLog.winStatus == "1"
                                                ? MyColor.greenP
                                                : MyColor.redColor,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Text(
                                          gameLog.winStatus == "1"
                                              ? MyStrings.win.tr
                                              : MyStrings.lost.tr,
                                          style: regularSmall.copyWith(
                                            color: gameLog.winStatus == "1"
                                                ? MyColor.greenP
                                                : MyColor.redColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (controller.expandedIndex == index)
                                    ExpandedSection(
                                      expand: true,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: Dimensions.space10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                MyStrings.invest.tr,
                                                style: regularDefault.copyWith(
                                                  color: MyColor.colorWhite,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                controller.currencySym +
                                                    Converter.formatNumber(
                                                      gameLog.invest ?? "",
                                                    ),
                                                style: regularDefault.copyWith(
                                                  color: MyColor.colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: Dimensions.space5,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    MyStrings.result.tr,
                                                    style: regularDefault
                                                        .copyWith(
                                                          color: MyColor
                                                              .colorWhite,
                                                        ),
                                                  ),
                                                  Container(
                                                    height: Dimensions.space1,
                                                    width: Dimensions.space55,
                                                    color: MyColor
                                                        .activeIndicatorColor,
                                                  ),
                                                  Text(
                                                    gameLog.result
                                                            ?.replaceAll(
                                                              "[",
                                                              "",
                                                            )
                                                            .replaceAll("]", "")
                                                            .replaceAll('"', "")
                                                            .tr ??
                                                        "",
                                                    style: regularDefault
                                                        .copyWith(
                                                          color: MyColor
                                                              .textColor2,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              gameLog.userSelect != "null"
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                          MyStrings
                                                              .youSelect
                                                              .tr,
                                                          style: regularDefault
                                                              .copyWith(
                                                                color: MyColor
                                                                    .colorWhite,
                                                              ),
                                                        ),
                                                        Container(
                                                          height:
                                                              Dimensions.space1,
                                                          width: 90,
                                                          color: MyColor
                                                              .activeIndicatorColor,
                                                        ),
                                                        Text(
                                                          gameLog.userSelect
                                                                  ?.replaceAll(
                                                                    "[",
                                                                    "",
                                                                  )
                                                                  .replaceAll(
                                                                    "]",
                                                                    "",
                                                                  )
                                                                  .replaceAll(
                                                                    '"',
                                                                    "",
                                                                  )
                                                                  .tr ??
                                                              "",
                                                          style: regularDefault
                                                              .copyWith(
                                                                color: MyColor
                                                                    .textColor2,
                                                              ),
                                                        ),
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  const SizedBox(height: Dimensions.space5),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              }
            },
          ),
        ),
      ),
    );
  }
}
