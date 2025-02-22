
import 'package:flutter/material.dart';

class FoodReceiverSignUpScreen extends StatefulWidget {
  const FoodReceiverSignUpScreen({super.key});

  @override
  State<FoodReceiverSignUpScreen> createState() =>
      _FoodReceiverSignUpScreenState();
}

class _FoodReceiverSignUpScreenState extends State<FoodReceiverSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // For now, just showing a snackbar as success response.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Food Receiver Sign-up Successful!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Food Receiver Sign-Up",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField(nameController, "Full Name", Icons.person),
              _buildTextField(emailController, "Email", Icons.email,
                  isEmail: true),
              _buildTextField(phoneController, "Phone Number", Icons.phone,
                  isNumber: true),
              _buildTextField(addressController, "Address", Icons.location_on,
                  maxLines: 2),
              _buildPasswordField(passwordController, "Password"),
              _buildPasswordField(confirmPasswordController, "Confirm Password",
                  confirmPasswordController: passwordController),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9D23),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isEmail = false, bool isNumber = false, int? maxLines}) {
    const Color orangeColor = Color(0xFFFF9D23);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : (isNumber ? TextInputType.phone : TextInputType.text),
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: orangeColor, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$hint is required";
          }
          if (isEmail &&
              !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                  .hasMatch(value)) {
            return "Enter a valid email";
          }
          if (isNumber && !RegExp(r'^[0-9]+$').hasMatch(value)) {
            return "Enter a valid phone number";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String hint,
      {TextEditingController? confirmPasswordController}) {
    const Color orangeColor = Color(0xFFFF9D23);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText:
            confirmPasswordController != null ? _obscureConfirmPassword : _obscurePassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: orangeColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              (confirmPasswordController != null
                      ? _obscureConfirmPassword
                      : _obscurePassword)
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (confirmPasswordController != null) {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                } else {
                  _obscurePassword = !_obscurePassword;
                }
              });
            },
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$hint is required";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          if (confirmPasswordController != null &&
              value != confirmPasswordController.text) {
            return "Passwords do not match";
          }
          return null;
        },
      ),
    );
  }
}
