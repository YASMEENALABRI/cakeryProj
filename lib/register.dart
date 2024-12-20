import 'package:flutter/material.dart';
import 'database.dart'; // Ensure you have a database service for user registration
import 'CusLogin.dart'; // Import the CusLogin page

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPwdController = TextEditingController();
  TextEditingController confPwdController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String address = '';

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
          backgroundColor: Colors.white, // Set AppBar background to white
          title: Text(
            'Register User',
            style: TextStyle(color: Colors.black), // Set title color to black
          ),
          iconTheme: IconThemeData(color: Colors.black), // Set icon color
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
                      SizedBox(height: 20),
                      ClipOval(
                        child: Image.asset(
                          'assets/logo.png', // Adjust the path to your logo image
                          width: 100, // Adjust the width as needed
                          height: 100, // Adjust the height as needed
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 300,
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person, color: Colors.black),
                            labelText: 'User Name',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 300,
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: userEmailController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email, color: Colors.black),
                            labelText: 'User Email',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 300,
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: userPwdController,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.black),
                            labelText: 'Password',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 300,
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: confPwdController,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.black),
                            labelText: 'Confirm Password',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != userPwdController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 300,
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.phone, color: Colors.black),
                            labelText: 'Phone Number',
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),

                      ),
                      SizedBox(height: 12.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Select Address',
                            border: InputBorder.none,
                          ),
                          value: address.isNotEmpty &&
                              ['Muscat', 'Rustaq', 'Sohar', 'Sur', 'Nizwa', 'Salalah', 'Bahla', 'Ibri'].contains(address)
                              ? address : null,
                          onChanged: (String? newValue) => setState(() => address = newValue!),
                          items: <String>[
                            'Muscat',
                            'Rustaq',
                            'Sohar',
                            'Sur',
                            'Nizwa',
                            'Salalah',
                            'Bahla',
                            'Ibri'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(value: value, child: Text(value));
                          }).toList(),
                          validator: (val) => val == null ? 'Please select an address' : null,
                        ),
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await DatabaseService().adduser({
                                'name': userNameController.text,
                                'email': userEmailController.text,
                                'password': userPwdController.text,
                                'phoneNumber': phoneController.text,
                                'conformPwd': confPwdController.text,
                                'address': address,
                              });
                              Navigator.pop(context); // Go back to the main screen
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add user: $e')));
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 60, vertical: 10)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(27))),
                        ),
                        child: Text("REGISTER", style: TextStyle(fontSize: 20, color: Colors.grey[800])),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()), // Navigate to CusLogin
                          );
                        },
                        child: Text(
                          'Already have an account? Login here',
                          style: TextStyle(color: Colors.white, fontSize: 16), // Style for the link
                        ),
                      ),
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

  @override
  void dispose() {
    userNameController.dispose();
    userEmailController.dispose();
    userPwdController.dispose();
    confPwdController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}