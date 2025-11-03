/// A utility class that holds all the URLs and endpoints for the application's API.
class UrlContainer {
  /// The domain URL for the API.
  static const String domainUrl = 'https://script.viserlab.com/xaxino/demo';

  /// The base URL for the API.
  static const String baseUrl = '$domainUrl/api/';

  /// The endpoint for the dashboard.
  static const String dashBoardEndPoint = 'dashboard';

  /// The URL for the deposit history.
  static const String depositHistoryUrl = 'deposit/history';

  /// The URL for the deposit methods.
  static const String depositMethodUrl = 'deposit/methods';

  /// The URL for inserting a new deposit.
  static const String depositInsertUrl = 'deposit/insert';

  /// The endpoint for user registration.
  static const String registrationEndPoint = 'register';

  /// The endpoint for enabling two-factor authentication.
  static const String twoFactorEnable = "twofactor/enable";

  /// The endpoint for disabling two-factor authentication.
  static const String twoFactorDisable = "twofactor/disable";

  /// The endpoint for two-factor authentication.
  static const String twoFactor = "twofactor";

  /// The endpoint for user login.
  static const String loginEndPoint = 'login';

  /// The endpoint for disabling an account.
  static const String accountDisable = "delete-account";

  /// The endpoint for social login.
  static const String socialLoginEndPoint = 'social-login';

  /// The URL for user logout.
  static const String logoutUrl = 'logout';

  /// The endpoint for requesting a password reset.
  static const String forgetPasswordEndPoint = 'password/email';

  /// The endpoint for verifying a password reset code.
  static const String passwordVerifyEndPoint = 'password/verify-code';

  /// The endpoint for resetting a password.
  static const String resetPasswordEndPoint = 'password/reset';

  /// The URL for verifying a 2FA code.
  static const String verify2FAUrl = 'verify-g2fa';

  /// The endpoint for verifying an OTP.
  static const String otpVerify = 'otp-verify';

  /// The endpoint for resending an OTP.
  static const String otpResend = 'otp-resend';

  /// The endpoint for verifying an email address.
  static const String verifyEmailEndPoint = 'verify-email';

  /// The endpoint for verifying a mobile number.
  static const String verifySmsEndPoint = 'verify-mobile';

  /// The endpoint for resending a verification code.
  static const String resendVerifyCodeEndPoint = 'resend-verify/';

  /// The endpoint for authorization.
  static const String authorizationCodeEndPoint = 'authorization';

  /// The URL for the user dashboard.
  static const String dashBoardUrl = 'user/dashboard';

  /// The endpoint for transactions.
  static const String transactionEndpoint = 'transactions';

  /// The URL for adding a withdraw request.
  static const String addWithdrawRequestUrl = 'withdraw-request';

  /// The URL for withdraw methods.
  static const String withdrawMethodUrl = 'withdraw-method';

  /// The URL for confirming a withdraw request.
  static const String withdrawRequestConfirm = 'withdraw-request/confirm';

  /// The URL for withdraw history.
  static const String withdrawHistoryUrl = 'withdraw/history';

  /// The URL for storing a withdraw request.
  static const String withdrawStoreUrl = 'withdraw/store/';

  /// The URL for the withdraw confirmation screen.
  static const String withdrawConfirmScreenUrl = 'withdraw/preview/';

  /// The URL for the KYC form.
  static const String kycFormUrl = 'kyc-form';

  /// The URL for submitting KYC data.
  static const String kycSubmitUrl = 'kyc-submit';

  /// The endpoint for general settings.
  static const String generalSettingEndPoint = 'general-setting';

  /// The endpoint for privacy policy pages.
  static const String privacyPolicyEndPoint = 'policy/pages';

  /// The endpoint for getting user profile information.
  static const String getProfileEndPoint = 'user-info';

  /// The endpoint for updating user profile information.
  static const String updateProfileEndPoint = 'profile-setting';

  /// The endpoint for completing a user's profile.
  static const String profileCompleteEndPoint = 'user-data-submit';

  /// The endpoint for changing a user's password.
  static const String changePasswordEndPoint = 'change-password';

  /// The endpoint for getting a list of countries.
  static const String countryEndPoint = 'get-countries';

  /// The endpoint for the FAQ.
  static const String faqEndPoint = 'faq';

  /// The endpoint for getting a device token.
  static const String deviceTokenEndPoint = 'get/device/token';

  /// The URL for language settings.
  static const String languageUrl = 'language/';

  /// The endpoint for submitting a roulette answer.
  static const String rouletteSubmitAnswer = 'play/roulette/submit';

  /// The endpoint for submitting a keno answer.
  static const String kenoSubmitAnswer = 'play/keno/submit';

  /// The endpoint for investing in the mines game.
  static const String minesInvest = 'play/game/invest/mines';

  /// The endpoint for cashing out in the mines game.
  static const String minesCashOut = 'play/mine/cashout';

  /// The endpoint for ending the mines game.
  static const String minesEnd = 'play/game/end/mines';

  /// The endpoint for investing in the poker game.
  static const String pokerInvest = 'play/game/invest/poker';

  /// The endpoint for referral information.
  static const String refferal = 'user/referral';

  /// The endpoint for the game log.
  static const String gameLog = 'user/game/log';

