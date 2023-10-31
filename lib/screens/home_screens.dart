import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:yoyo/services/database_helper.dart';
import 'package:yoyo/widget/model_widget.dart';

import '../db/model_notes.dart';
import 'add_screen.dart';

class homeScreens extends StatefulWidget {
  const homeScreens({super.key});

  @override
  State<homeScreens> createState() => _homeScreensState();
}

class _homeScreensState extends State<homeScreens> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Stack(
              children: [
                RiveAnimation.asset('assets/background.riv'),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                  child: FutureBuilder<List<Note>?>(
                    future: DatabaseHelper.getAllNote(),
                    builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return RiveAnimation.asset('assets/loading.riv');
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else if (snapshot.hasData) {
                        if (snapshot.data != null) {
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => NoteWidget(
                              note: snapshot.data![index],
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NoteScreen(
                                          note: snapshot.data![index],
                                        )));
                                setState(() {});
                              },
                              onLongPress: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor: Color(0XFF2f403d),
                                        title: Column(children: [
                                          Text(
                                            'Are you sure you want to delete this note?',style: TextStyle(color: Colors.white),),
                                          Align(alignment: Alignment.centerLeft,child: Container(height:70, width:70, child: RiveAnimation.asset('assets/remove_anim.riv'))),
                                        ],),
                                        actions: [
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color(0XFFf33b12))),
                                            onPressed: () async {
                                              await DatabaseHelper.deleteNote(
                                                  snapshot.data![index]);
                                              Navigator.pop(context);
                                              setState(() {});
                                            },
                                            child: const Text('Yes'),
                                          ),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                MaterialStateProperty.all(
                                                    Color(0XFFb8b435))),
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('No'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                            itemCount: snapshot.data!.length,
                          );
                        }
                        return const Center(
                          child: Text('No notes yet'),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                )
              ],
            )),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green.withAlpha(50),
          onPressed: () async {
            await Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const NoteScreen()));
            setState(() {});
          },
          label: Text('add notes'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
}
