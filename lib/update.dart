import 'package:flutter/material.dart';
import 'main.dart';
import 'database.dart';
import 'details.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Initialize Firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class UpdateUserScreen extends StatefulWidget {
  final Map<String, dynamic> user;
//allows the user to view and update their profile
  UpdateUserScreen(this.user);

  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
// Declare and initialize
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumberController;
  late TextEditingController confPwdController;
  String? address;
  String? userPwd;
  String? confPwd;

  List<String> addressList = []; // Added address list // Define the addressList as an empty list

  @override
  void initState() {
    super.initState();
    // Initialize the TextEditingController to conn db
    nameController = TextEditingController(text: widget.user['name']);
    emailController = TextEditingController(text: widget.user['email']);
    passwordController = TextEditingController(text: widget.user['password'].toString());
    phoneNumberController = TextEditingController(text: widget.user['phoneNumber'].toString());
    confPwdController = TextEditingController(text: widget.user['conformPwd']);
    address = widget.user['address'];
    addressList = getAddressList(); // Call a function to populate the addressList
  }

  List<String> getAddressList() {
    return ['Address 1', 'Address 2', 'Address 3'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update user')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'User Name'),
                validator: (val) => val!.isEmpty ? 'Please enter the User name' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Please enter Email ' : null,
              ),
              TextFormField(
                onChanged: (val) {
                  // Handle password onChanged if needed
                  userPwd = val;
                },
                obscureText: true, // Hide the entered password
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter a password';
                  }

                  // Perform password strength check
                  bool _isPasswordStrong(String password) {
                    return password.length >= 8 &&
                        password.contains(RegExp(r'[A-Za-z]')) &&
                        password.contains(RegExp(r'[0-9]')) &&
                        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                  }

                  if (!_isPasswordStrong(val)) {
                    return 'Password is too weak';
                  }

                  return null; // Return null if the password is valid
                },
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty || int.tryParse(val) == null
                    ? 'Please enter your phone number'
                    : null,
              ),
              TextFormField(
                onChanged: (val) {
                  // Handle password onChanged if needed
                  confPwd = val;
                },
                obscureText: true, // Hide the entered password
                decoration: const InputDecoration(labelText: 'Confirm Password'),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your password again';
                  }
                  if (val != userPwd) {
                    return 'Passwords do not match';
                  }
                  return null; // Return null if the password is valid
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'select Adress'),
                value: address!.isNotEmpty && ['Muscat', 'Rustaq', 'Sohar', 'Sur'].contains(address) ? address : null,
                onChanged: (String? newValue) => setState(() => address = newValue!),
                items: <String>['Muscat', 'Rustaq', 'Sohar', 'Sur'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(value: value, child: Text(value));
                }).toList(),
                validator: (val) => val == null ? 'Please select the address' : null,
              ),




              /////////////////////////
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final updatedUser = {
                      'name': nameController.text,
                      'email': emailController.text,
                      'password': passwordController.text,
                      'phoneNumber': int.parse(phoneNumberController.text), // Ensure parsing to int
                      'conformPwd': confPwdController.text,
                      'address': address!, //!! a non-null
                    };
                    try {
                      await DatabaseService().updateUser(widget.user['id'], updatedUser);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update user: $e')),
                      );
                    }
                  }
                },
                child: const Text('Update'),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage())),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}