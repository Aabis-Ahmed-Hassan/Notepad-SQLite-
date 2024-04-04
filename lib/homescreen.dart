import 'package:flutter/material.dart';
import 'package:sqlite/db_handler.dart';
import 'package:sqlite/modal_class.dart';

import 'add_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text('SQLite'),
      ),
      body: FutureBuilder(
        future: DBHandler().readData(),
        builder: (context, AsyncSnapshot<List<ModalClass>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    snapshot.data![index].name +
                        '     ' +
                        snapshot.data![index].id.toString(),
                  ),
                  subtitle: Text(
                    snapshot.data![index].age.toString(),
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      await DBHandler().deleteData(
                        int.parse(
                          snapshot.data![index].id.toString(),
                        ),
                      );
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddData(),
            ),
          );
        },
        child: Center(
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
