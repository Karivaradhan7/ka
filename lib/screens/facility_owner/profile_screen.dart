import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "John Doe";
  String userId = "WMS12345";
  String phone = "+91 9876543210";
  String email = "johndoe@example.com";
  String earnings = "₹25,000";
  String upiId = "johndoe@upi";
  String accountNumber = "123456789012";
  String ifscCode = "SBIN0001234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// **Profile Header Section**
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green[700]!, Colors.green[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
              ),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              child: Column(
                children: [
                  /// **Profile Picture with Dummy Image**
                  CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/profile_placeholder.png"),
                  ),
                  SizedBox(height: 10),
                  Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text("User ID: $userId", style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// **User Information Card**
            _buildProfileCard(
              title: "User Information",
              children: [
                _buildInfoRow(Icons.phone, "Phone", phone, editable: true, fieldType: "phone"),
                _buildInfoRow(Icons.email, "Email", email, editable: true, fieldType: "email"),
              ],
            ),

            SizedBox(height: 16),

            /// **Earnings Section**
            _buildProfileCard(
              title: "Earnings",
              children: [
                _buildInfoRow(Icons.monetization_on, "Total Earnings", earnings),
              ],
            ),

            SizedBox(height: 16),

            /// **Bank Details Section**
            _buildProfileCard(
              title: "Bank Details",
              children: [
                _buildInfoRow(Icons.payment, "UPI ID", upiId),
                _buildInfoRow(Icons.account_balance, "Account Number", accountNumber),
                _buildInfoRow(Icons.confirmation_number, "IFSC Code", ifscCode),
                _buildQrCodeSection(),
              ],
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// **Reusable Profile Card**
  Widget _buildProfileCard({required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 6,
      shadowColor: Colors.green.withOpacity(0.3),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: Offset(3, 3)),
          ],
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[700])),
            SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }

  /// **Reusable Info Row**
  Widget _buildInfoRow(IconData icon, String title, String value, {bool editable = false, String fieldType = ""}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 10),
          Expanded(child: Text("$title: ", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value, style: TextStyle(color: Colors.grey[700]))),
          if (editable)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.green),
              onPressed: () => _showEditDialog(title, value, fieldType),
            ),
        ],
      ),
    );
  }

  /// **QR Code Section**
  Widget _buildQrCodeSection() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Column(
          children: [
            Text("Scan to Pay", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.green.withOpacity(0.2), blurRadius: 8, offset: Offset(2, 2)),
                ],
              ),
              child: QrImageView(
                data: upiId,
                version: QrVersions.auto,
                size: 120,
                foregroundColor: Colors.green[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// **Show Dialog to Edit Fields**
  void _showEditDialog(String title, String currentValue, String fieldType) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $title"),
          content: TextField(
            controller: controller,
            keyboardType: fieldType == "phone" ? TextInputType.phone : TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Enter new $title",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
            TextButton(
              onPressed: () {
                setState(() {
                  if (fieldType == "phone") phone = controller.text;
                  else if (fieldType == "email") email = controller.text;
                });
                Navigator.pop(context);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }
}
