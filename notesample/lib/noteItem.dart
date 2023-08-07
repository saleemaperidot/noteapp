import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesample/addNote.dart';
import 'package:notesample/data/data.dart';

class NoteItem extends StatelessWidget {
  final String id;
  final String title;
  final String content;
  const NoteItem(
      {required this.id, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => SreenAddNote(
                  type: ActionType.editNote,
                  id: id,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        padding: EdgeInsets.all(5),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
              IconButton(
                onPressed: () {
                  NoteDB().deleteNote(id);
                  //print(id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          ),
          Text(
            content,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.black, fontSize: 14),
          )
        ]),
      ),
    );
  }
}
