import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/dayThree/userDetails/Read%20Data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  //Document IDs
  List<String> docIDs = [];

  //get IDs
  Future getDocID() async {
    docIDs.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('age', descending: true)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        title: Text(user?.email ?? '', style: TextStyle(fontSize: 20)),
        actions: [
          GestureDetector(
            onTap: () => {FirebaseAuth.instance.signOut()},
            child: Icon(Icons.logout_outlined, size: 36),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocID(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: ListTile(
                          title: GetUserName(documentId: docIDs[index]),
                          tileColor: Colors.grey[300],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
