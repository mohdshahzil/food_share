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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle successful signup logic here
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sign-up Successful!")));
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(nameController, "Full Name", Icons.person),
              _buildTextField(emailController, "Email", Icons.email,
                  isEmail: true),
              _buildTextField(phoneController, "Phone Number", Icons.phone,
                  isNumber: true),
              _buildTextField(addressController, "Address", Icons.location_on),
              _buildTextField(passwordController, "Password", Icons.lock,
                  isPassword: true),
              _buildTextField(
                  confirmPasswordController, "Confirm Password", Icons.lock,
                  isPassword: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9D23), // Orange Button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String hint, IconData icon,
      {bool isPassword = false, bool isEmail = false, bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isEmail
            ? TextInputType.emailAddress
            : (isNumber ? TextInputType.phone : TextInputType.text),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.grey[200],
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
          if (isPassword && value.length < 6) {
            return "Password must be at least 6 characters";
          }
          return null;
        },
      ),
    );
  }
}
