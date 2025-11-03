class MinesModel {
  String imagePath;
  bool isBombed;
  bool isJewel;
  bool isLocked;
  bool tapped;
  int tapCounter;

  MinesModel({required this.imagePath, required this.isBombed, required this.isJewel, required this.isLocked, required this.tapped,required this.tapCounter});
}
