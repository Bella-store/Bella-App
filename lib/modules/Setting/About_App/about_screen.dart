import 'package:bella_app/shared/app_color.dart';
import 'package:flutter/material.dart';
import 'package:bella_app/shared/app_string.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.aboutApp(context),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Name
            Text(
              AppString.appName(context),
              style: theme.textTheme.headlineLarge?.copyWith(
                color: AppColor.mainColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 10),
            // App Version
            Text(
              AppString.appVersion(context),
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 14.0,
                color: AppColor.greyColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 20),
            // App Description
            Text(
              AppString.appDescription(context),
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 14.0,
                color: AppColor.greyColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            const SizedBox(height: 30),
            // Developer Section
            _buildSectionHeader(AppString.developers(context)),
            _buildDeveloperInfo(
              name: AppString.developerName1(context),
              role: AppString.developerRole1(context),
              email: AppString.developerEmail1(context),
              theme: theme,
            ),
            _buildDeveloperInfo(
              name: AppString.developerName2(context),
              role: AppString.developerRole2(context),
              email: AppString.developerEmail2(context),
              theme: theme,
            ),
            const SizedBox(height: 30),
            // Contact Information
            _buildSectionHeader(AppString.contactUs(context)),
            _buildContactRow(
              icon: Icons.email,
              text: AppString.supportEmail(context),
              onTap: () => {},
              theme: theme,
            ),
            _buildContactRow(
              icon: Icons.web,
              text: AppString.website(context),
              onTap: () => {},
              theme: theme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.0,
        color: AppColor.mainColor,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Widget _buildDeveloperInfo({
    required String name,
    required String role,
    required String email,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColor.mainColor,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          subtitle: Text(
            role,
            style: theme.textTheme.titleSmall?.copyWith(
              fontSize: 11.0,
              color: AppColor.greyColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.email, color: AppColor.mainColor),
            onPressed: () => {},
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColor.mainColor),
      title: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          fontSize: 12.0,
          color: AppColor.mainColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),
      onTap: onTap,
    );
  }
}
