import 'package:flutter/material.dart';

class BankAccountScreen extends StatefulWidget {
  @override
  _BankAccountScreenState createState() => _BankAccountScreenState();
}

class _BankAccountScreenState extends State<BankAccountScreen> {
  // Sample Bank Details
  String accountHolderName = "John Doe";
  String upiId = "johndoe@upi";
  String accountNumber = "123456789012";
  String ifscCode = "SBIN0001234";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Bank Account", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          /// **Gradient Animated Background**
          AnimatedContainer(
            duration: Duration(seconds: 2),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// **Content**
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bank Account Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    Divider(color: Colors.blue.shade300, thickness: 1),
                    SizedBox(height: 10),

                    /// **Bank Details Rows**
                    _buildInfoRow(Icons.person, "Account Holder", accountHolderName),
                    _buildEditableRow(Icons.payment, "UPI ID", upiId, "upi"),
                    _buildEditableRow(Icons.account_balance, "Account Number", accountNumber, "account"),
                    _buildEditableRow(Icons.confirmation_number, "IFSC Code", ifscCode, "ifsc"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Glassmorphic Card**
  Widget GlassCard({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, spreadRadius: 3),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: child,
    );
  }

  /// **Reusable Info Row**
  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[900], size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// **Reusable Editable Row**
  Widget _buildEditableRow(IconData icon, String title, String value, String fieldType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue[900], size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showBottomSheet(title, value, fieldType);
            },
            child: Icon(Icons.edit, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  /// **Bottom Sheet for Editing**
  void _showBottomSheet(String title, String currentValue, String fieldType) {
    TextEditingController controller = TextEditingController(text: currentValue);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Edit $title",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[800]),
              ),
              SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: fieldType == "account" ? TextInputType.number : TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Enter new $title",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: Icon(Icons.edit, color: Colors.blue[800]),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      setState(() {
                        if (fieldType == "upi") {
                          upiId = controller.text;
                        } else if (fieldType == "account") {
                          accountNumber = controller.text;
                        } else if (fieldType == "ifsc") {
                          ifscCode = controller.text;
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
