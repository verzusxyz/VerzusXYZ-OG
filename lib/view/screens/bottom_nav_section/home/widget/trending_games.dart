import 'package:flutter/material.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/controller/home/home_controller.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/widget/trending_games_cards.dart';
import 'package:get/get.dart';

class TrendingGames extends StatefulWidget {
  const TrendingGames({super.key});

  @override
  State<TrendingGames> createState() => _TrendingGamesState();
}

class _TrendingGamesState extends State<TrendingGames> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => OrientationBuilder(
        builder: (context, orientation) {
          final mediaQuery = MediaQuery.of(context);
          final bool isPortrait =
              mediaQuery.orientation == Orientation.portrait;

          if (controller.trendingGamesList.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    MyStrings.trendingGames.tr.toUpperCase(),
                    style: regularLarge.copyWith(color: MyColor.colorWhite),
                  ),
                ),
                const NoDataTile(
                  title: MyStrings.noFeaturedGamesToShow,
                  height: 150,
                ),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyStrings.trendingGames.tr.toUpperCase(),
                  style: regularLarge.copyWith(color: MyColor.colorWhite),
                ),

                const SizedBox(height: Dimensions.space5),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.space7,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,

                          itemCount: controller.trendingGamesList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    controller.trendingGamesList.length <= 2
                                    ? 2
                                    : 4,
                                crossAxisSpacing: 10,
                                childAspectRatio: isPortrait
                                    ? (controller.trendingGamesList.length <= 2
                                          ? 1.4
                                          : 1)
                                    : 1.6,
                              ),
                          itemBuilder: (BuildContext context, int index) {
                            var alias =
                                controller.trendingGamesList[index].alias;
                            controller.trendingGamesLength =
                                controller.trendingGamesList.length;
                            return GestureDetector(
                              onTap: () {
                                if (alias == "head_tail") {
                                  Get.toNamed(RouteHelper.headAndTailScreen);
                                }
                                if (alias == "rock_paper_scissors") {
                                  Get.toNamed(
                                    RouteHelper.rockPaperScissorsScreen,
                                  );
                                }
                                if (alias == "roulette") {
                                  Get.toNamed(RouteHelper.rouletteScreen);
                                }
                                if (alias == "number_guess") {
                                  Get.toNamed(RouteHelper.guessTheNumberScreen);
                                }
                                if (alias == "dice_rolling") {
                                  Get.toNamed(RouteHelper.diceRollingScreen);
                                }
                                if (alias == "spin_wheel") {
                                  Get.toNamed(RouteHelper.spinWheelScreen);
                                }
                                if (alias == "card_finding") {
                                  Get.toNamed(RouteHelper.cardFindingScreen);
                                }
                                if (alias == "number_slot") {
                                  Get.toNamed(RouteHelper.numberSlotScreen);
                                }
                                if (alias == "number_pool") {
                                  Get.toNamed(RouteHelper.poolNumberScreen);
                                }
                                if (alias == "casino_dice") {
                                  Get.toNamed(RouteHelper.playCasinoDiceScreen);
                                }
                                if (alias == "keno") {
                                  Get.toNamed(RouteHelper.kenoScreen);
                                }
                                if (alias == "blackjack") {
                                  Get.toNamed(RouteHelper.blackJackScreen);
                                }
                                if (alias == "poker") {
                                  Get.toNamed(RouteHelper.pokerScreen);
                                }
                                if (alias == "mines") {
                                  Get.toNamed(RouteHelper.minesScreen);
                                }
                              },
                              child: TrendingGamesCard(
                                myImage:
                                    UrlContainer.dashboardImage +
                                    controller.trendingGamesList[index].image
                                        .toString(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
