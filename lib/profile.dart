import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:math_matters/StudentNavigation.dart';
import 'package:math_matters/directorbottom.dart';
import 'package:math_matters/main.dart';
import 'package:math_matters/schudule.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'HomePage.dart';
import 'schudule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BottomNavigation.dart';
import 'package:firebase_database/firebase_database.dart';
class profile extends StatefulWidget {
  profile({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  TextEditingController _controller = new TextEditingController();
  String dropdownValue = 'Student';
  TextEditingController NameController1 = new TextEditingController();
  final TextEditingController searchController = TextEditingController();
  var elementSearched = false;
  int _counter = 0;
  var _selectedIndex = 1;
  String Typetest = "";
  int length = 0;
  int ha = 0;
  var kidsBooks;
  late List<String> items;
  final List<String> item = [];
  var dropdownitems = null;
  String _currentSugars = "";
  int schools = 0;
  Widget day2 = SizedBox();
  bool isdirector = false;


  late List<Widget> _widgetoption;
  TextEditingController SchoolController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController GradeController = TextEditingController();
  String LockType = "false";


  String LockGrade = "false";
  String LockDay = "false";

  String currentSearchText = "";

  String name = "";
  late String _now;
  late Timer _everySecond;
  void initState() {



  print(FirebaseAuth.instance.currentUser!.uid + "uid");
    FirebaseDatabase.instance.ref().child("users/" + FirebaseAuth.instance.currentUser!.uid).once().then((value)
    {
      print(FirebaseAuth.instance.currentUser?.uid);
      print("was able to start call");
      Map list = value.snapshot.value as Map;
      print("was able to continue call");

      print(list);

      dropdownValue = list['type'];
      print(list["School"].toString());
      print(list);
      if(list["School"] != null){
        _currentSugars = list['School'];
        print(_currentSugars + "schol");

      }
      if(list['type'] == null){
        print(list['type'] + "ITS NOT NULL");
        LockType = "true";
        dropdownitems = <String>['Student', 'Tutor', 'Co-Director']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })
            .toList();
      }else{
        dropdownitems = <String>[list['type']]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        })
            .toList();
      }
      if(list['Grade'] == null){
        LockGrade = "true";
      }else{
        GradeController.text = list['Grade'];

        LockGrade = "false";
      }
      if(list['Day'] == null){
        LockDay = "true";
      }else{
        NameController.text = list['Day'];

        LockDay = "false";
      }
      print(dropdownValue + 'test');
      if(dropdownValue.contains('irector')){
        isdirector == true;
      }

      name = list['Name'];



    }

    ).catchError((e){
      print(e.toString() + "erroee");
    });


    FirebaseDatabase.instance.ref().child("schools").once().then((value){
      print(value.snapshot.value);
      items = [];
      List list = value.snapshot.value as List;
      for(int i =0; i<list.length; i++){
        print(i);

        items.add(list[i].toString());
      }
      print(items.toString());


    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      items = items;
      print(items.toString() + "original items");
      print(items.length);
      for(int i = 0; i<items.length; i++){
        print(items[i] + "original item");

        // item.add(DropdownMenuItem(
        //   child: Text(items[i]),
        //   value: items[i],
        // ));
        item.add(items[i].toString());
        print(items[i] + "erroed there");


      }
      print(item.toString() + "items");
      setState(() {

      });
      searchController.addListener(() {
        String searchText = searchController.text.trim();
        if (searchText.isNotEmpty && !items.contains(searchText)) {
          setState(() {
            // Remove any previously added custom option
            item.removeWhere((element) => !items.contains(element));
            // Add the new school option
            item.add(searchText);
          });
        }
      });

    });







  }



  @override


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
    print(dropdownValue);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

        Container(margin:EdgeInsets.only(top:50),child: Text('Profile', style: TextStyle(fontSize: 50),)),
        DropdownButton<String>(
          value: dropdownValue,

          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: const TextStyle(
              color: Colors.deepPurple
          ),
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              print(dropdownValue + "hihihii");
            });
          },
          items:dropdownitems ,
        ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: DropdownSearch(
                items: item,
                selectedItem: _currentSugars,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    labelText: "Select One",
                    hintText: "country in menu mode",
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSearchBox: true,  // Enables the search box within the dropdown menu.
                  searchFieldProps: TextFieldProps(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for a school...',

                    ),

                  ),

                ),
                onChanged: (value){
                  print(items);
                  items.add(value);
                  print('changed');
                },


                // onChanged: (value) {
                //   print(value.toString());
                //   String textdia = currentSearchText;
                //   if(textdia == null){
                //     textdia = "";
                //   }
                //
                //     setState(() {
                //       item.add(
                //           textdia
                //       );
                //
                //       _currentSugars = value!;
                //     });
                //
                //
                //
                // },
                // asyncItems: (String string){
                //   setState(() {
                //     currentSearchText = string
                //
                //
                //   });
                //
                //
                // },
                enabled: true,
              ),
            ),

            // Container(
            //   margin: EdgeInsets.all(10),
            //   child: TextField(
            //     controller: SchoolController,
            //     obscureText: false,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'School',
            //     ),
            //   ),
            // ),
            // Row(
            //   children: <Widget>[
            //     Expanded(
            //         child: new TextField(controller: _controller)
            //     ),
            //     PopupMenuButton<String>(
            //       icon: const Icon(Icons.arrow_drop_down),
            //       onSelected: (String value) {
            //         _controller.text = value;
            //       },
            //       itemBuilder: (BuildContext context) {
            //         return items.map<PopupMenuItem<String>>((String value) {
            //           return new PopupMenuItem(child: new Text(value), value: value);
            //         }).toList();
            //       },
            //     ),
            //   ],
            // ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: GradeController,
                obscureText: false,
                readOnly: (LockGrade == "true") ?false :true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Grade',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: NameController,
                obscureText: false,
                readOnly: (LockDay == "true") ? false : true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Assigned Day',
                ),
              ),
            ),
            day2,
            // TextButton(onPressed:(){
            //   day2 = Container(
            //     margin: EdgeInsets.all(10),
            //     child: TextField(
            //       controller: NameController1,
            //       obscureText: false,
            //       decoration: InputDecoration(
            //         border: OutlineInputBorder(),
            //         labelText: 'Second Assigned Day',
            //       ),
            //     ),
            //   );
            //   setState(() {
            //
            //   });
            // }, child: Text('+ Add more days')),
            ElevatedButton(onPressed: (){
              print('Print');
              if(dropdownValue=="Co-Director"&&isdirector==true){
                FirebaseDatabase.instance.ref().child("users/" + FirebaseAuth.instance.currentUser!.uid.toString()).update(
                    {
                      "Grade" : GradeController.text,
                      "Day" : NameController.text,

                      "School" : _currentSugars,
                      "type" : dropdownValue
                    }
                ).then((value) {
                  // go back to Login screen
                  print("sucess");

                }).catchError((e){
                  print("Failed to save the user information." + e.toString());
                });
                if(NameController1.text != null){
                  FirebaseDatabase.instance.ref().child("Co-Director/" + name).update({
                    "Second Day" : NameController1.text,
                  });
                }
                FirebaseDatabase.instance.ref().child("Co-Director/" + name).update(
                    {
                      "Grade" : GradeController.text,
                      "Day" : NameController.text,
                      "School" : _currentSugars
                    }
                ).then((value) {
                  // go back to Login screen

                  print("sucess");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => directorNavigation(title: 'Home')),
                  );
                }).catchError((e){
                  print("Failed to save the user information." + e.toString());
                });
              }
              if (dropdownValue == "Tutor"||dropdownValue=="Co-Director"&&isdirector==false)[
              FirebaseDatabase.instance.ref().child("users/" + FirebaseAuth.instance.currentUser!.uid.toString()).update(
              {
              "Grade" : GradeController.text,
              "Day" : NameController.text,

              "School" : _currentSugars,
              "type" : "Tutor"
              }
              ).then((value) {
              // go back to Login screen
              print("sucess");

              }).catchError((e){
              print("Failed to save the user information." + e.toString());
              }),
              if(NameController1.text != null){
              FirebaseDatabase.instance.ref().child("tutors/" + name).update({
              "Second Day" : NameController1.text,
              }).then((value){

              })
              },
              FirebaseDatabase.instance.ref().child("tutors/" + name).update(
              {
              "Grade" : GradeController.text,
              "Day" : NameController.text,
              "School" : _currentSugars
              }
              ).then((value) {
              // go back to Login screen

              print("sucess");
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => drawer(title: 'Home')),
              );
              }).catchError((e){
              print("Failed to save the user information." + e.toString());
              })

              ];
              // ignore: unnecessary_statements

              if (dropdownValue.contains('tud') )[
              FirebaseDatabase.instance.ref().child("users/" + FirebaseAuth.instance.currentUser!.uid.toString()).update(
              {
              "Grade" : GradeController.text,
              "Day" : NameController.text,

              "School" : _currentSugars,
              "type" : dropdownValue
              }
              ).then((value) {
              // go back to Login screen
              print("sucess");

              }).catchError((e){
              print("Failed to save the user information." + e.toString());
              }),
              if(NameController1.text != null){
              FirebaseDatabase.instance.ref().child("Co-Director/" + name).update({
              "Second Day" : NameController1.text,
              }),
              },
                FirebaseDatabase.instance.ref().child("Student/" + name).update(
                    {
                      "Grade" : GradeController.text,
                      "Day" : NameController.text,
                      "School" : _currentSugars
                    }
                ).then((value) {
                  // go back to Login screen
                  print("sucess");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StudentNav(title: 'Home')),
                  );
                }).catchError((e){
                  print("Failed to save the user information." + e.toString());
                })

              ];





            }, child: Text('Save')),

          ],
        ),
      ),
      //
    );

  }
}
