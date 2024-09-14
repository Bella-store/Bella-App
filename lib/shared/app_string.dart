import 'package:flutter/material.dart';
import 'package:bella_app/shared/local/languages/app_localizations.dart';

class AppString {
  // Images properties
  static String logo = "assets/images/logo.svg";
  static String group = "assets/images/group.svg";
  static String splash = "assets/images/splash.jpeg";
  static String onBoarding1 = "assets/images/onboarding1.jpg";
  static String onBoarding2 = "assets/images/onboarding2.jpg";
  static String onBoarding3 = "assets/images/onboarding3.jpg";
  static String profile =
      "https://firebasestorage.googleapis.com/v0/b/bella-store-ece11.appspot.com/o/user_images%2Fprofile.jpeg?alt=media&token=63588430-6a3d-44ec-a684-f438311a0fbb";
  static String chair = "assets/images/chair.jpeg";
  static String table = "assets/images/table.jpeg";
  static String masterCard = "assets/images/mastercard_logo.svg";
  static String visaCard = "assets/images/visa_logo.svg";
  static String notFound = "assets/images/notfound_img.png";
  // Localization properties
  static String setting(BuildContext context) => 'setting'.tr(context);
  static String general(BuildContext context) => 'general'.tr(context);
  static String language(BuildContext context) => 'language'.tr(context);
  static String notification(BuildContext context) =>
      'notification'.tr(context);
  static String darkMode(BuildContext context) => 'darkMode'.tr(context);
  static String aboutApp(BuildContext context) => 'aboutApp'.tr(context);
  static String helpAndSupport(BuildContext context) =>
      'helpAndSupport'.tr(context);
  static String termsAndConditions(BuildContext context) =>
      'termsAndConditions'.tr(context);
  static String myReviews(BuildContext context) => 'myReviews'.tr(context);
  static String editProfile(BuildContext context) => 'editProfile'.tr(context);

  //onBoarding screen ---------------------------------------------------------
  static String skip(BuildContext context) => 'skip'.tr(context);
  static String getStarted(BuildContext context) => 'getStarted'.tr(context);
  static String onboardingTitle1(BuildContext context) =>
      'onboardingTitle1'.tr(context);
  static String onboardingSubtitle1(BuildContext context) =>
      'onboardingSubtitle1'.tr(context);
  static String onboardingTitle2(BuildContext context) =>
      'onboardingTitle2'.tr(context);
  static String onboardingSubtitle2(BuildContext context) =>
      'onboardingSubtitle2'.tr(context);
  static String onboardingTitle3(BuildContext context) =>
      'onboardingTitle3'.tr(context);
  static String onboardingSubtitle3(BuildContext context) =>
      'onboardingSubtitle3'.tr(context);
// login Screen --------------------------------------------------------------
  static String welcome(BuildContext context) => 'welcome'.tr(context);
  static String plzLogin(BuildContext context) => 'plzLogin'.tr(context);
  static String email(BuildContext context) => 'email'.tr(context);
  static String plzEnterEmail(BuildContext context) =>
      'plzEnterEmail'.tr(context);
  static String plzEnterValidEmail(BuildContext context) =>
      'plzEnterValidEmail'.tr(context);

