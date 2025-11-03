import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/controller/all-games_nav_screen/all_games_controller.dart';
import 'package:verzusxyz/view/components/image/custom_network_image.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:get/get.dart';

class AllGamesFeaturedGamesSection extends StatefulWidget {
  const AllGamesFeaturedGamesSection({super.key});

  @override
  State<AllGamesFeaturedGamesSection> createState() =>
      _AllGamesFeaturedGamesSectionState();
}

class _AllGamesFeaturedGamesSectionState
    extends State<AllGamesFeaturedGamesSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllGamesNavScreenController>(
      builder: (controller) => OrientationBuilder(
        builder: (context, orientation) {
          final mediaQuery = MediaQuery.of(context);
          final bool isPortrait =
              mediaQuery.orientation == Orientation.portrait;
          if (controller.featuredGamesList.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    MyStrings.featuredGames.tr.toUpperCase(),
                    style: regularLarge.copyWith(color: MyColor.colorWhite),
                  ),
                ),
                const NoDataTile(title: MyStrings.noFeaturedGamesToShow),
              ],
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.space8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  MyStrings.featuredGames.tr.toUpperCase(),
                  style: regularLarge.copyWith(color: MyColor.colorWhite),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    aspectRatio: 29 / 9,
                    onPageChanged: (index, reason) {
                      controller.changeCurrentSliderIndex(index);
                    },
                  ),
                  items: controller.featuredGamesList.map((game) {
                    return GestureDetector(
                      onTap: () {
                        if (game.alias == "head_tail") {
                          Get.toNamed(RouteHelper.headAndTailScreen);
                        }
                        if (game.alias == "rock_paper_scissors") {
                          Get.toNamed(RouteHelper.rockPaperScissorsScreen);
                        }
                        if (game.alias == "roulette") {
                          Get.toNamed(RouteHelper.rouletteScreen);
                        }
                        if (game.alias == "number_guess") {
                          Get.toNamed(RouteHelper.guessTheNumberScreen);
                        }
                        if (game.alias == "dice_rolling") {
                          Get.toNamed(RouteHelper.diceRollingScreen);
                        }
                        if (game.alias == "spin_wheel") {
                          Get.toNamed(RouteHelper.spinWheelScreen);
                        }
                        if (game.alias == "card_finding") {
                          Get.toNamed(RouteHelper.cardFindingScreen);
                        }
                        if (game.alias == "number_slot") {
                          Get.toNamed(RouteHelper.numberSlotScreen);
                        }
                        if (game.alias == "number_pool") {
                          Get.toNamed(RouteHelper.poolNumberScreen);
                        }
                        if (game.alias == "casino_dice") {
                          Get.toNamed(RouteHelper.playCasinoDiceScreen);
                        }
                        if (game.alias == "keno") {
                          Get.toNamed(RouteHelper.kenoScreen);
                        }
                        if (game.alias == "blackjack") {
                          Get.toNamed(RouteHelper.blackJackScreen);
                        }
                        if (game.alias == "poker") {
                          Get.toNamed(RouteHelper.pokerScreen);
                        }
                        if (game.alias == "mines") {
                          Get.toNamed(RouteHelper.minesScreen);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(Dimensions.space8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: MyColor.navBarActiveButtonColor,
                            width: .4,
                          ),
                          borderRadius: BorderRadius.circular(
                            Dimensions.space10,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              UrlContainer.dashboardImage +
                                  game.image.toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.space10,
                                      ),
                                      child: Image.asset(
                                        MyImages.blurImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.space10,
                                      ),
                                      child: Image.asset(
                                        MyImages.blurImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          height: isPortrait ? null : 280,
                                          margin: const EdgeInsets.all(
                                            Dimensions.space10,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.space4,
                                            ),
                                            child: CustomNetworkImage(
                                              key: ValueKey(
                                                game.image.toString(),
                                              ),
                                              imageUrl:
                                                  UrlContainer.dashboardImage +
                                                  game.image.toString(),
                                              width: 200,
                                              height: 200,
                                              loaderColor:
                                                  MyColor.activeIndicatorColor,
                                              placeholder: Image.asset(
                                                MyImages.placeHolderImage,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width /
                                                  2.3,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: Dimensions.space4,
                                                ),
                                                Text(
                                                  game.name?.tr.toUpperCase() ??
                                                      "",
                                                  style: semiBoldMediumLarge
                                                      .copyWith(
                                                        color:
                                                            MyColor.colorWhite,
                                                      ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: Dimensions.space4,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (game.alias ==
                                                        "head_tail") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .headAndTailScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "rock_paper_scissors") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .rockPaperScissorsScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "roulette") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .rouletteScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "number_guess") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .guessTheNumberScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "dice_rolling") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .diceRollingScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "spin_wheel") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .spinWheelScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "card_finding") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .cardFindingScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "number_slot") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .numberSlotScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "number_pool") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .poolNumberScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "casino_dice") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .playCasinoDiceScreen,
                                                      );
                                                    }
                                                    if (game.alias == "keno") {
                                                      Get.toNamed(
                                                        RouteHelper.kenoScreen,
                                                      );
                                                    }
                                                    if (game.alias ==
                                                        "blackjack") {
                                                      Get.toNamed(
                                                        RouteHelper
                                                            .blackJackScreen,
                                                      );
                                                    }
                                                    if (game.alias == "poker") {
                                                      Get.toNamed(
                                                        RouteHelper.pokerScreen,
                                                      );
                                                    }
                                                    if (game.alias == "mines") {
                                                      Get.toNamed(
                                                        RouteHelper.minesScreen,
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical:
                                                              Dimensions.space6,
                                                          horizontal: Dimensions
                                                              .space17,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: MyColor
                                                          .navBarActiveButtonColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            Dimensions.space4,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      MyStrings.playNow.tr,
                                                      style: semiBoldDefault
                                                          .copyWith(
                                                            fontFamily: 'Inter',
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                    );
                  }).toList(),
                ),
                const SizedBox(height: Dimensions.space10),
                Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.featuredGamesList.length,
                        (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space5,
                            ),
                            height: Dimensions.space3,
                            width: Dimensions.space35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.space15,
                              ),
                              color: controller.currentIndex == index
                                  ? MyColor.activeIndicatorColor
                                  : MyColor.inActiveIndicatorColor.withOpacity(
                                      .3,
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
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
