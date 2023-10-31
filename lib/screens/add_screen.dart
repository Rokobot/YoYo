import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';


import '../db/model_notes.dart';
import '../services/database_helper.dart';


class NoteScreen extends StatefulWidget {
  final Note? note;
  const NoteScreen({
    Key? key,
    this.note
  }) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    if(widget.note != null){
      titleController.text = widget.note!.title!;
      descriptionController.text = widget.note!.description!;
    }



    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(child: Stack(
        children: [
          RiveAnimation.asset('assets/background.riv'),

          BackdropFilter(filter: ImageFilter.blur(sigmaY: 100, sigmaX: 100),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //Close Icon
                  Align(alignment: Alignment.topLeft,child: IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.exit_to_app,color: Colors.white,size: 40,),),),
                  //SizedBox
                  SizedBox(height: 30,),
                  //Title
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        style: TextStyle(color:Colors.white, fontSize: 30),
                        controller: titleController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFF00ffcd), width: 0.3)
                          ),
                          filled: true,
                          fillColor: Color.fromRGBO(0, 0, 0, 0.5),
                          hintText: 'Title',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF00ffcd),
                            ),
                          ),),
                      ),
                    ),
                  ),
                  //Description
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        expands: true,
                        style: TextStyle(color:Colors.white, fontSize: 20),
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromRGBO(0, 0, 0, 0.5),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFF00ffcd), width: 0.3)
                          ),


                          hintText: 'Type here the note',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.4,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF00ffcd),
                            ),
                          ),),
                        keyboardType: TextInputType.multiline,
                        onChanged: (str) {},
                        maxLines: null,
                      ),
                    ),
                  ),
                ],),
            ),)
        ],
      ),),
      floatingActionButton: FloatingActionButton.extended(onPressed: () async {
        final title = titleController.value.text;
        final description = descriptionController.value.text;
        final time = DateFormat('y/MMMM/d').format(DateTime.now()).toString();

        if (title.isEmpty || description.isEmpty) {
          return;
        }

        final Note model = Note(title: title, description: description, id: widget.note?.id, datetime: time);
        if(widget.note == null){
          await DatabaseHelper.addNote(model);
        }else{
          await DatabaseHelper.updateNote(model);
        }
        Navigator.pop(context);
      }, label: Text('save', style: TextStyle(fontSize: 20),),backgroundColor: Colors.green.withAlpha(50)),
    );
  }
}
