// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// import '../../../utils/components/text_button.dart';
//
// class CreateCategoryPage extends StatefulWidget {
//   const CreateCategoryPage({super.key});
//
//   @override
//   CreateCategoryPageState createState() => CreateCategoryPageState();
// }
//
// class CreateCategoryPageState extends State<CreateCategoryPage> {
//   final TextEditingController _categoryController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF001d3d),
//       appBar: AppBar(
//         title: const Text('Create Category'),
//         backgroundColor: const Color(0xFF003566),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _categoryController,
//               style: const TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 labelText: 'Category Name',
//                 labelStyle: const TextStyle(color: Colors.white),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             MyButton(
//               onTap: () {
//                 // Implement category creation logic here
//                 if (kDebugMode) {
//                   print('Creating category: ${_categoryController.text}');
//                 }
//               },
//               text: 'Create Category',
//               buttonColor: const Color(0xFFffc300),
//               textColor: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }