// import 'package:flutter/material.dart';

// class InventoryScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> inventory;

//   InventoryScreen({required this.inventory});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Inventory'),
//       ),
//       body: inventory.isNotEmpty
//           ? ListView.builder(
//               padding: EdgeInsets.all(16.0),
//               itemCount: inventory.length,
//               itemBuilder: (context, index) {
//                 return _buildInventoryItem(context, inventory[index], index);
//               },
//             )
//           : Center(
//               child: Text('No items in inventory'),
//             ),
//     );
//   }

//   Widget _buildInventoryItem(BuildContext context, Map<String, dynamic> item, int index) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Color(0xFF1E1E1E),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         leading: item['image'] != null
//             ? Image.file(item['image'], width: 50, height: 50)
//             : Icon(Icons.fastfood, color: Colors.tealAccent),
//         title: Text(item['name'], style: TextStyle(color: Colors.white)),
//         subtitle: Text('Expires: ${item['expiry']}\nQuantity: ${item['quantity']}',
//             style: TextStyle(color: Colors.grey)),
//         trailing: Icon(Icons.chevron_right, color: Colors.tealAccent),
//         onTap: () {
//           // Handle navigation for editing item
//         },
//       ),
//     );
//   }
// }

import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Map<String, dynamic>> inventory = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  File? _imageFile;
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddItemDialog(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: inventory.length,
        itemBuilder: (context, index) {
          return _buildInventoryItem(index);
        },
      ),
    );
  }

  Widget _buildInventoryItem(int index) {
    final item = inventory[index];
    return ListTile(
      leading: _buildItemImage(item['image']),
      title: Text(item['name']),
      subtitle: Text('Expires: ${item['expiry']}\nQuantity: ${item['quantity']}'),
      onTap: () => _editItemQuantity(index),
    );
  }

  Widget _buildItemImage(dynamic image) {
    if (image == null) {
      return Icon(Icons.fastfood, color: Colors.tealAccent);
    }

    if (image is Uint8List) {
      // Display image from memory for web
      return Image.memory(image, width: 50, height: 50);
    } else if (image is File) {
      // Display image from file for mobile
      return Image.file(image, width: 50, height: 50);
    } else {
      // Fallback in case of an unknown type
      return Icon(Icons.image_not_supported);
    }
  }

  Future<void> _showAddItemDialog(BuildContext context) async {
    _nameController.clear();
    _expiryController.clear();
    _quantityController.clear();
    _imageFile = null;
    _imageBytes = null;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Inventory Item'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _expiryController,
                  decoration: InputDecoration(labelText: 'Expiry Date'),
                ),
                TextField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Pick Image'),
                ),
                _displayPickedImage(),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: _addItemToInventory,
            ),
          ],
        );
      },
    );
  }

  Widget _displayPickedImage() {
    if (_imageBytes != null) {
      return Image.memory(_imageBytes!, width: 100, height: 100);
    } else if (_imageFile != null) {
      return Image.file(_imageFile!, width: 100, height: 100);
    } else {
      return SizedBox.shrink();
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    if (kIsWeb) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageBytes = bytes;
          _imageFile = null; // Not needed for web
        });
      }
    } else {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _imageBytes = null; // Not needed for mobile
        });
      }
    }
  }

  void _addItemToInventory() {
    final name = _nameController.text;
    final expiry = _expiryController.text;
    final quantity = int.tryParse(_quantityController.text) ?? 0;

    if (name.isEmpty || expiry.isEmpty || quantity <= 0) {
      // Validation check
      return;
    }

    setState(() {
      inventory.add({
        'image': kIsWeb ? _imageBytes : _imageFile,
        'name': name,
        'expiry': expiry,
        'quantity': quantity,
      });
    });

    Navigator.of(context).pop(); // Close the dialog
  }

  void _editItemQuantity(int index) {
    final item = inventory[index];
    final quantityController = TextEditingController(text: item['quantity'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Quantity'),
          content: TextField(
            controller: quantityController,
            decoration: InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                setState(() {
                  item['quantity'] = int.tryParse(quantityController.text) ?? item['quantity'];
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
