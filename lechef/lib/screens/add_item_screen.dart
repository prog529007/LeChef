// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
// import 'camera_screen.dart';
// import 'inventory_list.dart';

// class AddItemScreen extends StatefulWidget {
//   @override
//   _AddItemScreenState createState() => _AddItemScreenState();
// }

// class _AddItemScreenState extends State<AddItemScreen> {
//   File? _imageFile;
//   Uint8List? _imageBytes;
//   TextEditingController _nameController = TextEditingController();
//   TextEditingController _expiryController = TextEditingController();

//   List<Map<String, dynamic>> inventory = [];

//   Future<void> _scanBarcode() async {
//     final imagePath = await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => CameraScreen()),
//     );

//     if (imagePath != null) {
//       if (kIsWeb) {
//         _imageBytes = await File(imagePath).readAsBytes();
//       } else {
//         _imageFile = File(imagePath);
//       }

//       setState(() {});
//     }
//   }

//   void _addItemToInventory() {
//     if (_nameController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a product name')),
//       );
//       return;
//     }

//     inventory.add({
//       'image': kIsWeb ? _imageBytes : _imageFile,
//       'name': _nameController.text,
//       'expiry': _expiryController.text,
//     });

//     setState(() {
//       _imageFile = null;
//       _imageBytes = null;
//       _nameController.clear();
//       _expiryController.clear();
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Product added to inventory')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add New Product'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             ElevatedButton(
//               onPressed: _scanBarcode,
//               child: Text('Scan Barcode'),
//             ),
//             SizedBox(height: 16),
//             if (_imageFile != null || _imageBytes != null)
//               Container(
//                 height: 200,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.tealAccent),
//                 ),
//                 child: kIsWeb
//                     ? Image.memory(_imageBytes!, fit: BoxFit.cover)
//                     : Image.file(_imageFile!, fit: BoxFit.cover),
//               ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(
//                 labelText: 'Product Name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: _expiryController,
//               decoration: InputDecoration(
//                 labelText: 'Expiry Date',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _addItemToInventory,
//               child: Text('Add to Inventory'),
//             ),
//             SizedBox(height: 24),
//             Text('Inventory:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: inventory.length,
//               itemBuilder: (context, index) {
//                 final item = inventory[index];
//                 return ListTile(
//                   leading: kIsWeb
//                       ? (item['image'] != null
//                           ? Image.memory(item['image'], width: 50, height: 50)
//                           : Container(width: 50, height: 50))
//                       : (item['image'] != null
//                           ? Image.file(item['image'], width: 50, height: 50)
//                           : Container(width: 50, height: 50)),
//                   title: Text(item['name']),
//                   subtitle: Text('Expires: ${item['expiry']}'),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _expiryController.dispose();
//     super.dispose();
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'camera_screen.dart';
import 'inventory_list.dart';
import 'edit_item_screen.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  File? _imageFile;
  Uint8List? _imageBytes;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _expiryController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();

  List<Map<String, dynamic>> inventory = [];

  Future<void> _scanBarcode() async {
    final imagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraScreen()),
    );

    if (imagePath != null) {
      if (kIsWeb) {
        _imageBytes = await File(imagePath).readAsBytes();
      } else {
        _imageFile = File(imagePath);
      }

      setState(() {});
    }
  }

  void _addItemToInventory() {
    if (_nameController.text.isEmpty || _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a product name and quantity')),
      );
      return;
    }

    inventory.add({
      'image': kIsWeb ? _imageBytes : _imageFile,
      'name': _nameController.text,
      'expiry': _expiryController.text,
      'quantity': int.parse(_quantityController.text),
    });

    setState(() {
      _imageFile = null;
      _imageBytes = null;
      _nameController.clear();
      _expiryController.clear();
      _quantityController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product added to inventory')),
    );
  }

  void _editItemInInventory(int index) async {
    final editedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemScreen(
          item: inventory[index],
        ),
      ),
    );

    if (editedItem != null) {
      setState(() {
        inventory[index] = editedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Scan Barcode'),
            ),
            SizedBox(height: 16),
            if (_imageFile != null || _imageBytes != null)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.tealAccent),
                ),
                child: kIsWeb
                    ? Image.memory(_imageBytes!, fit: BoxFit.cover)
                    : Image.file(_imageFile!, fit: BoxFit.cover),
              ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _expiryController,
              decoration: InputDecoration(
                labelText: 'Expiry Date',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _addItemToInventory,
              child: Text('Add to Inventory'),
            ),
            SizedBox(height: 24),
            Text('Inventory:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                final item = inventory[index];
                return ListTile(
                  leading: kIsWeb
                      ? (item['image'] != null
                          ? Image.memory(item['image'], width: 50, height: 50)
                          : Container(width: 50, height: 50))
                      : (item['image'] != null
                          ? Image.file(item['image'], width: 50, height: 50)
                          : Container(width: 50, height: 50)),
                  title: Text(item['name']),
                  subtitle: Text('Expires: ${item['expiry']}\nQuantity: ${item['quantity']}'),
                  onTap: () => _editItemInInventory(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _expiryController.dispose();
    _quantityController.dispose();
    super.dispose();
  }
}
