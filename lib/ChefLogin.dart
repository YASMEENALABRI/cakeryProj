import 'package:flutter/material.dart';
import 'database.dart';
import 'Menu.dart';
import 'register.dart';

class ChefLoginPage extends StatefulWidget {
  const ChefLoginPage({super.key});
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<ChefLoginPage> {
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
              Navigator.pop(context); // Navigate back when the arrow is pressed
            },
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
                          width: 400, // Adjust the width as needed
                          height: 200, // Adjust the height as needed
                        ),
                      ),
                      SizedBox(height: 50),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(66),
                        ),
                        width: 300,
                        height: 55,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            labelText: 'Username',
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
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            labelText: 'Password',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: compute,
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 115, vertical: 13)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27),
                            ),
                          ),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 23, color: Colors.grey[800]),
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

  void compute() async {
    if (_formKey.currentState!.validate()) {
      bool loginSuccess = await DatabaseService.authenticateUser(
        username.text,
        password.text,
      );

      if (loginSuccess) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuPage()),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid username or password')),
        );
      }
    }
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }
}