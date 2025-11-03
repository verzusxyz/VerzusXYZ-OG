class KenoNumberModel {
  int number;
  bool isFromAdmin;
  bool isSelected;

  KenoNumberModel({required this.number,required this.isFromAdmin,required this.isSelected });

  void setSelectedValue(bool selectStatus) {
    isSelected = selectStatus;
  }
}