  /// The endpoint for submitting a head/tail answer.
  static const String headTailSubmitAnswer = 'play/game/invest/head_tail';

  /// The endpoint for investing in the blackjack game.
  static const String blackJackInvest = 'play/game/invest/blackjack';

  /// The endpoint for hitting in the blackjack game.
  static const String blackJackHit = 'play/blackjack/hit';

  /// The endpoint for submitting a spin wheel answer.
  static const String spinWheelSubmitAnswer = 'play/game/invest/spin_wheel';

  /// The endpoint for submitting a dice rolling answer.
  static const String diceRollingSubmitAnswer = 'play/game/invest/dice_rolling';

  /// The endpoint for submitting a number pool answer.
  static const String numberPoolSubmitAnswer = 'play/game/invest/number_pool';

  /// The endpoint for submitting a casino dice answer.
  static const String casinoDiceSubmitAnswer = 'play/dice/submit';

  /// The endpoint for submitting a card finding answer.
  static const String cardFindingAnswer = 'play/game/invest/card_finding';

  /// The endpoint for submitting a number slot answer.
  static const String numberSlotAnswer = 'play/game/invest/number_slot';

  /// The endpoint for submitting a number guessing answer.
  static const String numberGuessingSubmitAnswer =
      'play/game/invest/number_guess';

  /// The endpoint for submitting a guess the number answer.
  static const String guessTheNumberSubmitAnswer = 'play/game/number_guess';

  /// The endpoint for submitting a rock paper scissors answer.
  static const String rockPaperScissorsSubmitAnswer =
      'play/game/invest/rock_paper_scissors';

  /// The endpoint for roulette game data.
  static const String roulettedata = 'play/game/roulette';

  /// The endpoint for keno game data.
  static const String kenodata = 'play/game/keno';

  /// The endpoint for mines game data.
  static const String minesdata = 'play/game/mines';

  /// The endpoint for head/tail game data.
  static const String headTaildata = 'play/game/head_tail';

  /// The endpoint for poker game data.
  static const String pokerdata = 'play/game/poker';

  /// The endpoint for blackjack game data.
  static const String blackJackdata = 'play/game/blackjack';

  /// The endpoint for spin wheel game data.
  static const String spinWheeldata = 'play/game/spin_wheel';

  /// The endpoint for dice rolling game data.
  static const String diceRollingdata = 'play/game/dice_rolling';

  /// The endpoint for number pool game data.
  static const String numberPooldata = 'play/game/number_pool';

  /// The endpoint for casino dice game data.
  static const String casinoDicedata = 'play/game/casino_dice';

  /// The endpoint for card finding game data.
  static const String cardfindingdata = 'play/game/card_finding';

  /// The endpoint for number slot game data.
  static const String numberSlotdata = 'play/game/number_slot';

  /// The endpoint for guess number game data.
  static const String guessNumberdata = 'play/game/number_guess';

  /// The endpoint for rock paper scissors game data.
  static const String rockPaperScissorsdata = 'play/game/rock_paper_scissors';

  /// The endpoint for the roulette game result.
  static const String rouletteResult = 'play/roulette/result';

  /// The endpoint for the keno game result.
  static const String kenoResult = 'play/keno/update';

  /// The endpoint for the head/tail game result.
  static const String headTailResult = 'play/game/end/head_tail';

  /// The endpoint for the rock paper scissors game result.
  static const String rockPaperResult = 'play/game/end/rock_paper_scissors';

  /// The endpoint for dealing in the poker game.
  static const String pokerDeal = 'play/poker/deal';

  /// The endpoint for calling in the poker game.
  static const String pokerCall = 'play/poker/call';

  /// The endpoint for folding in the poker game.
  static const String pokerFold = 'play/poker/fold';

  /// The endpoint for staying in the blackjack game.
  static const String blackJackStay = 'play/blackjack/stay';

  /// The endpoint for the spin wheel game result.
  static const String spinWheelResult = 'play/game/end/spin_wheel';

  /// The endpoint for the dice rolling game result.
  static const String diceRollingResult = 'play/game/end/dice_rolling';

  /// The endpoint for the number pool game result.
  static const String numberPoolResult = 'play/game/end/number_pool';

  /// The endpoint for the casino dice game result.
  static const String casinoDiceResult = 'play/dice/result';

  /// The endpoint for the card finding game result.
  static const String cardFindingResult = 'play/game/end/card_finding';

  /// The endpoint for the number slot game result.
  static const String numberSlotResult = 'play/game/end/number_slot';

  /// The endpoint for the number guess game result.
  static const String numberGuessResult = 'play/game/end/number_guess';

  /// The base URL for dashboard images.
  static const String dashboardImage = '$domainUrl/assets/images/game/';

  /// The base URL for slider images.
  static const String sliderImage = '$domainUrl/assets/images/frontend/slider/';

  /// The base URL for blackjack card images.
  static const String blackJackCardsImage =
      '$domainUrl/assets/templates/basic/images/cards/';

  /// The base URL for poker images.
  static const String pokerImage =
      '$domainUrl/assets/templates/basic/images/poker/';

  /// The base URL for display card images.
  static const String displayCardImage =
      '$domainUrl/assets/templates/basic/images/play/cards/';
}
