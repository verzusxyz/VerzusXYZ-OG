import 'package:verzusxyz/view/components/bottom-nav-bar/bottom_nav_bar.dart';
import 'package:verzusxyz/view/screens/Profile/profile_screen.dart';
import 'package:verzusxyz/view/screens/account/change-password/change_password_screen.dart';
import 'package:verzusxyz/view/screens/all-games/black_jack/black_jack_screen.dart';
import 'package:verzusxyz/view/screens/all-games/card_finding/card_finding_screen.dart';
import 'package:verzusxyz/view/screens/all-games/dice_rolling/dice_rolling_screen.dart';
import 'package:verzusxyz/view/screens/all-games/guess_the_number/guess_the_number_screen.dart';
import 'package:verzusxyz/view/screens/all-games/head_tail/head_tail_screen.dart';
import 'package:verzusxyz/view/screens/all-games/keno/keno_screen.dart';
import 'package:verzusxyz/view/screens/all-games/mines/mines_screen.dart';
import 'package:verzusxyz/view/screens/all-games/play_casino_dice/play_casino_dice_screen.dart';
import 'package:verzusxyz/view/screens/all-games/poker/poker_screen.dart';
import 'package:verzusxyz/view/screens/all-games/rock_paper_scissors/rock_paper_scissors_screen.dart';
import 'package:verzusxyz/view/screens/all-games/roulette/roulette_screen.dart';
import 'package:verzusxyz/view/screens/all-games/slot_machine/play_number_slot_screen.dart';
import 'package:verzusxyz/view/screens/all-games/spin_wheel/spin_wheel_screen.dart';
import 'package:verzusxyz/view/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:verzusxyz/view/screens/auth/forget_password/forget_password/forget_password.dart';
import 'package:verzusxyz/view/screens/auth/forget_password/reset_password/reset_password_screen.dart';
import 'package:verzusxyz/view/screens/auth/forget_password/verify_forget_password/verify_forget_password_screen.dart';
import 'package:verzusxyz/view/screens/auth/login/login_screen.dart';
import 'package:verzusxyz/view/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:verzusxyz/view/screens/auth/registration/registration_screen.dart';
import 'package:verzusxyz/view/screens/auth/registration/two_factor/two_factor_setup_screen/two_factor_setup_screen.dart';
import 'package:verzusxyz/view/screens/auth/registration/two_factor/two_factor_verification_screen/two_factor_verification_screen.dart';
import 'package:verzusxyz/view/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:verzusxyz/view/screens/bottom_nav_section/home/home_screen.dart';
import 'package:verzusxyz/view/screens/deposits/deposit_webview/my_webview_screen.dart';
import 'package:verzusxyz/view/screens/deposits/deposits_screen.dart';
import 'package:verzusxyz/view/screens/deposits/new_deposit/new_deposit_screen.dart';
import 'package:verzusxyz/view/screens/edit_profile/edit_profile_screen.dart';
import 'package:verzusxyz/view/screens/all-games/pool_number/pool_number_screen.dart';
import 'package:verzusxyz/view/screens/faq/faq_screen.dart';
import 'package:verzusxyz/view/screens/game_log/game_log_screen.dart';
import 'package:verzusxyz/view/screens/kyc/kyc.dart';
import 'package:verzusxyz/view/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:verzusxyz/view/screens/refferal/refferal_screen.dart';
import 'package:verzusxyz/view/screens/splash/splash_screen.dart';
import 'package:verzusxyz/view/screens/transaction/transactions_screen.dart';
import 'package:get/get.dart';
import '../../view/screens/withdraw/add_withdraw_screen/add_withdraw_method_screen.dart';
import '../../view/screens/withdraw/confirm_withdraw_screen/withdraw_confirm_screen.dart';
import '../../view/screens/withdraw/withdraw_history/withdraw_screen.dart';

class RouteHelper {
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = "/onboard_screen";
  static const String loginScreen = "/login_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String registrationScreen = "/registration_screen";
  static const String bottomNavBar = "/bottom_nav_bar";
  static const String profileCompleteScreen = "/profile_complete_screen";
  static const String emailVerificationScreen = "/verify_email_screen";
  static const String smsVerificationScreen = "/verify_sms_screen";
  static const String verifyPassCodeScreen = "/verify_pass_code_screen";
  static const String twoFactorScreen = "/two-factor-screen";
  static const String twoFactorVerificationScreen =
      "/two-factor-verification-screen";
  static const String resetPasswordScreen = "/reset_pass_screen";
  static const String transactionHistoryScreen = "/transaction_history_screen";
  static const String profileScreen = "/profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String kycScreen = "/kyc_screen";
  static const String privacyScreen = "/privacy-screen";
  static const String faqScreen = "/faq-screen";

