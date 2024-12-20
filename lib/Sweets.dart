import 'package:flutter/material.dart';
import './Menu.dart';
import './Thanks.dart';
import './Coffe.dart';

class SweetsPage extends StatefulWidget {
  @override
  _SweetsPageState createState() => _SweetsPageState();
}

class _SweetsPageState extends State<SweetsPage> {
  int itemCount = 0;

  void addItem() {
    setState(() {
      itemCount++;
    });
  }

  Widget buildCoffeeItem(String image, String name, String price) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(
            image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          ListTile(
            title: Text(name),
            subtitle: Text(price),
          ),
          ElevatedButton.icon(
            onPressed: addItem,
            icon: Icon(Icons.add),
            label: Text('Add Item ($itemCount)'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sweets'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the menu page
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildCoffeeItem(
                  'assets/Cakes.jpg',
                  'Cakes',
                  'Price:  0.600 OMR',
                ),
                buildCoffeeItem(
                  'assets/Cheesecake.jpg',
                  'Cheesecake',
                  'Price: 1.300 OMR',
                ),
                buildCoffeeItem(
                  'assets/cookies.jpeg',
                  'cookies',
                  'Price: 1.000 OMR',
                ),
                buildCoffeeItem(
                  'assets/Croissants.jpg',
                  'Croissants',
                  'Price: 0.900 OMR',
                ),
              ],
            ),
          ),
          Container(
            color: Colors.cyan[800],
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MenuPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.home, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.coffee, color: Colors.white),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ThanksPage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.cake, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ThanksPage()),
                    );
                  },
                  child: const Text('Add to cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}