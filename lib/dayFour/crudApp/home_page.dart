import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/dayFour/crudApp/services/fire_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();

  //text controller
  final TextEditingController textController = TextEditingController();

  //open a dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //text user input
        content: TextField(controller: textController, autofocus: true),
        actions: [
          //button to save
          ElevatedButton(
            onPressed: () {
              //add ne note
              if (docID == null) {
                firestoreService.addNote(textController.text);
              }
              //update an exsisting note
              else {
                firestoreService.updateNote(docID, textController.text);
              }
              //clear the text controller
              textController.clear();

              //close the box
              Navigator.pop(context);
            },
            child: Text('add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        backgroundColor: Colors.deepPurple[200],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          //if we get data, get all docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                //get note from   each doc
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                //display  as a tile
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //update button
                      IconButton(
                        onPressed: () => openNoteBox(docID: docID),
                        icon: Icon(Icons.settings),
                      ),
                      //delete button
                      IconButton(
                        onPressed: () => firestoreService.deleteNote(docID),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } //if there is no data returning
          else {
            return const Text('No Notes....');
          }
        },
      ),
    );
  }
}
