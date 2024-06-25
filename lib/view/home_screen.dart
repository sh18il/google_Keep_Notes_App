import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase_1/controller/keep_notes_controller.dart';
import 'package:testfirebase_1/model/model_keep_notes.dart';

import 'package:testfirebase_1/view/addnotes.dart';
import 'package:testfirebase_1/view/edit_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeepNotesController>(context, listen: false);
    final uId = FirebaseAuth.instance.currentUser?.uid;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        elevation: 7,
        shape: CircleBorder(),
        child: ClipOval(
          child: Image.asset(
            "assets/image/png-transparent-plus-gradient-color-3d-icon.png",
            fit: BoxFit.cover,
            width: 56.0,
            height: 56.0,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Addnotes(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: Icon(Icons.login_outlined))
        ],
      ),
      body: StreamBuilder(
        stream: provider.getNotes(ModelKeepNotes(uId: uId), uId ?? ""),
        builder:
            (context, AsyncSnapshot<QuerySnapshot<ModelKeepNotes>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot<ModelKeepNotes>> notesData =
                snapshot.data?.docs ?? [];
            if (notesData.isEmpty) {
              return Center(
                child: Text('No notes available.'),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 0.95,
              ),
              itemCount: notesData.length,
              itemBuilder: (context, index) {
                final data = notesData[index].data();
                final id = notesData[index].id;
                return Padding(
                  padding: const EdgeInsets.all(3),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditPage(
                          title: data.title,
                          description: data.description,
                          id: id,
                        ),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 49, 48, 46),
                          border: Border.all(
                              color: const Color.fromARGB(255, 104, 102, 102))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: PopupMenuButton(
                              color: const Color.fromARGB(255, 29, 28, 28),
                              onSelected: (value) {
                                if (value == "delete") {
                                  provider.deleteNote(id);
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                      value: 'delete',
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ))
                                ];
                              },
                            ),
                          ),
                          Text(
                            data.title.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Gap(10),
                          Text(
                            data.description.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }
}
