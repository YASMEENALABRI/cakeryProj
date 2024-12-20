import 'package:flutter/material.dart';
import './Menu.dart';
import './Sweets.dart';
import 'Thanks.dart';

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
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
        title: Text('Coffee'),
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
                  'assets/Cappuccino.jpg',
                  'Cappuccino',
                  'Price: 1.500 OMR',
                ),
                buildCoffeeItem(
                  'assets/Espresso.jpg',
                  'Espresso',
                  'Price: 1.000 OMR',
                ),
                buildCoffeeItem(
                  'assets/Lattee.jpg',
                  'Latte',
                  'Price: 1.300 OMR',
                ),
                buildCoffeeItem(
                  'assets/Mocha.jpg',
                  'Mocha',
                  'Price: 1.200 OMR',
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
                        builder: (context) => SweetsPage(),
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