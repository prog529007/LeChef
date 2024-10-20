import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lechef/screens/home_screen.dart';
import 'package:lechef/screens/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'fridge_item.dart'; // Import the data model

class FirestoreService {
  final CollectionReference fridgeCollection =
      FirebaseFirestore.instance.collection('fridgeItems');

  // Add a new fridge item
  Future<void> addFridgeItem(String userId, FridgeItem item) {
    return fridgeCollection
        .doc(userId)
        .collection('items')
        .add(item.toJson());
  }

  // Update an existing fridge item
  Future<void> updateFridgeItem(String userId, String itemId, FridgeItem item) {
    return fridgeCollection
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .update(item.toJson());
  }

  // Retrieve fridge items for a user
  Stream<List<FridgeItem>> getFridgeItems(String userId) {
    return fridgeCollection
        .doc(userId)
        .collection('items')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FridgeItem.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Delete a fridge item
  Future<void> deleteFridgeItem(String userId, String itemId) {
    return fridgeCollection
        .doc(userId)
        .collection('items')
        .doc(itemId)
        .delete();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LeChef',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.tealAccent,
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          elevation: 0, // Flat appearance
        ),
        cardColor: Color(0xFF1E1E1E),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.tealAccent,
            foregroundColor: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      themeMode: ThemeMode.dark, // Enable dark mode
      home: LoginScreen(),
    );
  }
}
