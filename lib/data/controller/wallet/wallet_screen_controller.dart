import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:verzusxyz/core/helper/shared_preference_helper.dart';
import 'package:verzusxyz/core/utils/my_strings.dart';
import 'package:verzusxyz/data/model/global/response_model/response_model.dart';
import 'package:verzusxyz/data/model/transctions/transaction_response_model.dart';
import 'package:verzusxyz/data/repo/wallet/wallet_screen_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletScreencontroller extends GetxController {
  WalletScreenRepo walletScreenRepo;
  WalletScreencontroller({required this.walletScreenRepo});

  String walletBalance = "0.00";
  int page = 0;
  String totalInvest = "0.00";
  String totalWin = "0.00";
  String defaultCurrency = "";
  bool isLoading = true;
  List<String> transactionTypeList = ["All", "Plus", "Minus"];
  List<Remarks> remarksList = [(Remarks(remark: "All"))];
  TextEditingController trxController = TextEditingController();
  String trxSearchText = '';
  String selectedRemark = "All";
  String selectedTrxType = "All";
  String currency = '';

  void getWalletScreenData() async {
    isLoading = true;
    update();
    loadData();
    ResponseModel model = await walletScreenRepo.loadData();
    if (model.statusCode == 200) {
      TransactionResponseModel walletScreenDataModel =
          TransactionResponseModel.fromJson(jsonDecode(model.responseJson));

      if (walletScreenDataModel.status?.toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        walletBalance =
            walletScreenDataModel.data?.totalBalance.toString() ?? "0";
        totalWin = walletScreenDataModel.data?.totalInvest.toString() ?? "0";
        totalInvest = walletScreenDataModel.data?.totalWin.toString() ?? "0";
      }
    } else {
      CustomSnackBar.error(errorList: [model.message]);
    }
    isLoading = false;
    update();
  }

  loadData() async {
    SharedPreferences.getInstance();

    defaultCurrency =
        walletScreenRepo.apiClient.sharedPreferences.getString(
          SharedPreferenceHelper.defaultCurrencyKey,
        ) ??
        "";
  }

  bool isSearch = false;
  void changeSearchIcon() {
    isSearch = !isSearch;
    update();
    if (!isSearch) {
      initialSelectedValue();
    }
  }

  void initialSelectedValue() async {
    page = 0;
    selectedRemark = "All";
    selectedTrxType = "All";
    trxController.text = '';
    trxSearchText = '';
    isLoading = true;
    update();

    await loadTransaction();
    isLoading = false;
    update();
  }

  bool filterLoading = false;

  Future<void> filterData() async {
    trxSearchText = trxController.text;
    page = 0;
    filterLoading = true;
    update();

    await loadTransaction();

    filterLoading = false;
    update();
  }

  Future<void> loadTransaction() async {
    page = page + 1;

    if (page == 1) {
      currency = walletScreenRepo.apiClient.getCurrencyOrUsername();
      remarksList.clear();
      remarksList.insert(0, Remarks(remark: "All"));
    }

    ResponseModel responseModel = await walletScreenRepo.getTransactionList(
      page,
      type: selectedTrxType.toLowerCase(),
      remark: selectedRemark.toLowerCase(),
      searchText: trxSearchText,
    );

    if (responseModel.statusCode == 200) {
      TransactionResponseModel model = TransactionResponseModel.fromJson(
        jsonDecode(responseModel.responseJson),
      );

      if (model.status.toString().toLowerCase() ==
          MyStrings.success.toLowerCase()) {
        if (page == 1) {
          List<Remarks>? tempRemarksList = model.data?.remarks;

          if (tempRemarksList != null && tempRemarksList.isNotEmpty) {
            for (var element in tempRemarksList) {
              if (element.remark != null &&
                  element.remark?.toLowerCase() != 'null' &&
                  element.remark!.isNotEmpty) {
                remarksList.add(element);
              }
            }
          }
        }
      } else {
        CustomSnackBar.error(
          errorList: model.message?.error ?? [MyStrings.somethingWentWrong],
        );
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }
    update();
  }

  void changeSelectedTrxType(String trxType) {
    selectedTrxType = trxType;
    update();
  }

  bool showDetails = false;
  changeDetailsVisibility() {
    showDetails = !showDetails;
    update();
  }
}
