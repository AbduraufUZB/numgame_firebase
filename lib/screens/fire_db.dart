import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFireDb extends StatefulWidget {
  const MyFireDb({Key? key}) : super(key: key);

  @override
  State<MyFireDb> createState() => _MyFireDbState();
}

class _MyFireDbState extends State<MyFireDb> {
  final FirebaseFirestore fireStrore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: (){}, child: Text("Read From Firestore")),
          ElevatedButton(onPressed: (){}, child: Text("Write to Firestrore Db")),
          ElevatedButton(onPressed: (){}, child: Text("Update Firestore")),
        ],
      ),
    );
  }
}
