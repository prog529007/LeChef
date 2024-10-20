// import 'package:flutter/material.dart';
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

//   // Function to show the voice agent screen
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
//                     // Trigger voice AI logic (to be implemented)
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
import 'package:vapi/Vapi.dart';
import 'add_item_screen.dart';

const VAPI_PUBLIC_KEY = '765f4fb5-8d8c-4de8-91f5-3d2b93c35e42';
const VAPI_ASSISTANT_ID = '5ad833ba-10d1-4078-ba77-d64cadfa7fd3';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void _showVoiceAgentDialog(BuildContext context) {
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
                        "firstMessage": "Hello, I am an assistant.",
                        "model": {
                          "provider": "openai",
                          "model": "gpt-3.5-turbo",
                          "messages": [
                            {
                              "role": "system",
                              "content": "You are an assistant."
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
      // Ensure Vapi is stopped if the dialog is dismissed
      if (isCallStarted) {
        vapi.stop();
      }
    });
  }
}
