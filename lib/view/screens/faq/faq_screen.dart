import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/data/controller/faq_controller/faq_controller.dart';
import 'package:verzusxyz/data/repo/faq_repo/faq_repo.dart';
import 'package:verzusxyz/view/components/app-bar/custom_appbar.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/services/api_service.dart';
import '../../components/custom_loader/custom_loader.dart';
import 'faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(FaqRepo(apiClient: Get.find()));
    final controller = Get.put(FaqController(faqRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColor.getScreenBgColor(),
        appBar: CustomAppBar(isShowBackBtn: true, title: MyStrings.faq.tr),
        body: GetBuilder<FaqController>(
          builder: (controller) => controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  padding: Dimensions.screenPadding,
                  physics: const BouncingScrollPhysics(),
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.faqList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: Dimensions.space10),
                    itemBuilder: (context, index) => FaqListItem(
                      answer:
                          (controller.faqList[index].dataValues?.answer ?? '')
                              .tr,
                      question:
                          (controller.faqList[index].dataValues?.question ?? '')
                              .tr,
                      index: index,
                      press: () {
                        controller.changeSelectedIndex(index);
                      },
                      selectedIndex: controller.selectedIndex,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
