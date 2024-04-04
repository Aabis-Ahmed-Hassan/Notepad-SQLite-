import 'package:flutter/material.dart';
import 'package:sqlite/db_handler.dart';
import 'package:sqlite/modal_class.dart';

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
              await DBHandler().insertData(
                ModalClass(
                  id: x,
                  name: 'Inserted Name',
                  age: 12,
                ),
              );
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
              List<ModalClass> myList = await DBHandler().readData();
              print(myList[1].name);
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
                ModalClass(
                  id: x,
                  name: 'Updated Name',
                  age: 12,
                ),
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
