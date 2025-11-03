import 'package:flutter/material.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/model/game_screen/game_screen_model.dart'
    as prefix;
import 'package:verzusxyz/data/controller/all-games_nav_screen/all_games_controller.dart';
import 'package:verzusxyz/view/components/image/custom_network_image.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:get/get.dart';

class AllGamesSection extends StatefulWidget {
  const AllGamesSection({super.key});

  @override
  State<AllGamesSection> createState() => _AllGamesSectionState();
}

class _AllGamesSectionState extends State<AllGamesSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllGamesNavScreenController>(
      builder: (controller) => OrientationBuilder(
        builder: (context, orientation) {
          final mediaQuery = MediaQuery.of(context);
          final bool isPortrait =
              mediaQuery.orientation == Orientation.portrait;
          final List<prefix.Game> filteredGames =
              controller.filteredGames.isNotEmpty
              ? controller.filteredGames
              : controller.gamesList;
          if (filteredGames.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    MyStrings.allGames.tr.toUpperCase(),
                    style: regularLarge.copyWith(color: MyColor.colorWhite),
                  ),
                ),
                const NoDataTile(title: MyStrings.noGamestoShow),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Text(
                  MyStrings.allGames.tr.toUpperCase(),
                  style: regularLarge.copyWith(color: MyColor.colorWhite),
                ),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isPortrait ? 2 : 4,
                  childAspectRatio: isPortrait ? 1.4 : 1,
                ),
                itemCount: filteredGames.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var alias = filteredGames[index].alias;
                  return InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      if (alias == "head_tail") {
                        Get.toNamed(RouteHelper.headAndTailScreen);
                      }
                      if (alias == "rock_paper_scissors") {
                        Get.toNamed(RouteHelper.rockPaperScissorsScreen);
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
                    child: Container(
                      margin: const EdgeInsets.all(Dimensions.space10),
                      height: Dimensions.space10,
                      width: Dimensions.space10,
                      child: Stack(
                        children: [
                          Container(
                            width: Dimensions.space190,
                            height: Dimensions.space160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.space10,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  MyColor.transparentColor,
                                  MyColor.colorBlack.withOpacity(0.5),
                                ],
                                stops: const [0.0, 0.8],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Dimensions.space10,
                              ),

                              child: CustomNetworkImage(
                                key: ValueKey(filteredGames[index].image),
                                imageUrl:
                                    UrlContainer.dashboardImage +
                                    filteredGames[index].image.toString(),
                                width: Dimensions.space200,
                                height: Dimensions.space200,
                                loaderColor: MyColor.activeIndicatorColor,
                                placeholder: Image.asset(
                                  MyImages.placeHolderImage,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: Dimensions.space190,
                            height: Dimensions.space160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.space10,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  MyColor.transparentColor,
                                  MyColor.colorBlack.withOpacity(0.5),
                                ],
                                stops: const [0.0, 0.8],
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                MyImages.blurImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredGames[index].name.toString().tr,
                                    style: semiBoldLarge.copyWith(
                                      color: MyColor.colorWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
