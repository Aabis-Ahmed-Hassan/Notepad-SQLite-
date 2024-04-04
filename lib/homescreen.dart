import 'package:flutter/material.dart';
import 'package:sqlite/db_handler.dart';
import 'package:sqlite/modal_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter Your Name',
            ),
          ),
          TextFormField(
            controller: _ageController,
            decoration: InputDecoration(
              hintText: 'Enter Your Age',
            ),
          ),
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
                  name: _nameController.text,
                  age: int.parse(_ageController.text),
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
              int y = 2;
              print(myList[y].id);
              print(myList[y].name);
              print(myList[y].age);
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
