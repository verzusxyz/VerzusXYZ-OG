import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/view/components/text-form-field/custom_text_field.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/deposit/add_new_deposit_controller.dart';
import '../../../../data/model/deposit/deposit_method_response_model.dart';
import '../../../../data/repo/deposit/deposit_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app-bar/custom_appbar.dart';
import '../../../components/buttons/rounded_button.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/text-form-field/custom_drop_down_text_field.dart';
import 'info_widget.dart';

class NewDepositScreen extends StatefulWidget {
  const NewDepositScreen({Key? key}) : super(key: key);

  @override
  State<NewDepositScreen> createState() => _NewDepositScreenState();
}

class _NewDepositScreenState extends State<NewDepositScreen> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(DepositRepo(apiClient: Get.find()));
    final controller = Get.put(
      AddNewDepositController(depositRepo: Get.find()),
    );

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getDepositMethod();
    });
  }

  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewDepositController>(
      builder: (controller) => Container(
        decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
        child: Scaffold(
          backgroundColor: MyColor.transparentColor,

          appBar: const CustomAppBar(
            title: MyStrings.deposit,
            bgColor: MyColor.searchFieldColor,
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  padding: Dimensions.screenPaddingHV,
                  child: Container(
                    padding: const EdgeInsets.all(Dimensions.space20),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: MyColor.bottomColor,
                      borderRadius: BorderRadius.circular(
                        Dimensions.defaultRadius,
                      ),
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropDownTextField(
                            fillColor: MyColor.searchFieldColor,
                            radius: 10,
                            dropDownColor: MyColor.bottomColor,
                            labelText: MyStrings.paymentMethod.tr,
                            selectedValue: controller.paymentMethod,
                            onChanged: (newValue) {
                              controller.setPaymentMethod(newValue);
                            },
                            items: controller.methodList.map((Methods bank) {
                              return DropdownMenuItem<Methods>(
                                value: bank,
                                child: Text(
                                  (bank.name ?? '').tr,
                                  style: regularDefault.copyWith(
                                    color: MyColor.textColor2,
                                    fontFamily: "Inter",
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: Dimensions.space15),

                          CustomTextField(
                            onChanged: (value) {
                              if (value.toString().isEmpty) {
                                controller.changeInfoWidgetValue(0);
                              } else {
                                double amount =
                                    double.tryParse(value.toString()) ?? 0;
                                controller.changeInfoWidgetValue(amount);
                              }
                              return;
                            },
                            controller: controller.amountController,
                            fillColor: MyColor.searchFieldColor,
                            labelTextColor: MyColor.labelTextsColor,
                            needOutlineBorder: true,
                            animatedLabel: false,
                            textInputType: TextInputType.number,
                            currrency: controller.currency,
                            hintText: MyStrings.enterAmount.tr,
                            labelText: MyStrings.amount.tr,
                            borderRadious: 10,
                            isIcon: true,
                          ),

                          controller.paymentMethod?.name != MyStrings.selectOne
                              ? const InfoWidget()
                              : const SizedBox(),
                          const SizedBox(height: 35),
                          controller.submitLoading
                              ? const RoundedLoadingBtn(
                                  color: MyColor.primaryButtonColor,
                                )
                              : RoundedButton(
                                  hasCornerRadious: true,
                                  isColorChange: true,
                                  textColor: MyColor.colorBlack,
                                  verticalPadding: Dimensions.space15,
                                  cornerRadius: Dimensions.space8,
                                  color: MyColor.primaryButtonColor,
                                  text: MyStrings.submit,
                                  press: () {
                                    controller.submitDeposit();
                                  },
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
