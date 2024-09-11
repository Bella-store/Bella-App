import 'package:bella_app/shared/app_color.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
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
                'Welcome to Bella - Modern Furniture Store',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Introduction
              Text(
                'These terms and conditions outline the rules and regulations for the use of Bella’s application.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 1
              _buildSectionHeader('1. Acceptance of Terms', theme),
              Text(
                'By accessing or using Bella, you agree to be bound by these terms. If you disagree with any part of the terms, you may not use our service.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 2
              _buildSectionHeader('2. Purchases and Payments', theme),
              Text(
                'Bella offers a wide range of modern furniture products. All payments are processed securely, and you agree to provide accurate payment information.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 3
              _buildSectionHeader('3. Delivery Policy', theme),
              Text(
                'Orders will be processed and shipped according to our delivery policy. Bella is not responsible for delays caused by external factors.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 4
              _buildSectionHeader('4. Returns and Refunds', theme),
              Text(
                'You can return products in accordance with our return and refund policy. Products must be in original condition and returned within the specified period.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 5
              _buildSectionHeader('5. User Conduct', theme),
              Text(
                'Users agree not to misuse the app by engaging in prohibited activities such as fraud, harassment, or unauthorized access to the app’s resources.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 6
              _buildSectionHeader('6. Privacy Policy', theme),
              Text(
                'Bella respects your privacy. Please read our Privacy Policy to understand how we collect, use, and protect your personal information.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Section 7
              _buildSectionHeader('7. Changes to Terms', theme),
              Text(
                'Bella reserves the right to modify these terms at any time. Continued use of the app after changes implies acceptance of the revised terms.',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
              const SizedBox(height: 20),
              // Closing
              Text(
                'If you have any questions or concerns about these terms, please contact us at support@bella.com.',
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
                      backgroundColor: AppColor.mainColor),
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: AppColor.whiteColor,
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
