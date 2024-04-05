
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Homepage"),
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
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('Add Money'),
              leading: Icon(Icons.money),
              onTap: () {

              },
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(Icons.offline_bolt),
              onTap: () {

              },
            ),
          ],
        ),
      ),

      /* floatingActionButton: FloatingActionButton(
          onPressed: (() => signout()), child: const Icon(Icons.login_rounded)),*/
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
