import 'package:flutter/material.dart';
import 'food_receiver_signup_screen.dart';

class FoodReceiverSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Receiver Sign-In')),
      body: Column(
        children: [
          // Add your sign-in form here (email, password, etc.)
          Text('Sign in as Receiver'),
          // Add Sign-Up button at the bottom
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodReceiverSignUpScreen()),
              );
            },
            child: Text('Sign Up as Receiver'),
          ),
        ],
      ),
    );
  }
}
