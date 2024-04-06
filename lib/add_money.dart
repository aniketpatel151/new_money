import 'package:flutter/material.dart';

class Block {
  String name;
  double money;

  Block(this.name, this.money);
}

class AddMoney extends StatefulWidget {
  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  List<Block> blocks = [
    Block('Food', 0),
    Block('Invest', 0),
  ];

  TextEditingController _blockNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Management App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.green,
        fontFamily: 'Roboto',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Finance Management'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.blue,
              child: Text(
                'Categories',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: blocks.length,
                itemBuilder: (context, index) {
                  return _buildCategoryRow(blocks[index]);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showAddBlockDialog(context);
              },
              child: Text(
                'Add Block',
                style: TextStyle(fontSize: 16.0),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(Block block) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            block.name,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () {
              _showAddMoneyDialog(context, block);
            },
            child: Text(
              'Add Money',
              style: TextStyle(fontSize: 16.0),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          Text(
            '₹${block.money.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }

  Future<void> _showAddMoneyDialog(BuildContext context, Block block) async {
    TextEditingController _moneyController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Money to ${block.name}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _moneyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Amount'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                _moneyController.clear();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                double amount = double.tryParse(_moneyController.text) ?? 0.0;
                if (amount <= 0) {
                  // Show an error message if amount is not valid
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter a valid amount'),
                  ));
                } else {
                  // Perform the payment logic here
                  // For demonstration, just print a message and update the block's money
                  print('Payment successful! Amount: $amount');
                  setState(() {
                    block.money += amount;
                  });
                  _moneyController.clear();
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddBlockDialog(BuildContext context) async {
    TextEditingController _blockNameController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Block'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _blockNameController,
                  decoration: InputDecoration(labelText: 'Block Name'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                setState(() {
                  blocks.insert(
                      blocks.length - 1, Block(_blockNameController.text, 0));
                  _blockNameController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                _blockNameController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(AddMoney());
}
