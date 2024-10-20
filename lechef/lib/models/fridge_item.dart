class FridgeItem {
  String name;
  int quantity;
  DateTime expiryDate;

  FridgeItem({required this.name, required this.quantity, required this.expiryDate});

  // Convert FridgeItem to JSON format for Firebase
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }

  // Factory method to create a FridgeItem from JSON
  factory FridgeItem.fromJson(Map<String, dynamic> json) {
    return FridgeItem(
      name: json['name'],
      quantity: json['quantity'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }

  ExpiryStatus getExpiryStatus() {
    final now = DateTime.now();
    final daysLeft = expiryDate.difference(now).inDays;

    if (daysLeft <= 0) {
      return ExpiryStatus.expired;
    } else if (daysLeft <= 3) {
      return ExpiryStatus.soon;
    } else if (daysLeft <= 7) {
      return ExpiryStatus.upcoming;
    } else {
      return ExpiryStatus.fresh;
    }
  }
}

enum ExpiryStatus { expired, soon, upcoming, fresh }