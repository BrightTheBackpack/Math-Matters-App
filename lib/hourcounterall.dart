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
class hours extends StatefulWidget {
  hours({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _hoursState createState() => _hoursState();
}

class _hoursState extends State<hours> {
  int age = 0;
  int agegroup = 0;


  bool isChecked = false;
  var reqhour = {0:26,1:50,2:100,3:100};
  var rankchecks = {0:["26 49", "50 74", "100"],1:["50 74", "75 99", "100"],2:["100 174", "175 249", "250"], 3:["100 249", "250 499", "500"]};
  var mapvalues = new Map();
  var ranks = {"0" : "Bronze", "1": "Silver", "2":"Gold"};

  bool isChecked2 = false;
  Color button = Colors.blue;
  int totalhours = 0;
  int countinghours = 0;
  List names = [];
  List altnames = [];
  List hours = [];
  List althours = [];
  List rank = [];

  late List<Widget> _widgetoption;


  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

  void initState() {
    for(int i = 0; i < 200; i++){
      rank.add("-");
    }












  }



  @override
  @override
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

  }
  _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;
      });

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
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(

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
              FirebaseDatabase.instance.ref().child("tutors/").once().then((
                  result) async {
                //List<String> codelistfromfb = [];
                totalhours = 0;
                names = [];
                hours = [];
                int i = 0;
                Map map = result.snapshot.value as Map;



                map.forEach((key,value) {
                  totalhours = 0;



                  print(key.toString() + "key.toString()");
                  print(value['logs'].toString() + "value[logs]");
                  if(value['logs'] !=null){
                    value['logs'].forEach((key,value){
                      DateTime temp = DateTime.parse(key + " 10:10:10Z");

                      print(key.toString());
                      print(value.toString());
                      if(selectedDate.isBefore(temp)&&selectedDate2.isAfter(temp)){
                        totalhours = totalhours + int.parse(value.toString());
                      }});

                  }

                  names.add(key.toString()) ;
                  hours.add(totalhours.toString())  ;



                  i++;



                });

              print(hours.toString());
              print(names.toString());
                await Future.delayed(const Duration(seconds: 3));
                print(names.length);
                print(hours);




                // refresh the UI - ListView based on the new data
                setState(() {

                });
              }).catchError((e) {
                print('failedfalided');
                print(e);

              });
            },
                child: Text('Calculate')),),

            Container(
              height: names.length*100,
            width: 400,

            //Expanded(child:
              child:
            ListView.builder(


                padding: const EdgeInsets.all(20),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),


                    height: 100,
                    color: Colors.white10,



                      child: Center(child: Row(
                        children: [
                          Text(names[index].toString()),
                          Text(":"),
                          Text(hours[index].toString()),
                          Text("  "),
                          Text(rank[index].toString())



                        ],
                      )),

                  );
                }


            ),
            ),
    //)











          ],
        ),
      ),
      //
    );

  }
}
