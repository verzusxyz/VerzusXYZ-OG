import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/account/profile_complete_controller.dart';
import 'package:verzusxyz/data/controller/auth/auth/registration_controller.dart';
import 'package:verzusxyz/view/components/bottom-sheet/bottom_sheet_header_row.dart';
import 'package:verzusxyz/view/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:verzusxyz/view/components/card/bottom_sheet_card.dart';
import 'package:get/get.dart';

class CountryBottomSheet {
  static void bottomSheet(
    BuildContext context,
    RegistrationController controller,
  ) {
    CustomBottomSheet(
      bgColor: MyColor.bottomColor,
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        padding: const EdgeInsets.only(top: 5, bottom: 20, left: 10, right: 10),
        child: Column(
          children: [
            const BottomSheetHeaderRow(header: ''),
            const SizedBox(height: 15),
            // Flexible(
            //   child: ListView.builder(
            //       itemCount: controller.countryList.length,
            //       shrinkWrap: true,
            //       physics: const BouncingScrollPhysics(),
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: () {
            //             controller.countryController.text = controller.countryList[index].country ?? '';
            //             controller.setCountryNameAndCode(controller.countryList[index].country ?? '', controller.countryList[index].countryCode ?? '', controller.countryList[index].dialCode ?? '');

            //             Navigator.pop(context);

            //             FocusScopeNode currentFocus = FocusScope.of(context);
            //             if (!currentFocus.hasPrimaryFocus) {
            //               currentFocus.unfocus();
            //             }
            //           },
            //           child: BottomSheetCard(
            //             child: Text('+${controller.countryList[index].dialCode}  ${controller.countryList[index].country?.tr ?? ''}', style: regularDefaultInter.copyWith(color: MyColor.getTextColor())),
            //           ),
            //         );
            //       }),
            // )
          ],
        ),
      ),
    ).customBottomSheet(context);
  }

  static void countryBottomSheet(
    BuildContext context,
    ProfileCompleteController controller,
  ) {
    CustomBottomSheet(
      bgColor: MyColor.bottomColor,
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            const BottomSheetHeaderRow(header: ''),
            const SizedBox(height: 15),
            Flexible(
              child: ListView.builder(
                itemCount: controller.countryList.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.countryController.text =
                          controller.countryList[index].country ?? '';
                      controller.setCountryNameAndCode(
                        controller.countryList[index].country ?? '',
                        controller.countryList[index].countryCode ?? '',
                        controller.countryList[index].dialCode ?? '',
                      );

                      Navigator.pop(context);

                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    },
                    child: BottomSheetCard(
                      child: Text(
                        '+${controller.countryList[index].dialCode}  ${controller.countryList[index].country?.tr ?? ''}',
                        style: regularDefaultInter.copyWith(
                          color: MyColor.getTextColor(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ).customBottomSheet(context);
  }
}
