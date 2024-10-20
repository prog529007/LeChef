import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

class VoiceAssistant extends StatefulWidget {
  @override
  _VoiceAssistantState createState() => _VoiceAssistantState();
}

class _VoiceAssistantState extends State<VoiceAssistant> {
  bool isListening = false;
  final Vapi vapi = Vapi(apiKey: '765f4fb5-8d8c-4de8-91f5-3d2b93c35e42');
  
  Future<void> startVoiceConversation() async {
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
    } catch (e) {
      print('Failed to start conversation: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(isListening ? Icons.mic : Icons.mic_none),
      onPressed: () {
        setState(() {
          isListening = !isListening;
        });
        startVoiceConversation();
      },
    );
  }
}
