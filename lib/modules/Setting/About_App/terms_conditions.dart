import 'package:bella_app/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:bella_app/shared/app_string.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.termsAndConditionsTitle(context),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppString.welcomeMessage(context),
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Introduction
              Text(
                AppString.introduction(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 1
              _buildSectionHeader(AppString.acceptanceOfTerms(context), theme),
              Text(
                AppString.acceptanceOfTermsDescription(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 2
              _buildSectionHeader(
                  AppString.purchasesAndPayments(context), theme),
              Text(
                AppString.purchasesAndPaymentsDescription(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 3
              _buildSectionHeader(AppString.deliveryPolicy(context), theme),
              Text(
                AppString.deliveryPolicyDescription(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 4
              _buildSectionHeader(AppString.returnsAndRefunds(context), theme),
              Text(
                AppString.returnsAndRefundsDescription(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 5
              _buildSectionHeader(AppString.userConduct(context), theme),
              Text(
                AppString.userConductDescription(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 6
              _buildSectionHeader(AppString.privacyPolicy(context), theme),
              Text(
                AppString.privacyPolicyDescription(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 7
              _buildSectionHeader(AppString.changesToTerms(context), theme),
              Text(
                AppString.changesToTermsDescription(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Closing
              Text(
                AppString.contactMessage(context),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  color: AppColor.greyColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Contact Us Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Implement contact or help action here
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(
                      color: AppColor.mainColor,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    backgroundColor: AppColor.mainColor,
                  ),
                  child: Text(
                    AppString.contactUsButton(context),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build section headers
  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleSmall?.copyWith(
        fontSize: 16.0,
        color: AppColor.mainColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),
    );
  }
}
