import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/account/profile_controller.dart';
import 'package:verzusxyz/data/repo/account/profile_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';
import 'package:verzusxyz/view/screens/edit_profile/widget/edit_profile_form.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(ProfileRepo(apiClient: Get.find()));
    final controller = Get.put(ProfileController(profileRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProfileInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => SafeArea(
        child: Scaffold(
          backgroundColor: MyColor.bottomColor,
          appBar: CustomAppBar(
            isShowBackBtn: true,
            bgColor: MyColor.bottomColor,
            title: MyStrings.editProfile.tr,
          ),
          body: controller.isLoading
              ? const CustomLoader(loaderColor: MyColor.colorWhite)
              : Stack(
                  children: [
                    Positioned(
                      top: -10,
                      child: Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        color: MyColor.bottomColor,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          left: Dimensions.space15,
                          right: Dimensions.space15,
                          top: Dimensions.space20,
                          bottom: Dimensions.space20,
                        ),
                        child: Column(children: [EditProfileForm()]),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
