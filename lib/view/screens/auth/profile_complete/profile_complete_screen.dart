import 'package:flutter/material.dart';
import 'package:verzusxyz/view/screens/auth/profile_complete/widget/profile_complete_body_section/profile_complete_body_section.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/account/profile_complete_controller.dart';
import 'package:verzusxyz/data/repo/account/profile_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/will_pop_widget.dart';

import '../../../../core/utils/my_images.dart';
import '../../../../data/services/push_notification_service.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    Get.put(ProfileCompleteController(profileRepo: Get.find()));
    Get.put(PushNotificationService(apiClient: Get.find()));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: GetBuilder<ProfileCompleteController>(
        builder: (controller) => Container(
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: Scaffold(
            backgroundColor: MyColor.transparentColor,
            appBar: CustomAppBar(
              title: MyStrings.profileComplete.tr,
              bgColor: MyColor.searchFieldColor,
              isProfileCompleted: true,
            ),
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(MyImages.loginBg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: MyColor.secondaryColor950.withOpacity(0.8),
                ),
                const ProfileCompleteBodySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
