import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isVisible = false;

  List<int> randoms =
      List.generate(9, (index) => Random().nextInt(50)).toList();
  List myBool = List.generate(9, (index) => false);
  List checkList = [];
  List<int> randSort = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              },
              icon: Icon(Icons.exit_to_app)),
          IconButton(
              onPressed: () async {
                await auth.currentUser!.delete();
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              },
              icon: Icon(Icons.delete)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 15),
                itemBuilder: (ctx, i) {
                  return InkWell(
                    onTap: () {
                      check(i);
                      myBool[i] = true;
                      setState(() {});
                    },
                    child: CircleAvatar(
                        child: Text(randoms[i].toString())),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Text("START",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                  onTap: () async {
                    
                    /*randSort.clear();
                    isVisible = true;
                    for (var i = 0; i < 9; i++) {
                      myBool[i] = true;
                    }
                    Future.delayed(const Duration(seconds: 5)).then((value) {
                      isVisible = false;
                      for (var i = 0; i < 9; i++) {
                        myBool[i] = false;
                      }
                      randoms =
                          List.generate(9, (index) => Random().nextInt(50))
                              .toList();
                      randSort = randoms;
                      randSort.sort();
                      print(randSort);
                      setState(() {});
                    });
                    setState(() {});*/
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  check(int index) {
    int l = 0;
    checkList.add(randoms[index]);
    for (var i = 0; i < checkList.length; i++) {
      if (randSort[i] == checkList[i]) {
        l += 1;
      }
    }
    if (l != checkList.length) {
      showMySnackBar("Kalla ekansan", Colors.red);
    }
    if (l == randoms.length) {
      showMySnackBar("Mujik bratishka", Colors.green);
    }
  }

  showMySnackBar(String content, Color color) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: color,
    ));
  }
}