  static const String withdrawScreen = "/withdraw-screen";
  static const String addWithdrawMethodScreen = "/withdraw-method";
  static const String withdrawConfirmScreenScreen = "/withdraw-preview-screen";
  static const String headAndTailScreen = "/head-tail-screen";
  static const String rockPaperScissorsScreen = "/rock-paper-screen";
  static const String rouletteScreen = "/roulette-screen";
  static const String guessTheNumberScreen = "/guess-the-number-screen";
  static const String diceRollingScreen = "/dice-rolling-screen";
  static const String spinWheelScreen = "/spin-wheel-screen";
  static const String cardFindingScreen = "/card_finding-screen";
  static const String numberSlotScreen = "/slot_machine-screen";
  static const String poolNumberScreen = "/pool_number_screen";
  static const String playCasinoDiceScreen = "/play_casino_dice_screen";
  static const String kenoScreen = "/keno_screen";
  static const String blackJackScreen = "/black_jack_screen";
  static const String pokerScreen = "/poker_screen";
  static const String minesScreen = "/mines_screen";
  static const String gameLog = "/game_log_screen";
  static const String refferalScreen = "/refferal_screen";
  static const String depositWebViewScreen = '/deposit_webView';
  static const String depositsScreen = "/deposits";
  static const String depositsDetailsScreen = "/deposits_details";
  static const String newDepositScreenScreen = "/deposits_money";
  static const String homeScreen = "/home_screen";

  List<GetPage> routes = [
    GetPage(
      name: depositWebViewScreen,
      page: () => MyWebViewScreen(redirectUrl: Get.arguments),
    ),
    GetPage(name: depositsScreen, page: () => const DepositsScreen()),
    GetPage(name: faqScreen, page: () => const FaqScreen()),
    GetPage(name: newDepositScreenScreen, page: () => const NewDepositScreen()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgetPasswordScreen(),
    ),
    GetPage(
      name: changePasswordScreen,
      page: () => const ChangePasswordScreen(),
    ),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen()),
    GetPage(
      name: profileCompleteScreen,
      page: () => const ProfileCompleteScreen(),
    ),
    GetPage(name: bottomNavBar, page: () => const BottomNavBar()),
    GetPage(name: withdrawScreen, page: () => const WithdrawScreen()),
    GetPage(
      name: addWithdrawMethodScreen,
      page: () => const AddWithdrawMethod(),
    ),
    GetPage(
      name: withdrawConfirmScreenScreen,
      page: () => const WithdrawConfirmScreen(),
    ),

    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(
      name: transactionHistoryScreen,
      page: () => const TransactionsScreen(),
    ),

    GetPage(
      name: emailVerificationScreen,
      page: () => const EmailVerificationScreen(),
    ),
    GetPage(
      name: smsVerificationScreen,
      page: () => const SmsVerificationScreen(),
    ),
    GetPage(
      name: verifyPassCodeScreen,
      page: () => const VerifyForgetPassScreen(),
    ),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen()),
    GetPage(name: twoFactorScreen, page: () => const TwoFactorSetupScreen()),
    GetPage(
      name: twoFactorVerificationScreen,
      page: () => const TwoFactorVerificationScreen(),
    ),

    GetPage(name: kycScreen, page: () => const KycScreen()),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen()),
    GetPage(name: headAndTailScreen, page: () => const HeadTailScreen()),
    GetPage(
      name: rockPaperScissorsScreen,
      page: () => const RockPaperScissorsScreen(),
    ),
    GetPage(name: rouletteScreen, page: () => const RouletteScreen()),
    GetPage(
      name: guessTheNumberScreen,
      page: () => const GuessTheNumberScreen(),
    ),
    GetPage(name: diceRollingScreen, page: () => const DiceRollingScreen()),
    GetPage(name: spinWheelScreen, page: () => const SpinWheelScreen()),
    GetPage(name: cardFindingScreen, page: () => const CardFindingScreen()),
    GetPage(name: numberSlotScreen, page: () => const PlayNumberSlotScreen()),
    GetPage(name: poolNumberScreen, page: () => const PoolNumberScreen()),
    GetPage(
      name: playCasinoDiceScreen,
      page: () => const PlayCasinoDiceScreen(),
    ),
    GetPage(name: kenoScreen, page: () => const KenoScreen()),
    GetPage(name: blackJackScreen, page: () => const BlackJackScreen()),
    GetPage(name: pokerScreen, page: () => const PokerScreen()),
    GetPage(name: minesScreen, page: () => const MinesScreen()),
    GetPage(name: gameLog, page: () => const GameLogScreen()),
    GetPage(name: refferalScreen, page: () => const RefferalScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
  ];
}
