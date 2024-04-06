import 'package:flutter/material.dart';
import 'package:witty_indore/add_money.dart';

class Block {
  String name;

  Block(this.name); // Constructor with one positional argument
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  // Define a callback function to receive the updated list of blocks/categories
  void updateCategories(List<Block> updatedCategories) {
    // Update the list of categories
    // This function will be implemented in _HomePageState
  }
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  List<Block> categories = [
    Block('Food'),
    Block('Invest'),
    // Add more categories as needed
  ];

  double fakeMoney = 5000; // Fake money variable initialized with 5000
  bool isPaymentPopupOpen = false; // Track if payment popup is open

  void _openPaymentPopup(BuildContext context) {
    setState(() {
      isPaymentPopupOpen = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Category to Pay'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: categories.map((category) {
              return ListTile(
                title: Text(category.name),
                onTap: () {
                  // Add logic to initiate payment from selected category
                  Navigator.pop(context); // Close the pop-up
                  setState(() {
                    isPaymentPopupOpen = false;
                  });
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the pop-up
                setState(() {
                  isPaymentPopupOpen = false;
                });
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        actions: [
          IconButton(
            onPressed: () {
              _openPaymentPopup(context); // Call the method to open the pop-up
            },
            icon: Icon(Icons.scanner),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Settings'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Add Money'),
              leading: Icon(Icons.money),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddMoney()));
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(Icons.offline_bolt),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.blue, width: 2.0),
            ),
            child: Column(
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 8.0),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!isPaymentPopupOpen) // Conditionally display CircularProgressIndicator
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: fakeMoney / 5000,
                          strokeWidth: 10.0,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                    Text(
                      '₹${fakeMoney.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blueAccent,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.scanner),
            label: 'Scanner',
          ),
          NavigationDestination(
            icon: Icon(Icons.signal_cellular_0_bar),
            label: 'sign out',
          ),
        ],
      ),
    );
  }
}
