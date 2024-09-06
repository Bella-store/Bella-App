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
  static String profile = "assets/images/profile.jpeg";
  static String chair = "assets/images/chair.jpeg";
  static String table = "assets/images/table.jpeg";
  static String masterCard = "assets/images/mastercard_logo.svg";
  static String visa = "assets/images/visa_logo.svg";

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
  static String addTocart(BuildContext context) => 'addTocart'.tr(context);
// Cart screen -------------------------------------------------------------
  static String myCart(BuildContext context) => 'myCart'.tr(context);
  static String total(BuildContext context) => 'total'.tr(context);
  static String checkOut(BuildContext context) => 'checkOut'.tr(context);
  static String promoCode(BuildContext context) => 'promoCode'.tr(context);
// my order screen---------------------------------------------------------
  static String myOrders(BuildContext context) => 'myOrders'.tr(context);
  static String delivered(BuildContext context) => 'delivered'.tr(context);
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
}
