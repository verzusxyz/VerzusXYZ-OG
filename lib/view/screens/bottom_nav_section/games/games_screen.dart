import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/all-games_nav_screen/all_games_controller.dart';
import 'package:verzusxyz/data/repo/all-games/all_games_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:verzusxyz/view/components/will_pop_widget.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/games/widgets/all_games_section.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/games/widgets/featured_games.dart';
import 'package:get/get.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(AllGanmesRepo(apiClient: Get.find()));
    final controller = Get.put(
      AllGamesNavScreenController(allGanmesRepo: Get.find()),
    );
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.allGamesInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllGamesNavScreenController>(
      builder: (controller) => WillPopWidget(
        nextRoute: "",
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.allGamesInfo();
            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: MyColor.gradientBackground,
              ),
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: controller.isLoading
                    ? const CustomLoader(loaderColor: MyColor.primaryColor)
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.space30),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.space15,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(MyImages.diceImage, height: 25),
                                  const SizedBox(width: Dimensions.space5),
                                  Text(
                                    MyStrings.games.tr,
                                    style: semiBoldExtraLarge.copyWith(
                                      color: MyColor.colorWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.space10,
                              ),
                              child: CustomTextField(
                                onChanged: (value) {
                                  controller.filterGames(value.toString());
                                },
                                fillColor: MyColor.bottomColor,
                                labelTextColor: MyColor.labelTextsColor,
                                needOutlineBorder: true,
                                animatedLabel: false,
                                isSearch: true,
                                hintText: MyStrings.searchForAGame,
                                borderColor: MyColor.topColor,
                                disableBorderColor: MyColor.topColor,
                                labelText: "",
                                borderRadious: 80,
                                isIcon: true,
                              ),
                            ),
                            const SizedBox(height: Dimensions.space20),
                            const AllGamesFeaturedGamesSection(),
                            const SizedBox(height: Dimensions.space20),
                            const AllGamesSection(),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
