import 'dart:ui';
import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Help & Support", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          /// **Gradient Background**
          Positioned.fill(
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade900, Colors.green.shade500],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),

          /// **Blurred Overlay**
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(color: Colors.black.withOpacity(0.2)),
            ),
          ),

          /// **Main Content with Proper Spacing**
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16), // **Added spacing below App Bar**

                  /// **Header Section**
                  FadeInWidget(
                    delay: 300,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Need Help?",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Find answers to your questions or contact our support team.",
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 24),

                  /// **Support Options List**
                  Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        FadeInWidget(
                          delay: 500,
                          child: _buildGlassCard(
                            icon: Icons.help_outline,
                            title: "FAQs",
                            subtitle: "Find answers to common questions",
                            onTap: () {
                              // Show FAQ logic
                            },
                          ),
                        ),
                        SizedBox(height: 16),

                        FadeInWidget(
                          delay: 700,
                          child: _buildGlassCard(
                            icon: Icons.contact_support,
                            title: "Contact Support",
                            subtitle: "Email: support@example.com",
                            onTap: () {
                              // Email support logic
                            },
                          ),
                        ),
                        SizedBox(height: 16),

                        FadeInWidget(
                          delay: 900,
                          child: _buildGlassCard(
                            icon: Icons.chat_bubble_outline,
                            title: "Live Chat",
                            subtitle: "Get instant help from our support team",
                            onTap: () {
                              // Live Chat logic
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      /// **Stylish Floating Action Button**
      floatingActionButton: FadeInWidget(
        delay: 1200,
        child: FloatingActionButton.extended(
          backgroundColor: Colors.green[800],
          icon: Icon(Icons.support_agent, color: Colors.white),
          label: Text("Chat Now", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onPressed: () {
            // Live Chat Support logic
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  /// **Reusable Glassmorphic Card**
  Widget _buildGlassCard({required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 12)],
          border: Border.all(color: Colors.white.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }
}

/// **Smooth Fade-in Animation Widget**
class FadeInWidget extends StatelessWidget {
  final Widget child;
  final int delay;

  FadeInWidget({required this.child, required this.delay});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: delay),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double opacity, _) {
        return Opacity(opacity: opacity, child: child);
      },
    );
  }
}
