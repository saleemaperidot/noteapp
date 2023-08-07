import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesample/addNote.dart';
import 'package:notesample/data/data.dart';
import 'package:notesample/noteItem.dart';
import 'package:notesample/note_model/note_model.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteDB.instance.getAllNote();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: NoteDB.instance.noteListNotifier,
        builder: (context, List<NoteModel> newNotes, _) {
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: EdgeInsets.all(20),
            children: List.generate(newNotes.length, (index) {
              final _note = NoteDB.instance.noteListNotifier.value[index];
              if (_note.id == null) {
                const SizedBox();
              }
              return NoteItem(
                id: _note.id!,
                title: _note.title ?? 'No tittle',
                content: _note.content ?? 'No content',
              );
            }),
          );
        },
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => SreenAddNote(
                    type: ActionType.addNote,
                  )));
        },
        label: const Text("Add Note"),
      ),
    );
  }
}
