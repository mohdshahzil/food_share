import 'package:flutter/material.dart';

class FoodDonorSignUpScreen extends StatefulWidget {
  const FoodDonorSignUpScreen({super.key});

  @override
  State<FoodDonorSignUpScreen> createState() => _FoodDonorSignUpScreenState();
}

class _FoodDonorSignUpScreenState extends State<FoodDonorSignUpScreen> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign-up Successful!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Food Donor Sign-Up",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
              _buildTextField(emailController, "Email", Icons.email, isEmail: true),
              _buildTextField(phoneController, "Phone Number", Icons.phone, isNumber: true),
              _buildTextField(addressController, "Address", Icons.location_on, maxLines: 2),
              _buildPasswordField(passwordController, "Password"),
              _buildPasswordField(confirmPasswordController, "Confirm Password", isConfirm: true),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9D23),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool isPassword = false,
    bool isEmail = false,
    bool isNumber = false,
    int? maxLines,
  }) {
    const Color orangeColor = Color(0xFFFF9D23);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
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
            borderSide: BorderSide(color: Colors.grey.shade300), // Default border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: orangeColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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
          if (isEmail && !RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
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

  Widget _buildPasswordField(TextEditingController controller, String hint, {bool isConfirm = false}) {
    const Color orangeColor = Color(0xFFFF9D23);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isConfirm ? _obscureConfirmPassword : _obscurePassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock, color: Colors.grey),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300), // Default border
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
              isConfirm
                  ? (_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off)
                  : (_obscurePassword ? Icons.visibility : Icons.visibility_off),
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                if (isConfirm) {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                } else {
                  _obscurePassword = !_obscurePassword;
                }
              });
            },
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$hint is required";
          }
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
          if (isConfirm && value != passwordController.text) {
            return "Passwords do not match";
          }
          return null;
        },
      ),
    );
  }
}

 