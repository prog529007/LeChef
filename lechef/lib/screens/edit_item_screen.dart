import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItemScreen extends StatefulWidget {
  final String itemId;
  final String userId;

  EditItemScreen({required this.itemId, required this.userId});

  @override
  _EditItemScreenState createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  final _nameController = TextEditingController();
  final _expiryController = TextEditingController();
  final _quantityController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchItemData();
  }

  // Fetch item data from Firestore
  Future<void> _fetchItemData() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('fridge')
        .doc(widget.itemId)
        .get();

    if (doc.exists) {
      final itemData = doc.data() as Map<String, dynamic>;
      setState(() {
        _nameController.text = itemData['name'];
        _expiryController.text = itemData['expiryDate'];
        _quantityController.text = itemData['quantity'].toString();
        _isLoading = false;
      });
    }
  }

  // Update the item in Firestore
  Future<void> _updateItem() async {
    if (_nameController.text.isEmpty || _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }
    try {
      DateTime expiryDate = DateTime.parse(_expiryController.text);
      final updatedData = {
        'name': _nameController.text,
        'expiryDate': expiryDate.toIso8601String(),
        'quantity': int.parse(_quantityController.text),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('fridge')
          .doc(widget.itemId)
          .update(updatedData);

      Navigator.pop(context); // Return to the previous screen after updating
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
      return;
    }
  }

  // Delete the item from Firestore
  Future<void> _deleteItem() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('fridge')
        .doc(widget.itemId)
        .delete();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item deleted')),
    );

    Navigator.pop(context); // Return to the previous screen after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Item'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteItem, // Delete the item
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show a loading indicator while fetching data
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                    onPressed: _updateItem, // Update the item
                    child: Text('Update Item'),
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