import 'package:flutter/material.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/view/screens/kyc/widget/widget/choose_file_list_item.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/controller/kyc_controller/kyc_controller.dart';
import 'package:verzusxyz/data/model/kyc/kyc_response_model.dart';

class ConfirmKycFileItem extends StatefulWidget {
  final int index;

  const ConfirmKycFileItem({super.key, required this.index});

  @override
  State<ConfirmKycFileItem> createState() => _ConfirmKycFileItemState();
}

class _ConfirmKycFileItemState extends State<ConfirmKycFileItem> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<KycController>(
      builder: (controller) {
        KycFormModel? model = controller.formList[widget.index];
        return InkWell(
          splashColor: MyColor.transparentColor,
          onTap: () {
            controller.pickFile(widget.index);
          },
          child: ChooseFileItem(
            fileName: model.selectedValue ?? MyStrings.chooseFile,
          ),
        );
      },
    );
  }
}
