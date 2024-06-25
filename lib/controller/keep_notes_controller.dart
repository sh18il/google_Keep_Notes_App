import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase_1/model/model_keep_notes.dart';
import 'package:testfirebase_1/service/keep_notes_service.dart';

class KeepNotesController extends ChangeNotifier {
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController descpCtrl = TextEditingController();
  KeepNotesService service = KeepNotesService();
  Future<void> addNotes(model) async {
    await service.addData(model);
    notifyListeners();
  }

  submit(BuildContext context) async {
    final uId = FirebaseAuth.instance.currentUser?.uid;
    ModelKeepNotes datas = ModelKeepNotes(
        description: descpCtrl.text, title: titleCtrl.text, uId: uId);
    await addNotes(datas);
    Navigator.pop(context);
    notifyListeners();
  }

  Stream<QuerySnapshot<ModelKeepNotes>> getNotes(
      ModelKeepNotes model, String currentUserId) {
    return service.getUserData(model, currentUserId);
  }

  Future<void> deleteNote(String id) async {
    await service.deleteNotes(id);
    notifyListeners();
  }

  Future<void> updateNote(ModelKeepNotes model, String id) async {
    await service.updateData(model, id);
    notifyListeners();
  }

  clear() {
    titleCtrl.clear();
    descpCtrl.clear();
  }
}
