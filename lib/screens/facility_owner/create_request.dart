import 'package:flutter/material.dart';
import 'dart:ui';

class CreateRequestScreen extends StatefulWidget {
  @override
  _CreateRequestScreenState createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController solidWasteController = TextEditingController();
  final TextEditingController liquidWasteController = TextEditingController();
  String? selectedTimeSlot;

  final List<String> timeSlots = [
    "Morning (8AM-12PM)",
    "Afternoon (12PM-4PM)",
    "Evening (4PM-8PM)"
  ];

  void _submitRequest() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Request Submitted Successfully! 🎉"),
          backgroundColor: Colors.green[700],
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[100]!, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// Page Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Back Button & Page Title (Same as Request History)**
              Padding(
                padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                child: Row(
                  children: [
                    /// Back Button
                    IconButton(
                      icon: Icon(Icons.arrow_back, size: 28, color: Colors.green[900]),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    /// Page Title
                    Text(
                      "Create Request",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[900],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              /// **Glassmorphic Form Card**
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// **Title**
                              Text(
                                "Enter Waste Details",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[900],
                                ),
                              ),
                              SizedBox(height: 15),

                              /// **Solid Waste Input**
                              _buildInputField(
                                controller: solidWasteController,
                                label: "Solid Waste (kg)",
                                icon: Icons.delete,
                                color: Colors.red,
                              ),
                              SizedBox(height: 15),

                              /// **Liquid Waste Input**
                              _buildInputField(
                                controller: liquidWasteController,
                                label: "Liquid Waste (liters)",
                                icon: Icons.water_drop,
                                color: Colors.blue,
                              ),
                              SizedBox(height: 15),

                              /// **Time Slot Dropdown**
                              DropdownButtonFormField<String>(
                                value: selectedTimeSlot,
                                decoration: InputDecoration(
                                  labelText: "Pickup Time Slot",
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Icon(Icons.timer, color: Colors.orange),
                                ),
                                items: timeSlots.map((slot) {
                                  return DropdownMenuItem(
                                    value: slot,
                                    child: Text(slot, style: TextStyle(fontWeight: FontWeight.bold)),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedTimeSlot = value;
                                  });
                                },
                                validator: (value) => value == null ? "Select a time slot" : null,
                              ),
                              SizedBox(height: 25),

                              /// **Submit Button**
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _submitRequest,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 8,
                                    backgroundColor: Colors.green[700],
                                  ),
                                  child: Text(
                                    "Submit Request",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// **Reusable Input Field**
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(icon, color: color),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter $label";
        }
        if (int.tryParse(value) == null || int.parse(value) <= 0) {
          return "Enter a valid quantity";
        }
        return null;
      },
    );
  }
}
