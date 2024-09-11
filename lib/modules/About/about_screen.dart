import 'package:bella_app/shared/app_color.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About App',
          style: TextStyle(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Name
            Text(
              'Bella App',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: AppColor.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // App Version
            Text(
              'Version 1.0.0',
              style: theme.textTheme.titleSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            // App Description
            Text(
              'This application is an modern furniture store. This is the official app of the Bella Company.',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
            // Developer Section
            _buildSectionHeader('Developers'),
            _buildDeveloperInfo(
              name: 'John Doe',
              role: 'Lead Developer',
              email: 'johndoe@example.com',
              theme: theme,
            ),
            _buildDeveloperInfo(
              name: 'Jane Smith',
              role: 'UI/UX Designer',
              email: 'janesmith@example.com',
              theme: theme,
            ),
            const SizedBox(height: 30),
            // Contact Information
            _buildSectionHeader('Contact Us'),
            _buildContactRow(
              icon: Icons.email,
              text: 'support@bella.com',
              onTap: () => {},
              theme: theme,
            ),
            _buildContactRow(
              icon: Icons.web,
              text: 'www.bella.com',
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
        color: AppColor.mainColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
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
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            name,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            role,
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.grey[600],
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
          color: AppColor.mainColor,
        ),
      ),
      onTap: onTap,
    );
  }
}
