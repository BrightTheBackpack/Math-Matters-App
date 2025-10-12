import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:math_matters/StudentNavigation.dart';
import 'package:math_matters/main.dart';
import 'package:math_matters/schudule.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'HomePage.dart';
import 'schudule.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'BottomNavigation.dart';
import 'package:firebase_database/firebase_database.dart';
class hourcounter extends StatefulWidget {
  hourcounter({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _hourcounterState createState() => _hourcounterState();
}

class _hourcounterState extends State<hourcounter> {

  String dropdownValue = 'Student';
  int _counter = 0;
  var _selectedIndex = 1;
  Color button = Colors.blue;
  var kidsBooks;
  late List<String> items;
  final List<DropdownMenuItem> item = [];
  String _currentSugars = "";
  int totalhours = 0;
  bool isChecked = false;
  int countinghours = 0;

  late List<Widget> _widgetoption;

  String name = "";
  late String _now;
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  late Timer _everySecond;
  void initState() {
    FirebaseDatabase.instance.ref().child("users/" + FirebaseAuth.instance.currentUser!.uid).once().then((value)
    {



      Map map = value.snapshot.value as Map;

      name = map['Name'];



    }

    );











  }



  @override
  @override
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        print(selectedDate);
      });

  }
  _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
      });

  }


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
  int numbers(int i){
    Future.delayed(Duration(milliseconds: 200*i),(){
      return i;
      setState(() {

      });
    });
    return i;


  }



  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }
    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Container(width:400, height:50,margin: EdgeInsets.only(top:100, left: 10, right: 10),child:
            ElevatedButton(
                onPressed: (){ if(isChecked == false){_selectDate(context);};},
                child: Text("Select Starting Date"),
                style: ElevatedButton.styleFrom(
                backgroundColor: button
            ),
            )),
            Container(width:400, height:50,margin: EdgeInsets.only(top:10, left: 10, right: 10),child:
            ElevatedButton(
                onPressed: (){ if(isChecked == false){_selectDate2(context);};},
                child: Text("Select Ending Date"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: button
                ),
            )),
            Row(children: [
              Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                Future.delayed(const Duration(microseconds: 5),(){
                  if(isChecked){
                    button = Colors.grey;

                    selectedDate=DateTime.parse('2000-01-01 20:18:04Z');
                    selectedDate2=DateTime.parse('2222-12-31 20:18:04Z');
                    print(selectedDate2.toString());

                  }else{
                    button = Colors.blue;
                  }
                });
                Future.delayed(const Duration(milliseconds: 1),(){
                  setState(() {



                  });
                });


                setState(() {
                  isChecked = value!;

                });
              },
            ),
              Text("FOREVER")
            ],),
            Container(margin:EdgeInsets.only(top:200, left: 10, right: 10) ,child: ElevatedButton(onPressed: (){
              FirebaseDatabase.instance.ref().child("tutors/" + name+"/logs").once().then((
                  result) async {
                List<String> codelistfromfb = [];
                totalhours = 0;




                Map map = result.snapshot.value as Map;

                map.forEach((key,value) {



                    DateTime temp = DateTime.parse(key + " 10:10:10Z");
                    print(temp.toString());
                    if(selectedDate.isBefore(temp)&&selectedDate2.isAfter(temp)){

                        totalhours = totalhours + int.parse(value.toString());
                        setState(() {

                        });


                    };



                  //print(value.toString());



                });

                for(int i = 0; i < totalhours+1; i++){
                  await Future.delayed(Duration(milliseconds: 50));


                    countinghours = i;
                    setState(() {

                    });



                };




                // refresh the UI - ListView based on the new data
                setState(() {

                });
              }).catchError((e) {
                print('failedfalided');
                print(e);

              });
            },
                child: Text('Calculate')),),

            Container(child: Text(countinghours.toString()),)











          ],
        ),
      ),
      //
    );

  }
}
