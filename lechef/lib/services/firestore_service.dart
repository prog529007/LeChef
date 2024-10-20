import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/fridge_item.dart'; // Import the FridgeItem model

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add a fridge item to the user's fridge
  Future<void> addFridgeItem(String userId, FridgeItem item) async {
    try {
      // Get reference to the user's fridge collection
      CollectionReference fridgeRef = _db.collection('users').doc(userId).collection('fridge');

      // Add fridge item to Firestore
      await fridgeRef.add(item.toJson());
    } catch (e) {
      print("Error adding fridge item: $e");
      // Handle error
    }
  }

  // Retrieve fridge items for a user
  Stream<List<FridgeItem>> getFridgeItems(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('fridge')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => FridgeItem.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // Delete a fridge item
  Future<void> deleteFridgeItem(String userId, String itemId) async {
    try {
      await _db.collection('users').doc(userId).collection('fridge').doc(itemId).delete();
    } catch (e) {
      print("Error deleting fridge item: $e");
      // Handle error
    }
  }
}
