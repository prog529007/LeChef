# Chef It Up

Chef It Up is a Flutter-based mobile app designed to help you efficiently manage your fridge ingredients and make cooking easier. With this app, you can track the items in your fridge, discover recipes using your existing ingredients, and even gamify the process through a reward system. Chef It Up integrates with Firebase for real-time inventory management and Sui blockchain for reward/punishment incentives using Sui coins.

### Features

1. Fridge Inventory Management:
* Easily add and remove items from your fridge.
* Track the quantity and expiration dates of your ingredients.
* Real-time sync and storage using Firebase.
2. Recipe Suggestions with Vapi (Voice Assistant):
* Interact with Vapi, a built-in voice assistant.
* Ask Vapi to find recipes using ingredients already available in your fridge.
* Voice-based search for quick, hands-free operation.
3. Rewards and Penalties with Sui Coins:
* Stay on top of your fridge management by receiving Sui coin rewards when you use ingredients before they expire.
* If ingredients go unused and expire, incur penalties in the form of Sui coin deductions.
* Transactions are securely handled using the Sui blockchain.
### Installation

Clone the repository:

```git clone https://github.com/your-username/chef-it-up.git```

Navigate to the project directory:

```cd LeChef/lechef/```

Install dependencies:

```flutter pub get```

Run the app:

```flutter run```

### Usage

* Add Ingredients:

Upon launching the app, you can start adding ingredients to your fridge by clicking the “+” button and entering the item name, quantity, and expiration date.
* Ask Vapi for Recipes:

Activate Vapi by tapping the voice assistant button and asking, "What can I cook with [ingredient]?" Vapi will suggest recipes that utilize items from your fridge inventory.
* Sui Coin Rewards/Penalties:

Rewards: Each time you use an ingredient in a recipe before it expires, you'll earn Sui coins.

Penalties: If an ingredient expires without being used, you'll lose a certain amount of Sui coins.
* Track Your Sui Coin Balance:

Keep track of your earned or lost coins through the integrated Sui wallet in the app.
### Roadmap
Smart Recipe Suggestions: Incorporate machine learning to suggest personalized recipes based on user preferences and ingredient availability.

Notifications: Add push notifications to remind users of expiring ingredients.

Social Features: Allow users to share recipes and compare Sui coin balances with friends.

Shopping List Integration: Automatically generate shopping lists based on recipe preferences and ingredient shortages.

### Technologies Used

Flutter: Cross-platform framework for building the mobile app.

Firebase: Real-time database for fridge inventory tracking and user authentication.

Sui Blockchain: Handles rewards/penalties through Sui coins.

Dart: Programming language for Flutter.

Vapi (Voice Assistant): Custom voice assistant integrated for recipe suggestions.

