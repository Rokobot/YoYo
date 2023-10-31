import 'package:flutter/material.dart';


import '../db/model_notes.dart';


class NoteWidget extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const NoteWidget(
      {Key? key,
        required this.note,
        required this.onTap,
        required this.onLongPress})
      : super(key: key);




  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
        child: Card(
          color: Colors.yellow.withAlpha(50),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: ListTile(
              title: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  maxLines:1,
                  note.title!,
                  style: const TextStyle(
                    overflow: TextOverflow.fade,
                      fontSize: 40,color: Colors.white),
                ),
              ),
              subtitle: Text(maxLines:1,overflow: TextOverflow.fade,note.description!,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white)),
              trailing: Card(
                color: Colors.green.withAlpha(50),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(note.datetime.toString(), style: TextStyle(color: Colors.white),),
                  )),
            ) ,
          ),
        ),
      ),
    );
  }
}



