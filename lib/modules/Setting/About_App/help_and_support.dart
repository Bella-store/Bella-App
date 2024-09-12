import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bella_app/shared/app_color.dart';
import 'package:bella_app/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:bella_app/shared/app_string.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.helpAndSupport(context),
          style: TextStyle(
            fontSize: 16.0,
            color: AppColor.whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
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
              // FAQs Section
              _buildSectionHeader(
                  AppString.frequentlyAskedQuestions(context), theme),
              const SizedBox(height: 10),
              _buildFAQItem(
                question: AppString.howToTrackOrder(context),
                answer: AppString.trackOrderAnswer(context),
              ),
              _buildFAQItem(
                question: AppString.returnPolicyQuestion(context),
                answer: AppString.returnPolicyAnswer(context),
              ),
              _buildFAQItem(
                question: AppString.contactSupportQuestion(context),
                answer: AppString.contactSupportAnswer(context),
              ),
              const SizedBox(height: 20),
              // Contact Section
              _buildSectionHeader(AppString.contactUs(context), theme),
              const SizedBox(height: 10),
              _buildContactRow(
                icon: Icons.email,
                text: AppString.emailContact(context),
                onTap: () => {},
              ),
              _buildContactRow(
                icon: Icons.phone,
                text: AppString.phoneContact(context),
                onTap: () => {},
              ),
              const SizedBox(height: 20),
              // Feedback Form Section
              _buildSectionHeader(AppString.submitFeedback(context), theme),
              const SizedBox(height: 10),
              _buildFeedbackForm(context),
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
      style: theme.textTheme.bodyLarge?.copyWith(
        fontSize: 16.0,
        color: AppColor.mainColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),
    );
  }

  // Helper method to build FAQ items
  Widget _buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          fontFamily: 'Montserrat',
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 12.0,
              color: AppColor.greyColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build contact rows
  Widget _buildContactRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColor.mainColor),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 14.0,
          color: AppColor.mainColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),
      onTap: onTap,
    );
  }

  // Feedback form widget
  Widget _buildFeedbackForm(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.feedbackPrompt(context),
          style: TextStyle(
            fontSize: 12.0,
            color: AppColor.greyColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: feedbackController,
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: AppString.feedbackHint(context),
            hintStyle: TextStyle(
              fontSize: 12.0,
              color: AppColor.greyColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Handle feedback submission (e.g., send to server or email)
              feedbackController.clear();
              CustomSnackbar.show(
                context,
                title: AppString.infoTitle(context),
                message: AppString.feedbackThankYou(context),
                contentType: ContentType.help,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
            ),
            child: Text(
              AppString.submit(context),
              style: TextStyle(
                fontSize: 16.0,
                color: AppColor.whiteColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
