import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/data/model/kyc/kyc_response_model.dart';
import 'package:verzusxyz/data/repo/kyc/kyc_repo.dart';
import 'package:image_picker/image_picker.dart';

class KycController extends GetxController {
  final KycRepo repo;
  KycController({required this.repo});

  bool isLoading = true;
  bool isAlreadyVerified = false;
  bool isAlreadyPending = false;
  bool isNoDataFound = false;
  bool submitLoading = false;

  List<KycFormModel> formList = [];

  Future<void> beforeInitLoadKycData() async {
    isLoading = true;
    update();
    KycResponseModel response = await repo.getKycData();
    if (response.status == 'success') {
      final kycData = response.data;
      if (kycData?['status'] == 'verified') {
        isAlreadyVerified = true;
      } else if (kycData?['status'] == 'pending') {
        isAlreadyPending = true;
      } else {
        // Build the form from a predefined structure or settings
        // For simplicity, we'll create a dummy form here
        formList = [
          KycFormModel(
              name: 'Full Name',
              label: 'fullName',
              type: 'text',
              isRequired: 'required'),
          KycFormModel(
              name: 'Photo ID',
              label: 'photoId',
              type: 'file',
              isRequired: 'required'),
        ];
      }
    } else {
      isNoDataFound = true;
    }

    isLoading = false;
    update();
  }

  void changeSelectedValue(value, int index) {
    formList[index].selectedValue = value;
    update();
  }

  void changeSelectedRadioBtnValue(int listIndex, int selectedIndex) {
    formList[listIndex].selectedValue =
        formList[listIndex].options?[selectedIndex];
    update();
  }

  void changeSelectedCheckBoxValue(int listIndex, dynamic value) {
    if (formList[listIndex].cbSelected == null) {
      formList[listIndex].cbSelected = [];
    }

    if (formList[listIndex].cbSelected!.contains(value)) {
      formList[listIndex].cbSelected!.remove(value);
    } else {
      formList[listIndex].cbSelected!.add(value);
    }
    update();
  }

  void changeSelectedFile(File? file, int index) {
    formList[index].imageFile = file;
    update();
  }

  Future<void> pickFile(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      changeSelectedFile(File(image.path), index);
    }
  }

  Future<void> submitKycData() async {
    submitLoading = true;
    update();

    final Map<String, dynamic> data = {};
    final Map<String, File> files = {};

    for (final model in formList) {
      if (model.type == 'file') {
        if (model.imageFile != null) {
          files[model.label!] = model.imageFile!;
        }
      } else {
        data[model.label!] = model.selectedValue;
      }
    }

    try {
      await repo.submitKycData(data, files);
      isAlreadyPending = true;
    } catch (e) {
      // Handle error
    } finally {
      submitLoading = false;
      update();
    }
  }
}

class KycFormModel {
  String? name;
  String? label;
  String? type;
  String? isRequired;
  List<String>? options;
  dynamic selectedValue;
  List<String>? cbSelected;
  File? imageFile;
  TextEditingController? textEditingController;

  KycFormModel({
    this.name,
    this.label,
    this.type,
    this.isRequired,
    this.options,
    this.selectedValue,
    this.cbSelected,
    this.imageFile,
    this.textEditingController,
  });
}
