import 'package:flutter/material.dart';

class ManageDriversPage extends StatefulWidget {
  @override
  _ManageDriversPageState createState() => _ManageDriversPageState();
}

class _ManageDriversPageState extends State<ManageDriversPage> {
  List<Map<String, String>> drivers = [
    {"name": "John Doe", "id": "D001", "phone": "9876543210"},
    {"name": "Alice Smith", "id": "D002", "phone": "8765432109"},
    {"name": "Bob Johnson", "id": "D003", "phone": "7654321098"},
  ];

  /// 🔹 **Show Bottom Sheet for Adding/Editing Driver**
  void _showDriverForm({int? index}) {
    bool isEditing = index != null;
    TextEditingController nameController = TextEditingController(
        text: isEditing ? drivers[index!]["name"] : "");
    TextEditingController phoneController = TextEditingController(
        text: isEditing ? drivers[index]["phone"] : "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEditing ? "Edit Driver" : "Add New Driver",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Driver Name", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number", border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    if (isEditing) {
                      drivers[index!] = {"name": nameController.text, "id": drivers[index]["id"]!, "phone": phoneController.text};
                    } else {
                      drivers.add({
                        "name": nameController.text,
                        "id": "D00${drivers.length + 1}",
                        "phone": phoneController.text
                      });
                    }
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// 🔹 **Delete Driver with Confirmation Dialog**
  void _deleteDriver(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to remove ${drivers[index]["name"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                drivers.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Manage Drivers", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 28),
            onPressed: () => _showDriverForm(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            return _buildDriverCard(index);
          },
        ),
      ),
    );
  }

  /// 🔹 **Driver Card UI**
  Widget _buildDriverCard(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(
          drivers[index]["name"]!,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "ID: ${drivers[index]["id"]} | 📞 ${drivers[index]["phone"]}",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: () => _showDriverForm(index: index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteDriver(index),
            ),
          ],
        ),
      ),
    );
  }
}
