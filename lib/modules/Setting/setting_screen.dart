import 'package:bella_app/shared/app_string.dart';
import 'package:flutter/material.dart';

import '../../shared/app_color.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isNotificationEnabled = false;
  bool _isDarkMode = false;
  String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.setting),
        centerTitle: true,
        leading: BackButton(color: AppColor.blackColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomSettingsSection(
              title: AppString.general,
              options: [
                CustomSettingsOption(
                  icon: Icons.language,
                  label: AppString.language,
                  trailing: _buildLanguageDropdown(),
                ),
                CustomSettingsOption(
                  icon: Icons.notifications,
                  label: AppString.notification,
                  trailing: Switch(
                    inactiveTrackColor: Colors.transparent,
                    activeColor: AppColor.blackColor,
                    value: _isNotificationEnabled,
                    onChanged: (bool value) {
                      setState(() {
                        _isNotificationEnabled = value;
                      });
                    },
                  ),
                  onTap: () {
                    // Handle notification option tap
                  },
                ),
                CustomSettingsOption(
                  icon: Icons.dark_mode,
                  label: AppString.darkMode,
                  trailing: Switch(
                    inactiveTrackColor: Colors.transparent,
                    activeColor: AppColor.blackColor,
                    inactiveThumbColor: AppColor.blackColor,
                    value: _isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  onTap: () {
                    // Handle dark mode option tap
                  },
                ),
              ],
            ),
            CustomSettingsSection(
              title: AppString.aboutApp,
              options: [
                CustomSettingsOption(
                  icon: Icons.info,
                  label: AppString.aboutApp,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    // Handle About App tap
                  },
                ),
                CustomSettingsOption(
                  icon: Icons.support_agent,
                  label: AppString.helpAndSupport,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    // Handle help & support option tap
                  },
                ),
                CustomSettingsOption(
                  icon: Icons.description,
                  label: AppString.termsAndConditions,
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    // Handle Terms & Conditions tap
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return DropdownButton<String>(
      value: _selectedLanguage,
      style: TextStyle(color: AppColor.blackColor, fontWeight: FontWeight.bold),
      underline: Container(),
      dropdownColor: Colors.white,
      items: [
        DropdownMenuItem(
          value: 'en',
          child: Text(
            'English',
            style: TextStyle(color: AppColor.blackColor),
          ),
        ),
        DropdownMenuItem(
          value: 'ar',
          child: Text(
            'Arabic',
            style: TextStyle(color: AppColor.blackColor),
          ),
        ),
      ],
      onChanged: (String? newValue) {
        setState(() {
          _selectedLanguage = newValue!;
        });
      },
      icon: const Icon(Icons.arrow_drop_down),
      borderRadius: BorderRadius.circular(8.0),
      elevation: 16,
    );
  }
}

class TitleSection extends StatelessWidget {
  final String text;

  const TitleSection({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 12,
            color: AppColor.greyColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomSettingsSection extends StatelessWidget {
  final String title;
  final List<CustomSettingsOption> options;

  const CustomSettingsSection({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleSection(
          text: title,
        ),
        Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: options.map((option) {
              return ListTile(
                leading: BuildOptionIcon(icon: option.icon),
                title: Text(option.label),
                trailing: option.trailing,
                onTap: option.onTap,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CustomSettingsOption {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;

  CustomSettingsOption({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
  });
}

class BuildOptionIcon extends StatelessWidget {
  final IconData icon;

  const BuildOptionIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Icon(icon);
  }
}
