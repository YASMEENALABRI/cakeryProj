import 'package:flutter/material.dart';
import './Menu.dart';
import './Coffe.dart';
import './Sweets.dart';
import 'welcome.dart';

class ThanksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[800],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 80),
            Image.asset('assets/logo.png',width: 300),

            const Text(
              'Thank you',
              style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 5.0,
                color: Colors.white,
                fontFamily: 'IndieFlower',
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'I wish you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
                fontFamily: 'IndieFlower',
              ),
            ),
            const Text(
              'a happy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                letterSpacing: 2.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'IndieFlower',
              ),
            ),
            const Text(
              'experience..!!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'IndieFlower',
              ),
            ),
            const SizedBox(height: 60),
            Container(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.2, // Adjust the width factor as desired
                child: FloatingActionButton(

                  backgroundColor: Colors.grey[300],
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()), // Navigate to the login page
                    );
                  },
                  child: const Text('finished',style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}