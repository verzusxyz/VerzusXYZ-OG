class UrlContainer {
  static const String domainUrl = 'https://script.viserlab.com/xaxino/demo';
  static const String baseUrl = '$domainUrl/api/';

  static const String dashBoardEndPoint = 'dashboard';
  static const String depositHistoryUrl = 'deposit/history';
  static const String depositMethodUrl = 'deposit/methods';
  static const String depositInsertUrl = 'deposit/insert';

  static const String registrationEndPoint = 'register';
  static const String twoFactorEnable = "twofactor/enable";
  static const String twoFactorDisable = "twofactor/disable";
  static const String twoFactor = "twofactor";
  static const String loginEndPoint = 'login';
  static const String accountDisable = "delete-account";
  static const String socialLoginEndPoint = 'social-login';
  static const String logoutUrl = 'logout';
  static const String forgetPasswordEndPoint = 'password/email';
  static const String passwordVerifyEndPoint = 'password/verify-code';
  static const String resetPasswordEndPoint = 'password/reset';
  static const String verify2FAUrl = 'verify-g2fa';

  static const String otpVerify = 'otp-verify';
  static const String otpResend = 'otp-resend';

  static const String verifyEmailEndPoint = 'verify-email';
  static const String verifySmsEndPoint = 'verify-mobile';
  static const String resendVerifyCodeEndPoint = 'resend-verify/';
  static const String authorizationCodeEndPoint = 'authorization';

  static const String dashBoardUrl = 'user/dashboard';
  static const String transactionEndpoint = 'transactions';

  static const String addWithdrawRequestUrl = 'withdraw-request';
  static const String withdrawMethodUrl = 'withdraw-method';
  static const String withdrawRequestConfirm = 'withdraw-request/confirm';
  static const String withdrawHistoryUrl = 'withdraw/history';
  static const String withdrawStoreUrl = 'withdraw/store/';
  static const String withdrawConfirmScreenUrl = 'withdraw/preview/';

  static const String kycFormUrl = 'kyc-form';
  static const String kycSubmitUrl = 'kyc-submit';

  static const String generalSettingEndPoint = 'general-setting';
  //static const String moduleSettingEndPoint        = 'module-setting';

  static const String privacyPolicyEndPoint = 'policy/pages';

  static const String getProfileEndPoint = 'user-info';
  static const String updateProfileEndPoint = 'profile-setting';
  static const String profileCompleteEndPoint = 'user-data-submit';

  static const String changePasswordEndPoint = 'change-password';
  static const String countryEndPoint = 'get-countries';
  static const String faqEndPoint = 'faq';

  static const String deviceTokenEndPoint = 'get/device/token';
  static const String languageUrl = 'language/';
  static const String rouletteSubmitAnswer = 'play/roulette/submit';
  static const String kenoSubmitAnswer = 'play/keno/submit';
  static const String minesInvest = 'play/game/invest/mines';
  static const String minesCashOut = 'play/mine/cashout';
  static const String minesEnd = 'play/game/end/mines';
  static const String pokerInvest = 'play/game/invest/poker';
  static const String refferal = 'user/referral';
  static const String gameLog = 'user/game/log';
  static const String headTailSubmitAnswer = 'play/game/invest/head_tail';
  static const String blackJackInvest = 'play/game/invest/blackjack';
  static const String blackJackHit = 'play/blackjack/hit';
  static const String spinWheelSubmitAnswer = 'play/game/invest/spin_wheel';
  static const String diceRollingSubmitAnswer = 'play/game/invest/dice_rolling';
  static const String numberPoolSubmitAnswer = 'play/game/invest/number_pool';
  static const String casinoDiceSubmitAnswer = 'play/dice/submit';
  static const String cardFindingAnswer = 'play/game/invest/card_finding';
  static const String numberSlotAnswer = 'play/game/invest/number_slot';
  static const String numberGuessingSubmitAnswer =
      'play/game/invest/number_guess';
  static const String guessTheNumberSubmitAnswer = 'play/game/number_guess';
  static const String rockPaperScissorsSubmitAnswer =
      'play/game/invest/rock_paper_scissors';
  static const String roulettedata = 'play/game/roulette';
  static const String kenodata = 'play/game/keno';
  static const String minesdata = 'play/game/mines';
  static const String headTaildata = 'play/game/head_tail';
  static const String pokerdata = 'play/game/poker';
  static const String blackJackdata = 'play/game/blackjack';
  static const String spinWheeldata = 'play/game/spin_wheel';
  static const String diceRollingdata = 'play/game/dice_rolling';
  static const String numberPooldata = 'play/game/number_pool';
  static const String casinoDicedata = 'play/game/casino_dice';
  static const String cardfindingdata = 'play/game/card_finding';
  static const String numberSlotdata = 'play/game/number_slot';
  static const String guessNumberdata = 'play/game/number_guess';
  static const String rockPaperScissorsdata = 'play/game/rock_paper_scissors';
  static const String rouletteResult = 'play/roulette/result';
  static const String kenoResult = 'play/keno/update';
  static const String headTailResult = 'play/game/end/head_tail';
  static const String rockPaperResult = 'play/game/end/rock_paper_scissors';
  static const String pokerDeal = 'play/poker/deal';
  static const String pokerCall = 'play/poker/call';
  static const String pokerFold = 'play/poker/fold';
  static const String blackJackStay = 'play/blackjack/stay';
  static const String spinWheelResult = 'play/game/end/spin_wheel';
  static const String diceRollingResult = 'play/game/end/dice_rolling';
  static const String numberPoolResult = 'play/game/end/number_pool';
  static const String casinoDiceResult = 'play/dice/result';
  static const String cardFindingResult = 'play/game/end/card_finding';
  static const String numberSlotResult = 'play/game/end/number_slot';
  static const String numberGuessResult = 'play/game/end/number_guess';
  static const String dashboardImage = '$domainUrl/assets/images/game/';
  static const String sliderImage = '$domainUrl/assets/images/frontend/slider/';
  static const String blackJackCardsImage =
      '$domainUrl/assets/templates/basic/images/cards/';
  static const String pokerImage =
      '$domainUrl/assets/templates/basic/images/poker/';
  static const String displayCardImage =
      '$domainUrl/assets/templates/basic/images/play/cards/';
}
