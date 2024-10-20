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
