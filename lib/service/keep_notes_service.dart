import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testfirebase_1/model/model_keep_notes.dart';

class KeepNotesService {
  String refrence = "keepNote";
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference<ModelKeepNotes> postData =
      firestore.collection(refrence).withConverter<ModelKeepNotes>(
            fromFirestore: (snapshot, options) =>
                ModelKeepNotes.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, options) => value.toJson(),
          );

  Future<void> addData(ModelKeepNotes model) async {
    try {
      await postData.add(model);
    } catch (e) {}
  }

  // Stream<QuerySnapshot<ModelKeepNotes>> getNotes() {
  //   return postData.snapshots();
  // }

  Future<void> deleteNotes(String id) async {
    try {
      await postData.doc(id).delete();
    } catch (e) {}
  }

  Future<void> updateData(ModelKeepNotes model, String id) async {
    try {
      await postData.doc(id).update(model.toJson());
    } catch (e) {}
  }

  Stream<QuerySnapshot<ModelKeepNotes>> getUserData(
      ModelKeepNotes model, String currentUserId) {
    try {
      if (model.uId == currentUserId) {
        return postData
            .where('uId', isEqualTo: currentUserId)
            .snapshots();
      } else {
        return Stream<QuerySnapshot<ModelKeepNotes>>.empty();
      }
    } on FirebaseException catch (e) {
       return throw Exception(e);
     //  showErrorMessage(context, "error$e")
    }
  }

  void showErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
