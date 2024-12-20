import 'package:flutter/material.dart';
import 'database.dart';
import 'Menu.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Ensure Firebase Auth is imported

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            'Customer login',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Color(0xFF69065D),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 100),
                      ClipOval(
                        child: Image.asset(
                          'assets/logo.png',
                          width: 400,
                          height: 200,
                        ),
                      ),
                      SizedBox(height: 50),
                      _buildTextField(username, 'Username', Icons.person),
                      SizedBox(height: 12.0),
                      _buildTextField(password, 'Password', Icons.lock, obscureText: true),
                      SizedBox(height: 10), // Add spacing between password field and forgot password
                      _buildForgotPasswordButton(), // Moved here
                      SizedBox(height: 35),
                      _buildLoginButton(),
                      SizedBox(height: 22),
                      _buildSignUpPrompt(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(66),
      ),
      width: 300,
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.black),
          labelText: label,
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: compute,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 10)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(27))),
      ),
      child: Text(
        "LOGIN",
        style: TextStyle(fontSize: 23, color: Colors.grey[800]),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return GestureDetector(
      onTap: _showForgotPasswordDialog,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpPrompt() {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(width: 5),
          Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red[500],
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  void compute() async {
    if (_formKey.currentState!.validate()) {
      bool loginSuccess = await DatabaseService.authenticateUser(username.text, password.text);
      if (loginSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid username or password')));
      }
    }
  }

  void _showForgotPasswordDialog() {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reset Password"),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: "Enter your email"),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  try {
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password reset email sent!')));
                    Navigator.of(context).pop(); // Close the dialog
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter your email.')));
                }
              },
              child: Text("Send"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}