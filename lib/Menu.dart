import 'package:flutter/material.dart';
import 'database.dart';
import 'register.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'Coffe.dart'; // Update the import statement for Coffee.dart
import 'Sweets.dart'; // Update the import statement for Sweet.dart

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[800],
      appBar: AppBar(
        title: Text('Menu'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the arrow is pressed
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              height: 300,
              width: 300,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CoffeePage(), // Replace with the Coffee class
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Set the background color here
              ),
              child: Text('Coffee'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SweetsPage(), // Update to Sweet()
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Set the background color here
              ),
              child: Text('Sweets'),
            )
          ],
        ),
      ),
    );
  }
}