import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterall/component/stream_note.dart';
import 'package:flutterall/todolist/add_note_screen.dart';
import 'package:flutterall/todolist/todolist.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

class LoginSucessPage extends StatefulWidget {
  LoginSucessPage({super.key});

  @override
  State<LoginSucessPage> createState() => _LoginSucessPageState();
}

class _LoginSucessPageState extends State<LoginSucessPage> {
  final user = FirebaseAuth.instance.currentUser;

  bool show = true;

  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    const MyApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title : Text(
          'Task management',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle : Theme.of(context).textTheme.displayLarge,
            fontSize: 24,
            fontStyle : FontStyle.normal,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: signOutUser,
            icon: const Icon(Icons.login, size:30,),
          )
        ],
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward){
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false ; 
              });
            }
            return true;
          },
          child: Column(
            children: [
              StreamNote(false),
              const Text(
                'isDone',
                style: TextStyle(color: Colors.green),
              ),
              StreamNote(true),
            ],
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>AddNoteScreen())
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add , size: 30, color: Colors.white,),
      ),
    );
  }
}