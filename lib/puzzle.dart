import 'package:flutter/material.dart';
import 'package:math_matters/login%20page.dart';
import 'HomePage.dart';
import 'BottomNavigation.dart';
import 'login page.dart';
import 'Signup.dart';
import 'package:firebase_core/firebase_core.dart';
import '';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:math_matters/Feedbacks.dart';
import 'package:math_matters/main.dart';
import 'package:math_matters/schudule.dart';
import 'HomePage.dart';
import 'schudule.dart';
import 'profile.dart';
import 'Attendance.dart';
class puzzle extends StatefulWidget {
  puzzle({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.


  final String title;

  @override
  _puzzleState createState() => _puzzleState();
}

class _puzzleState extends State<puzzle> {
  int _counter = 99713965;
  TextEditingController name = TextEditingController();
  String selectedValue = " ";
  String dropdownValue = 'Bright';
  List names = [];
  List<String> newnames = ['hi'];
  List<String> test = ['hi'];
  String _currentSugars = "";
  List<String> dates = [];
  var reversedList = [];
  var reverseddates = [];
  final List<DropdownMenuItem> items = [];
  Widget answer = SizedBox();
  Widget question = SizedBox();
  Widget aAnswer = SizedBox();


  var maxlines = 10;
  var timestamp = DateTime
      .now()
      .millisecondsSinceEpoch
      .toString();
  List newComments = [];

  void initState() {
    // TODO: implement initState
    super.initState();


    FirebaseDatabase.instance.ref().child('dailypuzzles/day1').once().then((value){
      Map map = value.snapshot.value as Map;
      map.forEach((key, value){
        print(key + value + "keyvalue");
        if(key.toString().contains('a')){
          answer = Image(
            image: NetworkImage(value.toString()),
          );
      }
        if(key.toString().contains('q')){
          question = Image(
            image: NetworkImage(value.toString()),
          );
        }
      });
      Future.delayed(const Duration(microseconds: 10),(){
        setState(() {

        });
      });
    });





  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }


  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //


    return Scaffold(
      //backgroundColor: Color(0xff00104e),
      body: SingleChildScrollView(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(child: Text('Puzzle of the Day')),
            question,
            Container(
              child: ElevatedButton(
                child: Text('Show Answer'),
                onPressed: (){
                  aAnswer = answer;
                      setState(() {

                      });
                },
              ),
            ),


            aAnswer,
          ],
        ),
      ),
      //
    );
  }


  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

