import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:verzusxyz/data/repo/home/home_repo.dart';
import 'package:verzusxyz/view/components/snack_bar/show_custom_snackbar.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HomeController({required this.homeRepo});

  bool isLoading = true;

  String totalBalance = "0.00";
  String demoBalance = "0.00";
  String name = "";
  String email = "";
  String username = "";

  List<DocumentSnapshot> gamesList = [];
  List<DocumentSnapshot> trendingGamesList = [];
  List<DocumentSnapshot> featuredGamesList = [];
  List<DocumentSnapshot> sliderBannerList = [];

  @override
  void onInit() {
    super.onInit();
    initialData();
  }

  Future<void> initialData() async {
    isLoading = true;
    update();

    await loadData();
    await allGamesInfo();

    isLoading = false;
    update();
  }

  Future<void> loadData() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        name = "${userDoc['firstName']} ${userDoc['lastName']}";
        email = user.email ?? "";
        username = user.displayName ?? "";
        totalBalance = (userDoc['liveBalance'] ?? 0).toStringAsFixed(2);
        demoBalance = (userDoc['demoBalance'] ?? 0).toStringAsFixed(2);
      }
    } catch (e) {
      CustomSnackBar.error(errorList: ['Failed to load user data.']);
    }
  }

  Future<void> allGamesInfo() async {
    try {
      final QuerySnapshot gamesSnapshot = await homeRepo.getGames();
      gamesList = gamesSnapshot.docs;
      // You can add logic here to filter for trending and featured games
      trendingGamesList = gamesList;
      featuredGamesList = gamesList;
      // You would also fetch slider images from a 'banners' collection, for example
    } catch (e) {
      CustomSnackBar.error(errorList: ['Failed to load game information.']);
    }
  }
}
