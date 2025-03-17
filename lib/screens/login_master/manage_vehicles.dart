import 'package:flutter/material.dart';

class ManageVehiclesPage extends StatefulWidget {
  @override
  _ManageVehiclesPageState createState() => _ManageVehiclesPageState();
}

class _ManageVehiclesPageState extends State<ManageVehiclesPage> {
  List<Map<String, String>> vehicles = [
    {"id": "V001", "type": "Truck", "driver": "John Doe", "status": "Assigned"},
    {"id": "V002", "type": "Van", "driver": "Unassigned", "status": "Free"},
  ];

  /// 🔹 **Show Bottom Sheet for Adding/Editing Vehicle**
  void _showVehicleForm({int? index}) {
    bool isEditing = index != null;
    TextEditingController typeController = TextEditingController(
        text: isEditing ? vehicles[index!]["type"] : "");
    TextEditingController driverController = TextEditingController(
        text: isEditing ? vehicles[index]["driver"] : "Unassigned");
    String status = isEditing ? vehicles[index]["status"]! : "Available";

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
                isEditing ? "Edit Vehicle" : "Add New Vehicle",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              TextField(
                controller: typeController,
                decoration: InputDecoration(labelText: "Vehicle Type", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              TextField(
                controller: driverController,
                decoration: InputDecoration(labelText: "Assigned Driver", border: OutlineInputBorder()),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: status,
                decoration: InputDecoration(labelText: "Status", border: OutlineInputBorder()),
                items: ["Available", "Assigned", "Under Maintenance"]
                    .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) {
                  status = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Icon(Icons.save),
                label: Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    if (isEditing) {
                      vehicles[index!] = {
                        "id": vehicles[index]["id"]!,
                        "type": typeController.text,
                        "driver": driverController.text,
                        "status": status,
                      };
                    } else {
                      vehicles.add({
                        "id": "V00${vehicles.length + 1}",
                        "type": typeController.text,
                        "driver": driverController.text,
                        "status": status,
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

  /// 🔹 **Delete Vehicle with Confirmation Dialog**
  void _deleteVehicle(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to remove ${vehicles[index]["id"]}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                vehicles.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// 🔹 **Status Color Indicator**
  Color _getStatusColor(String status) {
    switch (status) {
      case "Available":
        return Colors.green;
      case "Assigned":
        return Colors.orange;
      case "Under Maintenance":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Manage Vehicles", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 28),
            onPressed: () => _showVehicleForm(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add, size: 30),
        onPressed: () => _showVehicleForm(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            return _buildVehicleCard(index);
          },
        ),
      ),
    );
  }

  /// 🔹 **Vehicle Card UI**
  Widget _buildVehicleCard(int index) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        leading: CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(Icons.local_shipping, color: Colors.white),
        ),
        title: Text(
          "${vehicles[index]["id"]} - ${vehicles[index]["type"]}",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Driver: ${vehicles[index]["driver"]}", style: TextStyle(fontSize: 14)),
            SizedBox(height: 4),
            Row(
              children: [
                Text("Status: ", style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                    color: _getStatusColor(vehicles[index]["status"]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    vehicles[index]["status"]!,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.orange),
              onPressed: () => _showVehicleForm(index: index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteVehicle(index),
            ),
          ],
        ),
      ),
    );
  }
}

