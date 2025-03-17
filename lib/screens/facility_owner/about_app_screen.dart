import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        elevation: 5,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              shadowColor: Colors.green.withOpacity(0.5),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// **App Logo**
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green.shade100,
                      ),
                      child: Icon(Icons.eco, size: 60, color: Colors.green.shade700),
                    ),
                    SizedBox(height: 15),

                    /// **App Name**
                    Text(
                      "Waste Management App",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green[800]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    /// **Version & Developer Info**
                    InfoRow(icon: Icons.code, text: "Version: 1.0.0"),
                    InfoRow(icon: Icons.business, text: "Developed by: Your Company"),
                    InfoRow(icon: Icons.copyright, text: "© 2025 Your Company"),

                    SizedBox(height: 20),

                    /// **Animated Button**
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      icon: Icon(Icons.public, color: Colors.white),
                      label: Text("Visit Website", style: TextStyle(fontSize: 16, color: Colors.white)),
                      onPressed: () {
                        // Handle website link
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// **Reusable Info Row Widget**
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[700], size: 22),
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
