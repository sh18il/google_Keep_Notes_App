import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:testfirebase_1/controller/keep_notes_controller.dart';

class Addnotes extends StatelessWidget {
  Addnotes({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeepNotesController>(context, listen: false);
    return SafeArea(
      child: PopScope(
        canPop: true,
        onPopInvoked: (didPop) => provider.clear(),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Padding(
            padding: const EdgeInsets.all(5),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: provider.titleCtrl,
                    decoration: InputDecoration(
                      label: Text("Title"),
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Gap(10),
                  TextFormField(
                    maxLines: 5,
                    controller: provider.descpCtrl,
                    decoration: InputDecoration(
                        label: Text("Note"), border: OutlineInputBorder()),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Gap(20),
                  ElevatedButton(
                      onPressed: () {
                        provider.submit(context);
                      },
                      child: Text("Submit"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
