import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:verzusxyz/core/utils/my_images.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/core/utils/url_container.dart';
import 'package:verzusxyz/data/controller/refferal/refferal_screen_controller.dart';
import 'package:verzusxyz/data/repo/refferal/refferal_screen_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/dimensions.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:verzusxyz/data/services/api_service.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';
import 'package:verzusxyz/view/components/custom_loader/custom_loader.dart';

class RefferalScreen extends StatefulWidget {
  const RefferalScreen({Key? key}) : super(key: key);

  @override
  State<RefferalScreen> createState() => _RefferalScreenState();
}

class _RefferalScreenState extends State<RefferalScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(RefferalScreenRepo(apiClient: Get.find()));
    final controller = Get.put(
      RefferalScreenController(refferalScreenRepo: Get.find()),
    );
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.allGamesInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RefferalScreenController>(
      builder: (controller) => Container(
        decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: CustomAppBar(
            title: MyStrings.refferal.tr,
            bgColor: MyColor.bottomColor,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: Dimensions.space15,
                      right: Dimensions.space15,
                      top: Dimensions.space20,
                      bottom: Dimensions.space20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: MyColor.searchFieldColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                MyStrings.yourReferralLink.tr,
                                style: regularDefault.copyWith(
                                  color: MyColor.colorWhite,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: MyColor.bottomColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          "${UrlContainer.domainUrl}?reference=${controller.username != "" ? controller.username : controller.savedUsername}",
                                          style: regularSmall.copyWith(
                                            color: MyColor.colorWhite,
                                            fontFamily: "Inter",
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text:
                                                "${UrlContainer.domainUrl}?reference=${controller.username}",
                                          ),
                                        );
                                        CustomSnackBar.success(
                                          successList: [
                                            MyStrings.referralLinkCopied,
                                          ],
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions.space7,
                                          vertical: Dimensions.space7,
                                        ),
                                        decoration: BoxDecoration(
                                          color: MyColor.searchFieldColor,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: SvgPicture.asset(
                                          MyImages.copyImage,
                                          height: Dimensions.space15,
                                          colorFilter: const ColorFilter.mode(
                                            MyColor.activeIndicatorColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: Dimensions.space20),
                        Text(
                          MyStrings.refference,
                          style: regularDefault.copyWith(
                            color: MyColor.colorWhite,
                          ),
                        ),
                        const SizedBox(height: Dimensions.space5),
                        controller.refferalData.isEmpty
                            ? const NoDataTile(
                                title: MyStrings.noRefferanceFound,
                              )
                            : ListView.builder(
                                itemCount: controller.refferalData.length,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: MyColor.searchFieldColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.04),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "${index + 1}".padLeft(
                                                    2,
                                                    "0",
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                    color: MyColor.textColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        left: 10,
                                                      ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "${controller.refferalData[index].firstname} ${controller.refferalData[index].lastname}",
                                                        maxLines: 2,
                                                        style: regularDefault
                                                            .copyWith(
                                                              color: MyColor
                                                                  .colorWhite,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        "${controller.refferalData[index].email}",
                                                        maxLines: 2,
                                                        style: regularDefault
                                                            .copyWith(
                                                              fontFamily:
                                                                  "Inter",
                                                              color: MyColor
                                                                  .colorWhite,
                                                            ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
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
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
