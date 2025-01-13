
import 'package:dropdown_search/dropdown_search.dart';
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
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:math_matters/Feedbacks.dart';
import 'package:math_matters/main.dart';
import 'package:math_matters/schudule.dart';
import 'HomePage.dart';
import 'schudule.dart';
import 'profile.dart';
import 'Attendance.dart';
class Feedbacks extends StatefulWidget {
  Feedbacks({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.


  final String title;

  @override
  _FeedbacksState createState() => _FeedbacksState();
}

 class _FeedbacksState extends State<Feedbacks> {
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
  final List<String> items = [];


  var maxlines = 10;
  var timestamp = DateTime
      .now()
      .millisecondsSinceEpoch
      .toString();
  List newComments = [];

  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseDatabase.instance.ref().child('users/' + FirebaseAuth.instance.currentUser!.uid ).once().then((result){
      Map map = result.snapshot.value as Map;
      _currentSugars = map["Name"];
    });
    FirebaseDatabase.instance.ref().child("Student").once().then((
        result) {
      List<String> codelistfromfb = [];


      Map map = result.snapshot.value as Map;
      map.forEach((key,value) {
        print(key);
        print(value);

        codelistfromfb.add(key.toString());
      });

      names = codelistfromfb;
      newnames = (names as List<String>?)!;
      print(names);
      print(newnames);
      print("newnames");


      // refresh the UI - ListView based on the new data
      setState(() {

      });
    }).catchError((e) {
      print('failedfalided');
      print(e);

    });
    int number = 0;
    Future.delayed(const Duration(milliseconds: 1000), () {
      String wordPair = "";
      while (number < newnames.length) {
        print(newnames[number]);
        print("ey it worked");
        items.add(newnames[number]);
        number++;
        print(items);
        setState(() {

        });




      };

// Here you can write your code


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
        body: Center(
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


              Container(
                margin: EdgeInsets.only(top: 100),
                child: DropdownSearch(
                  items: items,
                  selectedItem: _currentSugars,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select One",
                      hintText: "Students",
                    ),
                  ),

                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value.toString();
                    });
                  },
                  //isExpanded: true,
                ),
              ),

              ElevatedButton(onPressed: () {
                FirebaseDatabase.instance.ref().child(
                    "Student/" + _currentSugars + "/ContentTracking")
                    .once()
                    .then((result) {
                  List<String> codelistfromfb = [];
                  dates = [];
                  newComments = [] ;
                  Map map = result.snapshot.value as Map;

                  print(result.snapshot.value);
                  print("that is result");


                  map.forEach((key, value) {
                    print(value);
                    print(value);
                    print(key + 'key');
                    dates.add(key.toString());


                    codelistfromfb.add(value);
                  });

                  List comments = codelistfromfb;
                  newComments = (comments as List<String>?)!;
                  print(comments.toString());
                  print(newComments.toString());
                  print("newComments");

                  if(newComments == null){


                    newComments[0] = "No Results Found";
                  }
                  Future.delayed(const Duration(milliseconds: 1),(){
                     reversedList =  List.from(newComments.reversed);
                     reverseddates = List.from(dates.reversed);
                     print(reversedList);
                  });
                  Future.delayed(const Duration(milliseconds: 2),(){
                    setState(() {

                    });
                  });


                  // refresh the UI - ListView based on the new data
                  setState(() {

                  });
                }).catchError((e) {
                  dates.add("Error");

                    newComments.add("No Results Found");

                  print(newComments);
                  print('failedfalided');
                  print(e);
                    setState(() {

                    });
                });
                setState(() {

                });
              }, child: Text("View Entries")),

              Expanded(child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: reversedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),


                      height: 100,
                      color: Colors.white10,
                      child: Expanded(


                        child: Center(child: Row(
                          children: [
                            Text(reverseddates[index].toString()),
                            Text(":"),
                            Text(reversedList[index].toString()),
                            Text("  "),



                          ],
                        )),
                      ),
                    );
                  }


              ),)
            ],
          ),
        ),
        //
      );
    }


  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

