import 'package:flutter/material.dart';
import 'food_donor_signup_screen.dart';

class FoodDonorSignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Donor Sign-In')),
      body: Column(
        children: [
          // Add your sign-in form here (email, password, etc.)
          Text('Sign in as Donor'),
          // Add Sign-Up button at the bottom
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodDonorSignUpScreen()),
              );
            },
            child: Text('Sign Up as Donor'),
          ),
        ],
      ),
    );
  }
}
