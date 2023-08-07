import 'package:flutter/material.dart';

import 'package:notesample/data/data.dart';
import 'package:notesample/note_model/note_model.dart';

enum ActionType {
  addNote,
  editNote,
}

class SreenAddNote extends StatelessWidget {
  final ActionType type;
  final String? id;
  SreenAddNote({required this.type, this.id});

  Widget get saveButton => TextButton.icon(
        onPressed: () {
          switch (type) {
            case ActionType.addNote:
              saveNote();
              break;
            case ActionType.editNote:
              editNote();
              break;
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: const Text(
          'save',
          style: TextStyle(color: Colors.white),
        ),
      );
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  final _scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(type.name.toUpperCase()),
        actions: [
          saveButton,
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'title',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              maxLength: 100,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'content',
              ),
            ),
          ],
        ),
      )),
    );
  }

  Future<void> saveNote() async {
    final _title = _titleController.text;
    final _content = _contentController.text;
    print(_content);

    final _newNote = NoteModel.create(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: _title,
      content: _content,
    );
    final savedNote = await NoteDB().createNote(_newNote);
    if (savedNote != null) {
      print("saved");
      Navigator.of(_scaffoldkey.currentContext!).pop();
      NoteDB.instance.getAllNote();
    } else {
      print("not saved");
    }
  }

  Future<void> editNote() async {
    print(id);
    final updateModel = NoteModel(
        id: id, title: _titleController.text, content: _contentController.text);
    // final updateModelResult = await NoteDB.instance.updateNote(updateModel);
    final savedNote = await NoteDB().updateNote(updateModel);
    print("enda ppo sambavam");
    print(savedNote);
    //Navigator.of(_scaffoldkey.currentContext!).pop();
    if (savedNote != null) {
      print("saved");
      Navigator.of(_scaffoldkey.currentContext!).pop();
      NoteDB.instance.getAllNote();
    } else {
      print("not saved");
    }
    NoteDB.instance.getAllNote();
  }
}
