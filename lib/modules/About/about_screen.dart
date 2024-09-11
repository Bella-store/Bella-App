import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:url_launcher/url_launcher.dart';

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
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Icon
            SvgPicture.asset(
              'assets/logo.svg', // Replace with your app's logo path
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            // App Name
            Text(
              'My Stylish App',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: Colors.deepPurple,
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
              'My Stylish App is designed to provide users with an exceptional experience, featuring sleek design, fast performance, and easy navigation.',
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
              text: 'support@stylishapp.com',
              // onTap: () => _launchEmail('support@stylishapp.com'),
              onTap: () => {},
              theme: theme,
            ),
            _buildContactRow(
              icon: Icons.web,
              text: 'www.stylishapp.com',
              // onTap: () => _launchURL('https://www.stylishapp.com'),
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
        color: Colors.deepPurple,
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
            backgroundColor: Colors.deepPurple,
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
            icon: Icon(Icons.email, color: Colors.deepPurple),
            // onPressed: () => _launchEmail(email),
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
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(
        text,
        style: theme.textTheme.titleSmall?.copyWith(
          color: Colors.deepPurple,
        ),
      ),
      onTap: onTap,
    );
  }

  // Future<void> _launchEmail(String email) async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: email,
  //   );
  //   if (await canLaunchUrl(emailUri)) {
  //     await launchUrl(emailUri);
  //   } else {
  //     throw 'Could not launch $emailUri';
  //   }
  // }

  // Future<void> _launchURL(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
