import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_item_screen.dart';
import 'edit_item_screen.dart';
import 'package:vapi/Vapi.dart';

const VAPI_PUBLIC_KEY = '765f4fb5-8d8c-4de8-91f5-3d2b93c35e42';
const VAPI_ASSISTANT_ID = '5ad833ba-10d1-4078-ba77-d64cadfa7fd3';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String transcript = 'Transcript will appear here...';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Vapi vapi = Vapi(VAPI_PUBLIC_KEY);
  bool isCallStarted = false;

  @override
  void initState() {
    super.initState();
    vapi.onEvent.listen((event) {
      if (event.label == "call-start") {
        setState(() {
          isCallStarted = true;
        });
        print('Call started');
      }
      if (event.label == "call-end") {
        setState(() {
          isCallStarted = false;
        });
        print('Call ended');
      }
      if (event.label == "message") {
        print(event.value);
      }
    });
  }

  @override
  void dispose() {
    vapi.stop();
    super.dispose();
  }

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


  Future<List<String>> _getAvailableIngredients() async {
    User? user = _auth.currentUser;
    if (user == null) return [];

    QuerySnapshot snapshot = await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('fridge')
        .get();

    return snapshot.docs.map((doc) => (doc.data() as Map<String, dynamic>)['name'] as String).toList();
  }

  void _showVoiceAgentDialog(BuildContext context) async {
    List<String> ingredients = await _getAvailableIngredients();

    showDialog(
      context: context,
      barrierDismissible: true,
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
                IconButton(
                  icon: Icon(Icons.mic, size: 80, color: Colors.tealAccent),
                  onPressed: () async {
                    if (!isCallStarted) {
                      await vapi.start(assistant: {
                        "firstMessage": "Hello, I'm your AI powered cooking assistant!",
                        "model": {
                          "provider": "openai",
                          "model": "gpt-3.5-turbo",
                          "messages": [
                            {
                              "role": "system",
                              "content": "You are an assistant that talks to the user and helps them prepare meals by suggesting recipes based on available ingredients. The available ingredients are: ${ingredients.join(', ')}. If there is some additional ingredient which is really required, you suggest them to the user."
                            }
                          ]
                        },
                        "voice": "jennifer-playht"
                      });
                    } else {
                      await vapi.stop();
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  isCallStarted ? 'Listening...' : 'Tap mic to start',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    await vapi.stop();
                    Navigator.pop(context);
                  },
                  child: Text('Stop Listening'),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      if (isCallStarted) {
        vapi.stop();
      }
    });
  }
}
