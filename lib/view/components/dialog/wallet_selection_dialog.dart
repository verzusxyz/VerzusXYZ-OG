import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/core/utils/my_color.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/view/components/buttons/gradient_rounded_button.dart';

class WalletSelectionDialog extends StatelessWidget {
  final VoidCallback onLiveWallet;
  final VoidCallback onDemoWallet;

  const WalletSelectionDialog({
    Key? key,
    required this.onLiveWallet,
    required this.onDemoWallet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(MyStrings.selectWallet.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GradientRoundedButton(
            text: MyStrings.liveWallet.tr,
            press: onLiveWallet,
          ),
          const SizedBox(height: 10),
          GradientRoundedButton(
            text: MyStrings.demoWallet.tr,
            press: onDemoWallet,
          ),
        ],
      ),
      backgroundColor: MyColor.secondaryColor950,
    );
  }
}
