// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:wm_app/utils/components/text_button.dart';
//
// class DeleteCategoryPage extends StatefulWidget {
//   const DeleteCategoryPage({Key? key}) : super(key: key);
//
//   @override
//   _DeleteCategoryPageState createState() => _DeleteCategoryPageState();
// }
//
// class _DeleteCategoryPageState extends State<DeleteCategoryPage> {
//   String? _selectedCategory;
//
//   final List<String> _categories = [
//     'Category 1',
//     'Category 2',
//     'Category 3',
//     'Category 4',
//     'Category 5',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Delete Category'),
//         backgroundColor: Colors.blue, // Adjust as needed
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             DropdownButtonFormField<String>(
//               value: _selectedCategory,
//               onChanged: (newValue) {
//                 setState(() {
//                   _selectedCategory = newValue;
//                 });
//               },
//               items: _categories.map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               decoration: const InputDecoration(
//                 labelText: 'Select Category',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             MyButton(
//               onTap: () {
//                 _showDeleteConfirmationDialog();
//               },
//               child: const Text('Delete'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _showDeleteConfirmationDialog() async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Delete Category?'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Are you sure you want to delete $_selectedCategory?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Delete'),
//               onPressed: () {
//                 // Perform delete operation here
//                 // Example:
//                 // _deleteCategory(_selectedCategory);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
// // You can implement the delete logic here
// // void _deleteCategory(String? category) {
// //   // Implement delete logic
// // }
// }