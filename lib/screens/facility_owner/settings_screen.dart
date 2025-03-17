import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Profile Page
import 'bank_account_screen.dart'; // Bank Account Page
import 'notification_preferences_screen.dart'; // Notification Preferences Page
import 'privacy_security_screen.dart'; // Privacy & Security Page
import 'language_region_screen.dart'; // Language & Region Page
import 'help_support_screen.dart'; // Help & Support Page
import 'about_app_screen.dart'; // About App Page
import 'package:waste_management/screens/login_signup.dart'; // Login Page

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: SafeArea(
        child: Column(
          children: [
            _buildTitleSection(context), // Title section with back button
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildSettingsTile(
                    icon: Icons.person,
                    title: "Profile",
                    subtitle: "Manage your profile details",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    },
                  ),
                  _buildDivider(),

                  _buildSettingsTile(
                    icon: Icons.account_balance_wallet,
                    title: "Bank Accounts",
                    subtitle: "Manage payment methods",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BankAccountScreen()));
                    },
                  ),
                  _buildDivider(),

                  _buildSettingsTile(
                    icon: Icons.notifications,
                    title: "Notification Preferences",
                    subtitle: "Customize your notifications",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPreferencesScreen()));
                    },
                  ),
                  _buildDivider(),

                  _buildSettingsTile(
                    icon: Icons.security,
                    title: "Privacy & Security",
                    subtitle: "Manage security settings",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacySecurityScreen()));
                    },
                  ),
                  _buildDivider(),

                  _buildSettingsTile(
                    icon: Icons.language,
                    title: "Language & Region",
                    subtitle: "Change language and location settings",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageRegionScreen()));
                    },
                  ),
                  _buildDivider(),

                  _buildSettingsTile(
                    icon: Icons.help_outline,
                    title: "Help & Support",
                    subtitle: "FAQs and customer support",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HelpSupportScreen()));
                    },
                  ),
                  _buildDivider(),

                  _buildSettingsTile(
                    icon: Icons.info,
                    title: "About App",
                    subtitle: "Version info and developer details",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AboutAppScreen()));
                    },
                  ),
                  _buildDivider(),

                  /// **Logout Button (With Confirmation Dialog)**
                  ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.red),
                    title: Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Title Section (With Back Button)**
  Widget _buildTitleSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 10),
          Text(
            "Settings",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// **Reusable Settings Tile**
  Widget _buildSettingsTile({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  /// **Reusable Divider**
  Widget _buildDivider() {
    return Divider(thickness: 1, color: Colors.grey[300]);
  }

  /// **Logout Confirmation Dialog**
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout Confirmation"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                _logout(context); // Logout action
              },
              child: Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  /// **Logout Function (Redirect to Login Page)**
  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false, // Remove all previous routes
    );
  }
}
