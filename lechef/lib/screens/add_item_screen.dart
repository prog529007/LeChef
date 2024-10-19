import 'package:flutter/material.dart';

class AddItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Scan a product to add it to your inventory.',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Placeholder for scan functionality
              },
              child: Text('Scan Barcode'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddItemScreen extends StatefulWidget {
//   @override
//   _AddItemScreenState createState() => _AddItemScreenState();
// }

// class _AddItemScreenState extends State<AddItemScreen> {
//   final ImagePicker _picker = ImagePicker();
//   File? _imageFile;

//   Future<void> _scanBarcode() async {
//     // Check if camera is available
//     final cameras = await availableCameras();
//     if (cameras.isEmpty) {
//       _showNoCameraDialog();
//       return;
//     }

//     // Pick an image using the camera
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });

//       // Process the barcode image (to be implemented)
//       _processBarcodeImage(_imageFile!);
//     }
//   }

//   void _processBarcodeImage(File imageFile) {
//     // Placeholder for barcode processing logic
//     // Use an OCR or barcode scanning package to extract the barcode
//   }

//   void _showNoCameraDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('No Camera Available'),
//           content: Text('Your device does not have a camera or camera access is disabled.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Product'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Scan a product to add it to your inventory.',
//               style: TextStyle(fontSize: 16, color: Colors.white70),
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _scanBarcode,
//               child: Text('Scan Barcode'),
//             ),
//             SizedBox(height: 24),
//             if (_imageFile != null) ...[
//               Text('Scanned Image:', style: TextStyle(fontSize: 16)),
//               SizedBox(height: 8),
//               Image.file(_imageFile!),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
