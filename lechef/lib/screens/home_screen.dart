import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String transcript = 'Transcript will appear here...';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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
                    icon: Icons.add,
                    title: 'Add Product',
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
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('users')
                    .doc(_auth.currentUser!.uid)
                    .collection('fridge')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    final fridgeItems = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: fridgeItems.length,
                      itemBuilder: (context, index) {
                        final itemData = fridgeItems[index].data() as Map<String, dynamic>;

                        // Parse the expiry date from the Firestore data
                        DateTime expiryDate = DateTime.parse(itemData['expiryDate']);

                        // Calculate the difference between now and the expiry date
                        Duration difference = expiryDate.difference(DateTime.now());
                        int daysUntilExpiry = difference.inDays;

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.fastfood, color: Colors.tealAccent),
                            title: Text(itemData['name'], style: TextStyle(color: Colors.white)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Show the number of days until expiry instead of the expiry date
                                Text('Expires in $daysUntilExpiry days', style: TextStyle(color: Colors.grey)),
                                Text('Quantity: ${itemData['quantity']}', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                            trailing: Icon(Icons.chevron_right, color: Colors.tealAccent),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditItemScreen(
                                    itemId: fridgeItems[index].id,  // The Firestore document ID
                                    userId: _auth.currentUser!.uid,  // The user's ID
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    );
                  } else {
                    return Text('No items in your fridge');
                  }
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

  Widget _buildInventoryItem(BuildContext context, QueryDocumentSnapshot item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.fastfood, color: Colors.tealAccent),
        title: Text(item['name'], style: TextStyle(color: Colors.white)),
        subtitle: Text('Expires on: ${item['expiry']}', style: TextStyle(color: Colors.grey)),
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

  // Function to start the voice assistant conversation
  Future<void> _startVoiceConversation() async {
    final assistantConfig = {
      'firstMessage': 'Hello! What recipe would you like to cook today?',
      'context': 'You are a cooking assistant guiding the user through a recipe step-by-step based on their inventory.',
      'model': 'gpt-3.5-turbo',
      'voice': 'jennifer-playht',
      'recordingEnabled': true,
      'interruptionsEnabled': false,
    };
  }

  // Function to show the voice agent dialog
  void _showVoiceAgentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      onPressed: () async {
                        await _startVoiceConversation();
                        setState(() {}); // Refresh the dialog to show updated transcript
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
                            transcript,
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
      },
    );
  }
}
