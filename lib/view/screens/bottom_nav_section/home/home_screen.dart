import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/util.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/widget/all_games_section.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/widget/kyc_warning_section.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/widget/slider_bannner.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/widget/trending_games.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/data/controller/home/home_controller.dart';
import 'package:verzusxyz/data/repo/home/home_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/components/will_pop_widget.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/widget/top_section.dart';
import 'widget/featured_games.dart';
import 'widget/wallet_and_reward_section.dart';

/// The main screen of the application, displaying the user's dashboard.
class HomeScreen extends StatefulWidget {
  /// Creates a new [HomeScreen] instance.
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    MyUtils.allScreen();
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(HomeRepo(apiClient: Get.find()));
    final controller = Get.put(HomeController(homeRepo: Get.find()));
    controller.isLoading = true;
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialData(shouldLoad: true);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => WillPopWidget(
        nextRoute: "",
        child: RefreshIndicator(
          color: MyColor.primaryColor,
          onRefresh: () async {
            await controller.initialData();
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
                          const SizedBox(height: Dimensions.space50),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.space8,
                            ),
                            child: TopSection(),
                          ),
                          const SizedBox(height: Dimensions.space30),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.space8,
                            ),
                            child: WalletAndRewardSection(),
                          ),
                          const SizedBox(height: Dimensions.space15),
                          controller.sliderBannerList.isEmpty
                              ? const SizedBox()
                              : const SliderBanner(),
                          KYCWarningSection(controller: controller),
                          const SizedBox(height: Dimensions.space30),
                          const TrendingGames(),
                          const SizedBox(height: Dimensions.space20),
                          const FeaturedGames(),
                          const SizedBox(height: Dimensions.space20),
                          const AllGamesSection(),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
