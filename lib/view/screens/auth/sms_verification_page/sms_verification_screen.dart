import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/route/route.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/auth/auth/sms_verification_controler.dart';
import 'package:verzusxyz/data/repo/auth/sms_email_verification_repo.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/will_pop_widget.dart';

import '../../../components/buttons/gradient_rounded_button.dart';
import '../../../components/otp_field_widget/otp_field_widget.dart';
import '../../../components/text/default_text.dart';

class SmsVerificationScreen extends StatefulWidget {
  const SmsVerificationScreen({Key? key}) : super(key: key);

  @override
  State<SmsVerificationScreen> createState() => _SmsVerificationScreenState();
}

class _SmsVerificationScreenState extends State<SmsVerificationScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(SmsEmailVerificationRepo(apiClient: Get.find()));
    final controller = Get.put(SmsVerificationController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadBefore();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Container(
        decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
        child: Scaffold(
          backgroundColor: MyColor.transparentColor,
          appBar: CustomAppBar(
            fromAuth: true,
            isShowBackBtn: true,
            bgColor: MyColor.transparentColor,
            title: MyStrings.smsVerification.tr,
          ),
          body: GetBuilder<SmsVerificationController>(
            builder: (controller) => controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyColor.getPrimaryColor(),
                    ),
                  )
                : SingleChildScrollView(
                    padding: Dimensions.screenPaddingHV,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: Dimensions.space20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: DefaultText(
                              text: MyStrings.smsVerificationMsg.tr,
                              textAlign: TextAlign.center,
                              textStyle: regularLargeInter.copyWith(
                                color: MyColor.getSecondaryTextColor(),
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimensions.space25),
                          OTPFieldWidget(
                            onChanged: (value) {
                              setState(() {
                                controller.currentText = value;
                              });
                            },
                          ),
                          const SizedBox(height: Dimensions.space30),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.space14,
                            ),
                            child: GradientRoundedButton(
                              showLoadingIcon: controller.submitLoading,
                              verticalPadding: 15,
                              text: MyStrings.verify.tr,
                              press: () {
                                controller.verifyYourSms(
                                  controller.currentText,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: Dimensions.space30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                MyStrings.didNotReceiveCode.tr,
                                style: regularDefaultInter.copyWith(
                                  color: MyColor.getLabelTextColor(),
                                ),
                              ),
                              const SizedBox(width: Dimensions.space10),
                              controller.resendLoading
                                  ? Container(
                                      margin: const EdgeInsets.all(5),
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: MyColor.getPrimaryColor(),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        controller.sendCodeAgain();
                                      },
                                      child: Text(
                                        MyStrings.resendCode.tr,
                                        style: regularDefaultInter.copyWith(
                                          decoration: TextDecoration.underline,
                                          decorationColor:
                                              MyColor.getPrimaryColor(),
                                          color: MyColor.getPrimaryColor(),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
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
