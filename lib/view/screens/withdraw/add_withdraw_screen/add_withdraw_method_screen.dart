import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/model/withdraw/withdraw_method_response_model.dart';
import 'package:verzusxyz/view/components/buttons/rounded_button.dart';
import 'package:get/get.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/withdraw/add_new_withdraw_controller.dart';
import '../../../../data/repo/withdraw/withdraw_repo.dart';
import '../../../../data/services/api_service.dart';
import '../../../components/app-bar/custom_appbar.dart';
import '../../../components/buttons/rounded_loading_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/text-form-field/custom_amount_text_field.dart';
import '../../../components/text-form-field/custom_drop_down_button_with_text_field2.dart';
import 'info_widget.dart';

class AddWithdrawMethod extends StatefulWidget {
  const AddWithdrawMethod({Key? key}) : super(key: key);

  @override
  State<AddWithdrawMethod> createState() => _AddWithdrawMethodState();
}

class _AddWithdrawMethodState extends State<AddWithdrawMethod> {
  @override
  void initState() {
    Get.put(ApiClient(sharedPreferences: Get.find()));
    Get.put(WithdrawRepo(apiClient: Get.find()));
    final controller = Get.put(AddNewWithdrawController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadDepositMethod();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddNewWithdrawController>(
      builder: (controller) {
        return Container(
          decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
          child: Scaffold(
            backgroundColor: MyColor.transparentColor,
            appBar: CustomAppBar(
              title: MyStrings.addWithdraw.tr,
              bgColor: MyColor.bottomColor,
            ),
            body: controller.isLoading
                ? const CustomLoader()
                : SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(Dimensions.space20),
                      padding: const EdgeInsets.all(Dimensions.space12),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: MyColor.bottomColor,
                        borderRadius: BorderRadius.circular(
                          Dimensions.defaultRadius,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomDropDownTextField2(
                            radius: Dimensions.space10,
                            dropDownColor: MyColor.searchFieldColor,
                            labelText: MyStrings.paymentMethod.tr,
                            selectedValue: controller.withdrawMethod,
                            onChanged: (value) {
                              controller.setWithdrawMethod(value);
                            },
                            items: controller.withdrawMethodList.map((
                              WithdrawMethod method,
                            ) {
                              return DropdownMenuItem<WithdrawMethod>(
                                value: method,

                                child: Text(
                                  (method.name ?? '').tr,
                                  style: regularDefault.copyWith(
                                    color: MyColor.getTextColor(),
                                    fontFamily: "Inter",
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: Dimensions.space15),
                          CustomAmountTextField(
                            labelText: MyStrings.amount.tr,
                            hintText: MyStrings.enterAmount.tr,
                            inputAction: TextInputAction.done,
                            currency: controller.currency,
                            controller: controller.amountController,
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
                          ),
                          Visibility(
                            visible: controller.authorizationList.length > 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: Dimensions.space15),
                                CustomDropDownTextField2(
                                  labelText: MyStrings.authorizationMethod.tr,
                                  selectedValue:
                                      controller.selectedAuthorizationMode,
                                  onChanged: (value) {
                                    controller.changeAuthorizationMode(value);
                                  },
                                  items: controller.authorizationList.map((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        (value.toString()).tr,
                                        style: regularDefault.copyWith(
                                          color: MyColor.colorWhite,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          controller.mainAmount > 0
                              ? const InfoWidget()
                              : const SizedBox(),
                          const SizedBox(height: Dimensions.space30),
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
                                  text: MyStrings.submit.tr,
                                  press: () {
                                    controller.submitWithdrawRequest();
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
