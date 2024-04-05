import 'package:flutter/material.dart';
import 'package:sqlite/modals/modal.dart';
import 'package:sqlite/utils/db_helper.dart';
import 'package:sqlite/utils/utils.dart';

import '../utils/constants.dart';
import 'home_screen.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  DBHelper _db = DBHelper();

  @override
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
          icon: Icon(Icons.keyboard_arrow_left),
          color: Colors.white,
        ),
        title: Text(
          'Add Note',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter your title',
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _subtitleController,
              decoration: InputDecoration(
                hintText: 'Enter your note',
              ),
            ),
            SizedBox(height: 35),
            InkWell(
              onTap: () async {
                await _db
                    .insertData(
                  ModalClass(
                    title: _titleController.text,
                    subtitle: _subtitleController.text,
                  ),
                )
                    .then((value) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                }).onError((error, stackTrace) {
                  Utils.showSnackBar(context, 'An Error Occurred');
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
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
