import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/account/profile_controller.dart';
import 'package:verzusxyz/data/repo/account/profile_repo.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/screens/Profile/widget/profile_top_section.dart';
import 'package:verzusxyz/view/components/buttons/gradient_rounded_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(ProfileRepo());
    final controller = Get.put(ProfileController(profileRepo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.bottomColor,
          appBar: CustomAppBar(
            title: MyStrings.profile.tr,
            bgColor: MyColor.bottomColor,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : Stack(
                  children: [
                    Positioned(
                      top: -10,
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        color: MyColor.bottomColor,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(Dimensions.space15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ProfileTopSection(),
                            const SizedBox(height: Dimensions.space20),
                            GradientRoundedButton(
                              text: 'Reset Demo Balance',
                              press: () async {
                                final repo = Get.find<ProfileRepo>();
                                await repo.resetDemoBalance();
                                // You can show a snackbar or some feedback to the user
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
