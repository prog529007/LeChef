import 'package:flutter/material.dart';
import 'add_item_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeChef'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildOptionCard(
                    context,
                    icon: Icons.qr_code_scanner,
                    title: 'Scan Product',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddItemScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _buildOptionCard(
                    context,
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      // Navigate to settings screen (to be implemented)
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: 10, // Placeholder for the number of items
                itemBuilder: (context, index) {
                  return _buildInventoryItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1F1F1F),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showVoiceAgentDialog(context);
        },
        backgroundColor: Colors.tealAccent,
        child: Icon(Icons.mic, color: Colors.black),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.tealAccent),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the voice agent screen
  void _showVoiceAgentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                // Large Mic Button
                IconButton(
                  icon: Icon(Icons.mic, size: 80, color: Colors.tealAccent),
                  onPressed: () {
                    // Trigger voice AI logic (to be implemented)
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Listening...',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 40),
                // Transcript Area at the bottom
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        'Transcript will appear here...',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
