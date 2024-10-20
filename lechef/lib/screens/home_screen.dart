// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'add_item_screen.dart';

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('LeChef'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildOptionCard(
//                     context,
//                     icon: Icons.qr_code_scanner,
//                     title: 'Scan Product',
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => AddItemScreen()),
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: _buildOptionCard(
//                     context,
//                     icon: Icons.settings,
//                     title: 'Settings',
//                     onTap: () {
//                       // Navigate to settings screen (to be implemented)
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12),
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.all(16.0),
//                 itemCount: 10, // Placeholder for the number of items
//                 itemBuilder: (context, index) {
//                   return _buildInventoryItem(context, index);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: Color(0xFF1F1F1F),
//         shape: CircularNotchedRectangle(),
//         notchMargin: 8.0,
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showVoiceAgentDialog(context);
//         },
//         backgroundColor: Colors.tealAccent,
//         child: Icon(Icons.mic, color: Colors.black),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }

//   Widget _buildInventoryItem(BuildContext context, int index) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       decoration: BoxDecoration(
//         color: Color(0xFF1E1E1E),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: ListTile(
//         leading: Icon(Icons.fastfood, color: Colors.tealAccent),
//         title: Text('Product Name $index', style: TextStyle(color: Colors.white)),
//         subtitle: Text('Expires in: 5 days', style: TextStyle(color: Colors.grey)),
//         trailing: Icon(Icons.chevron_right, color: Colors.tealAccent),
//         onTap: () {
//           // Navigate to product details screen (to be implemented)
//         },
//       ),
//     );
//   }

//   Widget _buildOptionCard(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFF1E1E1E),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           child: Row(
//             children: [
//               Icon(icon, size: 28, color: Colors.tealAccent),
//               SizedBox(width: 12),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Function to start the voice assistant conversation
//   Future<void> _startVoiceConversation() async {
//     final url = Uri.parse('http://127.0.0.1:3000/start_conversation');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'firstMessage': 'Hello! What recipe would you like to cook today?',
//       }),
//     );

//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       print('Vapi Response: ${responseData}');
//       // Handle the response, e.g., start playing audio or show text
//     } else {
//       print('Failed to start conversation');
//     }
//   }

//   // Function to show the voice agent dialog
//   void _showVoiceAgentDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Color(0xFF1F1F1F),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SizedBox(height: 20),
//                 // Large Mic Button
//                 IconButton(
//                   icon: Icon(Icons.mic, size: 80, color: Colors.tealAccent),
//                   onPressed: () {
//                     _startVoiceConversation(); // Start the voice conversation here
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Listening...',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//                 SizedBox(height: 40),
//                 // Transcript Area at the bottom
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF1E1E1E),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Text(
//                         'Transcript will appear here...',
//                         style: TextStyle(color: Colors.grey, fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'add_item_screen.dart';

// Simulated Vapi class
class Vapi {
  final String apiKey;

  Vapi({required this.apiKey});

  Future<Map<String, dynamic>> start({required Map<String, dynamic> assistant}) async {
    // Simulated Vapi start method
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return {
      'status': 'success',
      'message': 'Conversation started',
      'assistant': assistant,
    };
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Vapi vapi = Vapi(apiKey: '765f4fb5-8d8c-4de8-91f5-3d2b93c35e42');
  String transcript = 'Transcript will appear here...';

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

    try {
      final response = await vapi.start(assistant: assistantConfig);
      print('Vapi Response: $response');
      // Handle the response, e.g., start playing audio or show text
      setState(() {
        transcript = 'Assistant: ${response['assistant']['firstMessage']}';
      });
    } catch (e) {
      print('Failed to start conversation: $e');
      setState(() {
        transcript = 'Error: Failed to start conversation';
      });
    }
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