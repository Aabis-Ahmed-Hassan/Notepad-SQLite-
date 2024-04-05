import 'package:flutter/material.dart';
import 'package:sqlite/modals/modal.dart';
import 'package:sqlite/utils/db_helper.dart';
import 'package:sqlite/utils/utils.dart';

import '../utils/constants.dart';
import 'add_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper _db = DBHelper();

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          // 'Notepad',
          'SQLite',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 5000), () {
            setState(() {});
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: _db.readData(),
                  builder: (context, AsyncSnapshot<List<ModalClass>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 7,
                          margin: EdgeInsets.only(
                            top: 25,
                            right: 10,
                            left: 10,
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            selectedColor: Colors.grey,
                            title: Text(
                              snapshot.data![index].title.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Text(snapshot.data![index].subtitle),
                            trailing: PopupMenuButton(itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  onTap: () {
                                    updateData(
                                        snapshot.data![index].title,
                                        snapshot.data![index].subtitle,
                                        snapshot.data![index].id!);
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                      ),
                                      SizedBox(width: 9),
                                      Text(
                                        'Edit',
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    await _db
                                        .deleteData(snapshot.data![index].id!)
                                        .then((value) {
                                      Utils.showSnackBar(
                                          context, 'Deleted Successfully');
                                      // setState(() {});
                                    });
                                    setState(() {});
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                      ),
                                      SizedBox(width: 9),
                                      Text(
                                        'Delete',
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            }),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 12.5),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddData(),
            ),
          );
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  updateData(String previousTitle, String previousSubtitle, int id) {
    return showDialog(
      context: context,
      builder: (context) {
        _titleController.text = previousTitle;
        _subtitleController.text = previousSubtitle;
        return AlertDialog(
          title: Text('Update'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
              ),
              TextFormField(
                controller: _subtitleController,
                decoration: InputDecoration(
                  label: Text('Note'),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _db
                    .updateData(
                  ModalClass(
                    id: id,
                    title: _titleController.text,
                    subtitle: _subtitleController.text,
                  ),
                )
                    .then((value) {
                  setState(() {});

                  Navigator.pop(context);
                  _titleController.text = '';
                  _subtitleController.text = '';
                }).onError((error, stackTrace) {
                  Utils.showSnackBar(context, 'Error');
                  Navigator.pop(context);
                });
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
