import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userType;
  const UserDetailsScreen({super.key, required this.userType});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  List<Map<String, String>> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    if (widget.userType == "drivers") {
      users = [
        {"name": "John Doe", "id": "D001", "phone": "9876543210", "email": "john@example.com", "vehicle": "Truck"},
        {"name": "Alice Smith", "id": "D002", "phone": "8765432109", "email": "alice@example.com", "vehicle": "Van"},
      ];
    } else if (widget.userType == "owners") {
      users = [
        {"name": "Robert Brown", "id": "F001", "phone": "9876543201", "email": "robert@example.com", "facility": "Hotel ABC"},
      ];
    } else if (widget.userType == "masters") {
      users = [
        {"name": "Emma Wilson", "id": "L001", "phone": "9876543202", "email": "emma@example.com"},
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("${widget.userType.toUpperCase()} List"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: users.isEmpty
                  ? const Center(
                child: Text("No users found", style: TextStyle(fontSize: 16, color: Colors.grey)),
              )
                  : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return _userCard(users[index]);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUserDialog(context, isEdit: false),
        icon: const Icon(Icons.add),
        label: Text("Add ${widget.userType}"),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _userCard(Map<String, String> user) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    user["name"] ?? "Unknown",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(),
            _userDetailRow(Icons.badge, "ID", user["id"]),
            _userDetailRow(Icons.phone, "Phone", user["phone"]),
            _userDetailRow(Icons.email, "Email", user["email"]),
            if (user.containsKey("vehicle")) _userDetailRow(Icons.local_shipping, "Vehicle", user["vehicle"]),
            if (user.containsKey("facility")) _userDetailRow(Icons.business, "Facility", user["facility"]),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _actionButton(Icons.edit, "Edit", Colors.blue, () => _showUserDialog(context, isEdit: true, user: user)),
                _actionButton(Icons.delete, "Delete", Colors.red, () => _deleteUser(user)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _userDetailRow(IconData icon, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value ?? "N/A", overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }

  void _showUserDialog(BuildContext context, {bool isEdit = false, Map<String, String>? user}) {
    TextEditingController nameController = TextEditingController(text: isEdit && user != null ? user["name"] : "");
    TextEditingController idController = TextEditingController(text: isEdit && user != null ? user["id"] : "");
    TextEditingController phoneController = TextEditingController(text: isEdit && user != null ? user["phone"] : "");
    TextEditingController emailController = TextEditingController(text: isEdit && user != null ? user["email"] : "");
    TextEditingController extraController = TextEditingController(
      text: isEdit && user != null
          ? (widget.userType == "drivers" ? user["vehicle"] ?? "" : widget.userType == "owners" ? user["facility"] ?? "" : "")
          : "",
    );

    String extraLabel = widget.userType == "drivers" ? "Vehicle Type" : widget.userType == "owners" ? "Facility Name" : "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(isEdit ? "Edit ${widget.userType}" : "Add ${widget.userType}"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(nameController, "Name"),
                _buildTextField(idController, "ID"),
                _buildTextField(phoneController, "Phone"),
                _buildTextField(emailController, "Email"),
                if (extraLabel.isNotEmpty) _buildTextField(extraController, extraLabel),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                setState(() {
                  if (!isEdit) {
                    users.add({
                      "name": nameController.text,
                      "id": idController.text,
                      "phone": phoneController.text,
                      "email": emailController.text,
                      if (widget.userType == "drivers") "vehicle": extraController.text,
                      if (widget.userType == "owners") "facility": extraController.text,
                    });
                  } else if (isEdit && user != null) {
                    user["name"] = nameController.text;
                    user["id"] = idController.text;
                    user["phone"] = phoneController.text;
                    user["email"] = emailController.text;
                    if (widget.userType == "drivers") {
                      user["vehicle"] = extraController.text;
                    }
                    if (widget.userType == "owners") {
                      user["facility"] = extraController.text;
                    }
                  }
                });
                Navigator.pop(context);
              },
              child: Text(isEdit ? "Save" : "Add"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }

  void _deleteUser(Map<String, String> user) {
    setState(() {
      users.remove(user);
    });
  }
}
