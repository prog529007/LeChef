import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lechef/services/firestore_service.dart';
import 'camera_screen.dart';
import '/models/fridge_item.dart'; // Import the FridgeItem model

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

  final FirestoreService _firestoreService = FirestoreService();

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

  // Update this method to add item to Firestore
  Future<void> _addItemToInventory() async {
    if (_nameController.text.isEmpty || _quantityController.text.isEmpty || _expiryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter product name, expiry date, and quantity')),
      );
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Parse expiry date
        DateTime expiryDate = DateTime.parse(_expiryController.text);

        // Create a new FridgeItem
        FridgeItem item = FridgeItem(
          name: _nameController.text,
          quantity: int.parse(_quantityController.text),
          expiryDate: expiryDate,
        );

        // Add item to Firestore for the logged-in user
        await _firestoreService.addFridgeItem(user.uid, item);

        // Clear the form fields and show success message
        setState(() {
          _imageFile = null;
          _imageBytes = null;
          _nameController.clear();
          _expiryController.clear();
          _quantityController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added to fridge in Firestore')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not authenticated')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add item to Firestore: $e')),
      );
    }
  }

  void _editItemInInventory(int index) async {
    // This part can be skipped or modified to allow Firestore edits if needed
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
                labelText: 'Expiry Date (YYYY-MM-DD)',
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
