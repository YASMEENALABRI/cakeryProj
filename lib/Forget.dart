/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:sloproject/screens/signin_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _resetCode;
  Timer? _timer;
  int _secondsRemaining = 60;
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isCodeVerified = false;
  DocumentReference? _userDocRef; // Reference to the user's document

  // Password strength validation
  bool _isPasswordStrong(String password) {
    return RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$')
        .hasMatch(password);
  }

  // Hash password using SHA-256
  String _hashPassword(String password) {
    var bytes = utf8.encode(password);
    var hashed = sha256.convert(bytes);
    return hashed.toString();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _generateRandomCode() {
    final random = Random();
    return '${random.nextInt(9000) + 1000}';
  }

  Future<void> _sendResetEmail() async {
    final smtpServer =
    gmail('studentorganizer25@gmail.com', 'kqmn dpkh rdnk vsvz');
    final userDoc = await _firestore
        .collection('student')
        .where('email', isEqualTo: _emailController.text)
        .limit(1)
        .get();

    if (userDoc.docs.isNotEmpty) {
      _resetCode = _generateRandomCode();
      _startTimer();
      _secondsRemaining = 60;
      _userDocRef =
          userDoc.docs.first.reference; // Save the user's document reference

      final message = Message()
        ..from = Address('studentorganizer25@gmail.com', 'Admin')
        ..recipients.add(_emailController.text)
        ..subject = 'Password Reset'
        ..text = 'Your password reset code is: $_resetCode';

      try {
        await send(message, smtpServer);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset code sent to your email.')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send reset email: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('User not found. Please check your email.')));
    }
  }

  Future<void> _passwordUpdateMsg() async {
    final smtpServer =
    gmail('studentorganizer25@gmail.com', 'kqmn dpkh rdnk vsvz');

    final message = Message()
      ..from = Address('studentorganizer25@gmail.com', 'Admin')
      ..recipients.add(_emailController.text)
      ..subject = 'Password update'
      ..text =
          'Hello ${_emailController.text}..\n Your password has been updated successfully, \n Note: if you did not initiate this process please change your password now or contact our support team ';
    try {
      await send(message, smtpServer);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send reset email: $e')));
    }
  }

  Future<void> _verifyCode(BuildContext context) async {
    if (_codeController.text == _resetCode) {
      setState(() {
        _isCodeVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Code verified. Please enter your new password.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid code. Please try again.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }

                    final emailRegex =
                    RegExp(r'^[a-zA-Z0-9].*@.+\..+$');

                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }

                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Enter Email'),
                ),
              ),

              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendResetEmail();
                  }
                },
                child: const Text('Send Code To Email'),
              ),
              const SizedBox(height: 20.0),
              Text('Time Remaining: $_secondsRemaining seconds'),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Enter Code'),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () => _verifyCode(context),
                child: const Text('Verify Code'),
              ),
              const SizedBox(height: 40.0),
              if (_isCodeVerified)
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (!_isPasswordStrong(value)) {
                      return 'Password should contain at least 6 characters including upper and lower case letters, a number and a special character';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              const SizedBox(height: 20.0),
              if (_isCodeVerified)
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String hashedPassword =
                      _hashPassword(_newPasswordController.text);
                      await _userDocRef?.update({
                        'password': hashedPassword,
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Password updated successfully')));
                      await _passwordUpdateMsg();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Save New Password'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
*/