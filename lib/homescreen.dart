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
          //insert
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
              ),
            ),
            onPressed: () async {
              x++;
              await DBHandler().insertData(x, 'Member $x', x * x);
            },
            child: Center(
              child: Text(
                'Insert',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          //read
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
              ),
            ),
            onPressed: () async {
              List myList = await DBHandler().readData();
              print(myList);
            },
            child: Center(
              child: Text(
                'Read',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          //update
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
              ),
            ),
            onPressed: () async {
              await DBHandler().updateData(
                {'id': 1, 'name': 'Aabis Ahmed Hassan', 'age': 18},
              );
              print('data updated');
            },
            child: Center(
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          //delete
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.blue,
              ),
            ),
            onPressed: () async {
              await DBHandler().deleteData(2);
              print('data deleted');
            },
            child: Center(
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
