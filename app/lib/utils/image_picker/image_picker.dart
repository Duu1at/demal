// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePickerUtil {
//   static Future<String?> pickImage(BuildContext context) async {
//     final picker = ImagePicker();

//     return showModalBottomSheet<String>(
//       context: context,
//       builder: (_) => SafeArea(
//         child: Wrap(
//           children: [
//             ListTile(
//               leading: const Icon(Icons.photo_camera),
//               title: const Text('Take photo'),
//               onTap: () async {
//                 final img = await picker.pickImage(source: ImageSource.camera);
//                 Navigator.pop(context, img?.path);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.photo_library),
//               title: const Text('Choose from gallery'),
//               onTap: () async {
//                 final img =
//                     await picker.pickImage(source: ImageSource.gallery);
//                 Navigator.pop(context, img?.path);
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.delete),
//               title: const Text('Remove photo'),
//               onTap: () => Navigator.pop(context, 'delete'),
//             ),
//           ],
//         ),
//       ),
//     ).then((result) {
//       if (result == 'delete') return null;
//       return result;
//     });
//   }
// }
