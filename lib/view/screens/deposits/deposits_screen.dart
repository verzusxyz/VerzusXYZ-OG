import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/string_format_helper.dart';
import 'package:verzusxyz/core/utils/style.dart';
import 'package:verzusxyz/data/controller/deposit/deposit_history_controller.dart';
import 'package:verzusxyz/view/components/text-form-field/no_data_tile.dart';
import 'package:verzusxyz/view/screens/deposits/widget/custom_deposits_card.dart';
import 'package:verzusxyz/view/screens/deposits/widget/deposit_bottom_sheet.dart';
import 'package:verzusxyz/view/screens/deposits/widget/deposit_history_top.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/helper/date_converter.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/repo/deposit/deposit_repo.dart';
import '../../components/custom_loader/custom_loader.dart';
import '../../components/will_pop_widget.dart';

class DepositsScreen extends StatefulWidget {
  const DepositsScreen({Key? key}) : super(key: key);

  @override
  State<DepositsScreen> createState() => _DepositsScreenState();
}

class _DepositsScreenState extends State<DepositsScreen> {
  final DepositRepo _depositRepo = DepositRepo();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: MyColor.gradientBackground),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            MyStrings.deposit,
            style: regularDefault.copyWith(color: MyColor.colorWhite),
          ),
          backgroundColor: MyColor.bottomColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: MyColor.colorWhite,
              size: 20,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                // Show a dialog to select a payment gateway
                _showPaymentGatewayDialog();
              },
              child: Container(
                margin: const EdgeInsets.all(7),
                padding: const EdgeInsets.all(Dimensions.space7),
                decoration: const BoxDecoration(
                  color: MyColor.searchFieldColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: MyColor.colorWhite,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        body: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: _depositRepo.getDepositHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoader();
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return NoDataTile(
                title: MyStrings.noDepositFound.tr,
                hasActionButton: true,
                onTap: _showPaymentGatewayDialog,
                buttonText: MyStrings.makeDeposit.tr,
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(Dimensions.space15),
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: Dimensions.space10),
              itemBuilder: (context, index) {
                final deposit = snapshot.data![index];
                return CustomDepositsCard(
                  onPressed: () {
                    // Show deposit details
                  },
                  trxValue: deposit.id,
                  date: DateConverter.isoToLocalDateAndTime(
                    (deposit['createdAt'] as Timestamp).toDate().toIso8601String(),
                  ),
                  status: deposit['status'],
                  statusBgColor: deposit['status'] == 'completed'
                      ? MyColor.green
                      : MyColor.orange,
                  amount:
                      "${Converter.formatNumber(deposit['amount'].toString())} USD",
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showPaymentGatewayDialog() {
    Get.dialog(
      AlertDialog(
        title: Text(MyStrings.selectPaymentMethod.tr),
        content: FutureBuilder<List<QueryDocumentSnapshot>>(
          future: _depositRepo.getDepositMethods(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CustomLoader();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text(MyStrings.noPaymentMethodsFound.tr);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: snapshot.data!.map((gateway) {
                return ListTile(
                  leading:
                      Image.network(gateway['logoUrl'], width: 40, height: 40),
                  title: Text(gateway['name']),
                  onTap: () {
                    Get.back();
                    _showAmountDialog(gateway.id);
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  void _showAmountDialog(String providerId) {
    final TextEditingController amountController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text(MyStrings.enterAmount.tr),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: MyStrings.amount.tr,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(MyStrings.cancel.tr),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              final double amount = double.parse(amountController.text);
              final String? checkoutUrl = await _depositRepo.createDeposit(
                amount: amount,
                providerId: providerId,
              );
              if (checkoutUrl != null) {
                if (await canLaunch(checkoutUrl)) {
                  await launch(checkoutUrl);
                } else {
                  CustomSnackBar.error(errorList: ['Could not launch URL']);
                }
              } else {
                CustomSnackBar.error(errorList: ['Failed to create deposit']);
              }
            },
            child: Text(MyStrings.proceed.tr),
          ),
        ],
      ),
    );
  }
}
