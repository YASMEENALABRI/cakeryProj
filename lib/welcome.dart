import 'package:flutter/material.dart';
import './TypeOfUser.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF69065D),
      appBar: AppBar(
        backgroundColor: Color(0xFF69065D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 2),
            ClipOval(
              child: Image.asset(
                'assets/logo.png',
                width: 300, // Adjust the width as needed
                height: 300, // Adjust the height as needed
              ),
            ),
            const SizedBox(height: 1),
            const Text(
              'Cakery',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: Colors.white,
                fontFamily: 'IndieFlower',
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Baking...',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 2.0,
                color: Colors.white,
                fontFamily: 'IndieFlower',
              ),
            ),
            const Text(
              'Cakery will come to you right away ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 2.0,
                color: Colors.white,
                fontFamily: 'IndieFlower',
              ),
            ),

            const SizedBox(height: 150),
            Container(
              alignment: Alignment.center,
              child: FractionallySizedBox(
                widthFactor: 0.4, // Adjust the width factor as desired
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TypeOfUser()), // Navigate to the login page
                    );
                  },
                  child: const Text('Continue',
                    style: TextStyle(
                      color:  Color(0xFF69065D),
                      fontSize: 18, // Font size for the button text
                    ),),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
