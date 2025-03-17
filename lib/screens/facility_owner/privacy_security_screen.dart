import 'package:flutter/material.dart';
import 'dart:ui';


class PrivacySecurityScreen extends StatefulWidget {
  @override
  _PrivacySecurityScreenState createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> with SingleTickerProviderStateMixin {
  bool twoFactorAuth = false;
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _fadeInAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Privacy & Security", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// **Animated Gradient Background**
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.shade900, Colors.green.shade500],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// **Main Content (Fades In)**
          FadeTransition(
            opacity: _fadeInAnimation,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildGlassCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Security Settings",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 16),

                      /// **Change Password Tile**
                      _buildOptionTile(
                        icon: Icons.lock,
                        title: "Change Password",
                        onTap: () => _showChangePasswordDialog(),
                      ),

                      /// **Divider for Better Separation**
                      Divider(color: Colors.white30, thickness: 1, height: 20),

                      /// **Two-Factor Authentication Switch**
                      _buildSwitchTile(
                        title: "Enable Two-Factor Authentication",
                        value: twoFactorAuth,
                        onChanged: (value) => setState(() => twoFactorAuth = value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Glassmorphic Card with Frosted Glass Effect**
  Widget _buildGlassCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12), // Frosted effect
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: child,
    );
  }

  /// **Option Tile for Change Password**
  Widget _buildOptionTile({required IconData icon, required String title, required Function() onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white70),
      onTap: onTap,
    );
  }

  /// **Animated Switch Tile**
  Widget _buildSwitchTile({required String title, required bool value, required Function(bool) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Switch(
              key: ValueKey<bool>(value),
              value: value,
              onChanged: onChanged,
              activeColor: Colors.greenAccent,
              inactiveTrackColor: Colors.white38,
            ),
          ),
        ],
      ),
    );
  }

  /// **Enhanced Change Password Dialog**
  void _showChangePasswordDialog() {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    bool obscureCurrentPassword = true;
    bool obscureNewPassword = true;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Change Password",
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setState) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      /// **Blurry Background**
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(color: Colors.transparent),
                      ),

                      /// **Glassmorphic Card**
                      Container(
                        padding: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            /// **Title with Icon**
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock_reset, color: Colors.white, size: 26),
                                SizedBox(width: 10),
                                Text(
                                  "Change Password",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),

                            /// **Current Password Field**
                            _buildPasswordField(
                              controller: currentPasswordController,
                              hintText: "Current Password",
                              obscureText: obscureCurrentPassword,
                              toggleVisibility: () => setState(() => obscureCurrentPassword = !obscureCurrentPassword),
                            ),

                            SizedBox(height: 12),

                            /// **New Password Field**
                            _buildPasswordField(
                              controller: newPasswordController,
                              hintText: "New Password",
                              obscureText: obscureNewPassword,
                              toggleVisibility: () => setState(() => obscureNewPassword = !obscureNewPassword),
                            ),

                            SizedBox(height: 20),

                            /// **Buttons with Hover Effect**
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildDialogButton(
                                  text: "Cancel",
                                  color: Colors.redAccent,
                                  onTap: () => Navigator.pop(context),
                                ),
                                _buildDialogButton(
                                  text: "Save",
                                  color: Colors.green,
                                  onTap: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Password Updated"), backgroundColor: Colors.green),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// **Password Input Field**
  Widget _buildPasswordField({required TextEditingController controller, required String hintText, required bool obscureText, required VoidCallback toggleVisibility}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }

  /// **Dialog Button with Hover Effect**
  Widget _buildDialogButton({required String text, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 8)],
          ),
          child: Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
