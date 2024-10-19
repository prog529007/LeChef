import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: 10, // Placeholder for the number of items
        itemBuilder: (context, index) {
          return _buildInventoryItem(context, index);
        },
      ),
    );
  }

  Widget _buildInventoryItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.fastfood, color: Colors.tealAccent),
        title: Text('Product Name $index', style: TextStyle(color: Colors.white)),
        subtitle: Text('Expires in: 5 days', style: TextStyle(color: Colors.grey)),
        trailing: Icon(Icons.chevron_right, color: Colors.tealAccent),
        onTap: () {
          // Navigate to product details screen (to be implemented)
        },
      ),
    );
  }
}
