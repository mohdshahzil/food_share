import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up
  Future<UserCredential> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String address,
    required String role,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user document in Firestore
      try {
        // Create document reference
        // DocumentReference userDoc =
        //     _firestore.collection('users').doc(userCredential.user!.uid);
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        // Create document data with explicit types
        await users.add({
          'name': name.trim(),
          'email': email.trim(),
          'role': role,
          'phone': phone.trim(),
          'address': address.trim(),
          'createdAt': Timestamp.now(),
          'donationsMade':
              <Map<String, dynamic>>[], // Array of donation references
          'requestsMade':
              <Map<String, dynamic>>[], // Array of request references
          'userId': userCredential.user!.uid, // Store user ID explicitly
          'lastUpdated': Timestamp.now(),
          'isActive': true,
        });

        return userCredential;
      } catch (e) {
        await userCredential.user?.delete();
        throw 'Failed to create user profile';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw 'Please check your internet connection';
      } else if (e.code == 'operation-not-allowed') {
        throw 'Email/Password sign-in is not enabled. Please contact support.';
      }
      throw _handleAuthError(e.code);
    }
  }

  // Sign In
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e.code);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get user role
  Future<String?> getUserRole(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      return doc.get('role') as String?;
    } catch (e) {
      return null;
    }
  }

  String _handleAuthError(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'operation-not-allowed':
        return 'Email & Password accounts are not enabled.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // Add this method
  Future<bool> testFirestore() async {
    try {
      await _firestore
          .collection('test')
          .add({'timestamp': Timestamp.now(), 'test': 'test'});
      print('Firestore write test successful');
      return true;
    } catch (e) {
      print('Firestore write test failed: $e');
      return false;
    }
  }
}