  static String password(BuildContext context) => 'password'.tr(context);
  static String plzEnterPassword(BuildContext context) =>
      'plzEnterPassword'.tr(context);
  static String plzconfirmYourPassword(BuildContext context) =>
      'plzconfirmYourPassword'.tr(context);
  static String yourPasswordDoesNotMatch(BuildContext context) =>
      'yourPasswordDoesNotMatch'.tr(context);
  static String login(BuildContext context) => 'login'.tr(context);
  static String forgotPassword(BuildContext context) =>
      'forgotPassword'.tr(context);
  static String dontHaveAnAccount(BuildContext context) =>
      'dontHaveAnAccount'.tr(context);
  static String or(BuildContext context) => 'or'.tr(context);
  static String continueWithFacebook(BuildContext context) =>
      'continueWithFacebook'.tr(context);
  static String continueWithGoogle(BuildContext context) =>
      'continueWithGoogle'.tr(context);
  static String continueWithApple(BuildContext context) =>
      'continueWithApple'.tr(context);
// signUp Screen ----------------------------------------------------------
  static String signUp(BuildContext context) => 'signUp'.tr(context);
  static String alreadyHaveAnAccount(BuildContext context) =>
      'alreadyHaveAnAccount'.tr(context);
  static String plzSignUp(BuildContext context) => 'plzSignUp'.tr(context);
  static String username(BuildContext context) => 'username'.tr(context);
  static String plzEnterUsername(BuildContext context) =>
      'plzEnterUsername'.tr(context);
//  Home Screen -----------------------------------------------------
  static String search(BuildContext context) => 'search'.tr(context);
  static String findYour(BuildContext context) => 'findYour'.tr(context);
  static String dreamFurniture(BuildContext context) =>
      'dreamFurniture'.tr(context);
  static String seeAll(BuildContext context) => 'seeAll'.tr(context);
  static String categories(BuildContext context) => 'categories'.tr(context);
  static String sofa(BuildContext context) => 'sofa'.tr(context);
  static String bed(BuildContext context) => 'bed'.tr(context);
  static String products(BuildContext context) => 'products'.tr(context);
// product details screen ------------------------------------------------------
  static String productDetails(BuildContext context) =>
      'productDetails'.tr(context);
  static String description(BuildContext context) => 'description'.tr(context);
  static String availableInStock(BuildContext context) =>
      'availableInStock'.tr(context);
  static String outOfStock(BuildContext context) => 'outOfStock'.tr(context);
  static String addTocart(BuildContext context) => 'addTocart'.tr(context);
// Cart screen -------------------------------------------------------------
  static String myCart(BuildContext context) => 'myCart'.tr(context);
  static String total(BuildContext context) => 'total'.tr(context);
  static String checkOut(BuildContext context) => 'checkOut'.tr(context);
  static String promoCode(BuildContext context) => 'promoCode'.tr(context);
  static String yourCartIsEmpty(BuildContext context) =>
      'yourCartIsEmpty'.tr(context);
// my order screen---------------------------------------------------------
  static String myOrders(BuildContext context) => 'myOrders'.tr(context);
  static String delivered(BuildContext context) => 'delivered'.tr(context);
  static String completed(BuildContext context) => 'completed'.tr(context);
  static String processing(BuildContext context) => 'processing'.tr(context);
  static String canceled(BuildContext context) => 'canceled'.tr(context);
  static String detail(BuildContext context) => 'detail'.tr(context);
  static String totalAmount(BuildContext context) => 'totalAmount'.tr(context);
  static String quantity(BuildContext context) => 'quantity'.tr(context);

  static String addPaymentMethod(BuildContext context) =>
      'addPaymentMethod'.tr(context);
  static String addCard(BuildContext context) => 'addCard'.tr(context);
  static String cardHolderName(BuildContext context) =>
      'cardHolderName'.tr(context);
  static String expiryDate(BuildContext context) => 'expiryDate'.tr(context);
  static String pleaseEnterCardHolderName(BuildContext context) =>
      'pleaseEnterCardHolderName'.tr(context);
  static String pleaseEnterCardNumber(BuildContext context) =>
      'pleaseEnterCardNumber'.tr(context);
  static String cardNumber(BuildContext context) => 'cardNumber'.tr(context);
  static String pleaseEnterValidCard(BuildContext context) =>
      'pleaseEnterValidCard'.tr(context);
  static String exirationDate(BuildContext context) =>
      'exirationDate'.tr(context);
  static String pleaseEnterExpirationDate(BuildContext context) =>
      'pleaseEnterExpirationDate'.tr(context);

  // favorites screen -------------------------------------------------------------
  static String favorites(BuildContext context) => 'Favorites'.tr(context);
  static String addAllToMyCart(BuildContext context) =>
      'addAllToMyCart'.tr(context);
  static String noFavoritesYet(BuildContext context) =>
      'noFavoritesYet'.tr(context);

