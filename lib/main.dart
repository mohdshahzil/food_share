// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:food_share/screens/onboarding_screen.dart';
// import 'firebase_options.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Food Share',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF9D23)),
//         scaffoldBackgroundColor: Colors.white,
//         useMaterial3: true,
//       ),
//       home: const InitializationWrapper(),
//     );
//   }
// }

// class InitializationWrapper extends StatelessWidget {
//   const InitializationWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       ),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Scaffold(
//             body: Center(
//               child: Text('Error: ${snapshot.error}'),
//             ),
//           );
//         }

//         if (snapshot.connectionState == ConnectionState.done) {
//           return const OnboardingScreen();
//         }

//         // Loading screen
//         return const Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(
//               color: Color(0xFFFF9D23),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_share/screens/onboarding_screen.dart';
import 'firebase_options.dart';
import 'package:food_share/services/auth_service.dart'; // Import your AuthService

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Share',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF9D23)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const InitializationWrapper(),
    );
  }
}

class InitializationWrapper extends StatelessWidget {
  const InitializationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // Firebase initialized, now test Firestore
          AuthService authService = AuthService(); // Create an instance of AuthService
          authService.testFirestore().then((success) {
            if (success) {
              print('Firestore test successful from main.dart');
            } else {
              print('Firestore test failed from main.dart');
            }
          });

          return const OnboardingScreen();
        }

        // Loading screen
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: Color(0xFFFF9D23),
            ),
          ),
        );
      },
    );
  }
}