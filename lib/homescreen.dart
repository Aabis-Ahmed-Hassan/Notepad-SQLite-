import 'package:flutter/material.dart';
import 'package:sqlite/db_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Insert and Read Methods'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              x++;
              await DBHandler().insertData(
                  DateTime.now().millisecondsSinceEpoch, '$x$x$x$x$x$x', x);
            },
            child: Center(
              child: Text('Insert'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              List myList = await DBHandler().readData();
              print(myList);
            },
            child: Center(
              child: Text('Insert'),
            ),
          ),
        ],
      ),
    );
  }
}
