import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase_1/controller/keep_notes_controller.dart';
import 'package:testfirebase_1/model/model_keep_notes.dart';

class EditPage extends StatelessWidget {
  String? title;
  String? description;
  dynamic id;
  EditPage({super.key, this.title, this.description, required this.id});
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descrpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleCtrl = TextEditingController(text: title);
    descrpCtrl = TextEditingController(text: description);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Gap(10),
                    TextFormField(
                      controller: descrpCtrl,
                      maxLines: 5,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Gap(20),
                    ElevatedButton(
                        onPressed: () {
                          updateData(context);
                        },
                        child: Text("Update"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  updateData(context) async {
    final provider = Provider.of<KeepNotesController>(context, listen: false);
    final uId = FirebaseAuth.instance.currentUser?.uid;
    ModelKeepNotes data = ModelKeepNotes(
        description: descrpCtrl.text, title: titleCtrl.text, uId: uId);
    await provider.updateNote(data, id);
    Navigator.pop(context);
  }
}