  // products screen -------------------------------------------------------------
  static String allProducts(BuildContext context) => 'allProducts'.tr(context);
  static String logout(BuildContext context) => 'logout'.tr(context);
  static String areYouSureLogout(BuildContext context) =>
      'areYouSureLogout'.tr(context);
  static String cancel(BuildContext context) => 'cancel'.tr(context);
  static String no(BuildContext context) => 'no'.tr(context);
  static String yes(BuildContext context) => 'yes'.tr(context);

  // Choose Categories --------------------------------------------------------------
  static String chooseCategories(BuildContext context) =>
      'chooseCategories'.tr(context);

  static String pleaseChooseOneCategory(BuildContext context) =>
      'pleaseChooseOneCategory'.tr(context);
  static String submit(BuildContext context) => 'submit'.tr(context);

  // OrderSummary ---------------------------------------------------------------------
  static String orderSummary(BuildContext context) =>
      'orderSummary'.tr(context);
  static String proceedToPayment(BuildContext context) =>
      'proceedToPayment'.tr(context);

  // checkout screen ------------------------------------------------------------------
  static String delivery(BuildContext context) => 'delivery'.tr(context);
  static String paymentMethod(BuildContext context) =>
      'paymentMethod'.tr(context);
  static String pickUp(BuildContext context) => 'pickUp'.tr(context);
  static String proceed(BuildContext context) => 'proceed'.tr(context);
  static String visa(BuildContext context) => 'visa'.tr(context);
  static String payVisa(BuildContext context) => 'payVisa'.tr(context);
  static String save(BuildContext context) => 'save'.tr(context);
  static String continuePayment(BuildContext context) =>
      'continuePayment'.tr(context);
  static String userInfo(BuildContext context) => 'userInfo'.tr(context);
  static String changeAddress(BuildContext context) =>
      'changeAddress'.tr(context);
  static String changePhoneNumber(BuildContext context) =>
      'changePhoneNumber'.tr(context);
  static String changeEmail(BuildContext context) => 'changeEmail'.tr(context);
  static String enterAddress(BuildContext context) =>
      'enterAddress'.tr(context);

  static String enterPhoneNumber(BuildContext context) =>
      'enterPhoneNumber'.tr(context);

  static String enterEmail(BuildContext context) => 'enterEmail'.tr(context);
  static String pickUpSubtitle(BuildContext context) =>
      'pickUpSubtitle'.tr(context);

  static String all(BuildContext context) => 'all'.tr(context);
  static String livingRoom(BuildContext context) => 'livingRoom'.tr(context);
  static String bedRoom(BuildContext context) => 'bedRoom'.tr(context);
  static String decoration(BuildContext context) => 'decoration'.tr(context);

  static String noProductsFound(BuildContext context) =>
      'noProductsFound'.tr(context);
  static String selectCategory(BuildContext context) =>
      "selectCategory".tr(context);

  static String noProductsFoundForThisCategory(BuildContext context) =>
      "noProductsFoundForThisCategory".tr(context);
  static String pleaseSelectACategory(BuildContext context) =>
      "pleaseSelectACategory".tr(context);

