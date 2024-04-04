import 'package:flutter/material.dart';
import 'package:sqlite/db_handler.dart';
import 'package:sqlite/homescreen.dart';
import 'package:sqlite/modal_class.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  bool loading = false;
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Add Data'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Enter your name'),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(hintText: 'Enter your age'),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  loading = true;
                });
                await DBHandler()
                    .insertData(
                  ModalClass(
                    name: _nameController.text,
                    age: int.parse(_ageController.text),
                  ),
                )
                    .then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }).onError((error, stackTrace) {
                  print(error);
                });
                setState(() {
                  loading = false;
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(
                    15,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Add',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