  // Terms and Conditions screen
  static String termsAndConditionsTitle(BuildContext context) =>
      'termsAndConditionsTitle'.tr(context);
  static String welcomeMessage(BuildContext context) =>
      'welcomeMessage'.tr(context);
  static String introduction(BuildContext context) =>
      'introduction'.tr(context);
  static String acceptanceOfTerms(BuildContext context) =>
      'acceptanceOfTerms'.tr(context);
  static String acceptanceOfTermsDescription(BuildContext context) =>
      'acceptanceOfTermsDescription'.tr(context);
  static String purchasesAndPayments(BuildContext context) =>
      'purchasesAndPayments'.tr(context);
  static String purchasesAndPaymentsDescription(BuildContext context) =>
      'purchasesAndPaymentsDescription'.tr(context);
  static String deliveryPolicy(BuildContext context) =>
      'deliveryPolicy'.tr(context);
  static String deliveryPolicyDescription(BuildContext context) =>
      'deliveryPolicyDescription'.tr(context);
  static String returnsAndRefunds(BuildContext context) =>
      'returnsAndRefunds'.tr(context);
  static String returnsAndRefundsDescription(BuildContext context) =>
      'returnsAndRefundsDescription'.tr(context);
  static String userConduct(BuildContext context) => 'userConduct'.tr(context);
  static String userConductDescription(BuildContext context) =>
      'userConductDescription'.tr(context);
  static String privacyPolicy(BuildContext context) =>
      'privacyPolicy'.tr(context);
  static String privacyPolicyDescription(BuildContext context) =>
      'privacyPolicyDescription'.tr(context);
  static String changesToTerms(BuildContext context) =>
      'changesToTerms'.tr(context);
  static String changesToTermsDescription(BuildContext context) =>
      'changesToTermsDescription'.tr(context);
  static String contactMessage(BuildContext context) =>
      'contactMessage'.tr(context);
  static String contactUsButton(BuildContext context) =>
      'contactUsButton'.tr(context);

  // Help & Support screen
  // static String helpAndSupport(BuildContext context) => 'helpAndSupport'.tr(context);
  static String frequentlyAskedQuestions(BuildContext context) =>
      'frequentlyAskedQuestions'.tr(context);
  static String howToTrackOrder(BuildContext context) =>
      'howToTrackOrder'.tr(context);
  static String trackOrderAnswer(BuildContext context) =>
      'trackOrderAnswer'.tr(context);
  static String returnPolicyQuestion(BuildContext context) =>
      'returnPolicyQuestion'.tr(context);
  static String returnPolicyAnswer(BuildContext context) =>
      'returnPolicyAnswer'.tr(context);
  static String contactSupportQuestion(BuildContext context) =>
      'contactSupportQuestion'.tr(context);
  static String contactSupportAnswer(BuildContext context) =>
      'contactSupportAnswer'.tr(context);
  static String contactUs(BuildContext context) => 'contactUs'.tr(context);
  static String emailContact(BuildContext context) =>
      'emailContact'.tr(context);
  static String phoneContact(BuildContext context) =>
      'phoneContact'.tr(context);
  static String submitFeedback(BuildContext context) =>
      'submitFeedback'.tr(context);
  static String feedbackPrompt(BuildContext context) =>
      'feedbackPrompt'.tr(context);
  static String feedbackHint(BuildContext context) =>
      'feedbackHint'.tr(context);
  static String infoTitle(BuildContext context) => 'infoTitle'.tr(context);
  static String feedbackThankYou(BuildContext context) =>
      'feedbackThankYou'.tr(context);
  // static String submit(BuildContext context) => 'submit'.tr(context);

  // About screen
  // static String aboutApp(BuildContext context) => 'aboutApp'.tr(context);
  static String appName(BuildContext context) => 'appName'.tr(context);
  static String appVersion(BuildContext context) => 'appVersion'.tr(context);
  static String appDescription(BuildContext context) =>
      'appDescription'.tr(context);
  static String developers(BuildContext context) => 'developers'.tr(context);
  static String developerName1(BuildContext context) =>
      'developerName1'.tr(context);
  static String developerRole1(BuildContext context) =>
      'developerRole1'.tr(context);
  static String developerEmail1(BuildContext context) =>
      'developerEmail1'.tr(context);
  static String developerName2(BuildContext context) =>
      'developerName2'.tr(context);
  static String developerRole2(BuildContext context) =>
      'developerRole2'.tr(context);
  static String developerEmail2(BuildContext context) =>
      'developerEmail2'.tr(context);
  // static String contactUs(BuildContext context) => 'contactUs'.tr(context);
  static String supportEmail(BuildContext context) =>
      'supportEmail'.tr(context);
  static String website(BuildContext context) => 'website'.tr(context);
}
