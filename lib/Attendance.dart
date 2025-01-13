

import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_matters/StudentNavigation.dart';
import 'package:math_matters/directorbottom.dart';
import 'package:math_matters/main.dart';
import 'package:math_matters/schudule.dart';
// import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'HomePage.dart';
import 'schudule.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
//attendance.dart, feedbakcs.dart, hourcounter.dart
import 'BottomNavigation.dart';
//todo
//
//add hours to tutor profile//done
//add content tracker to student profile//done
//delete hour request after approved//done
//add co-director verification
//add filter so only shows request for dates
class attend extends StatefulWidget {
  attend({Key? key, required this.title}) : super(key: key);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _attendState createState() => _attendState();
}

class _attendState extends State<attend> {
  int counter = 1;
  String type = "";
  List<String> newnames = [];
  List names = [];
  final List<String> items = [];

  void initState() {
    FirebaseDatabase.instance.ref().child("users/" +FirebaseAuth.instance.currentUser!.uid+"/").get().then((value){
      Map map = value.value as Map;
      print(value.value.toString());
      name = map['Name'];
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
    // TODO: implement initState


    super.initState();
    //var uid = Signup.FirebaseAuth.instance.createUserWithEmailAndPassword.value.user!.uid;
    var uid = FirebaseAuth.instance.currentUser?.uid;
    FirebaseDatabase.instance.ref().child('users/'+uid.toString()).once().then((value)
    {
      Map map = value.snapshot.value as Map;
      type = map['type'];
      print(type.toString() + "type");



    });




    FirebaseDatabase.instance.ref()
        .child("counter" )
        .once()
        .then((res) {
          Map map = res.snapshot.value as Map;
          counter = map['count'];
          print(counter.toString());


    }).catchError((e) {
      print('failed');
    }
    );

  }
  List codeList = [

  ];
  List codeDate = [];
  List<int> delete = [];
  var length = 1;
  String t = "true";
  var name = "";
  String day = DateTime.now().day.toString().padLeft(2, '0');

  String month = DateTime.now().month.toString().padLeft(2, '0');

  String dropdownValue = 'Student';
  int _counter = 0;
  var _selectedIndex = 1;
  late List<Widget> _widgetoption;
  TextEditingController HoursController = TextEditingController();
  TextEditingController Date = TextEditingController();
  TextEditingController StudentController = TextEditingController();

  TextEditingController contenttracker = TextEditingController();
  DateTime selectedDate = DateTime.now();
  double _currentSliderValue = 2;
  int hours = 0;

  @override
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    if(selectedDate.day.toString().length == 1){
      day = "0"+selectedDate.day.toString();
    }else{
      day = selectedDate.day.toString();
    }
    if(selectedDate.month.toString().length == 1){
      month = "0"+selectedDate.month.toString();

    }else{
      month = selectedDate.month.toString();
    }
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
  }
   getType(){
    FirebaseDatabase.instance.ref().child('users/'+FirebaseAuth.instance.currentUser!.uid.toString()).once().then((value)
    {
      Map map = value.snapshot.value as Map;
      type = map['type'];
      return type;
      print(type);



    }
    );
    // Future.delayed(const Duration(milliseconds: 100), (){
    //   return "tutor";
    //
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: SingleChildScrollView(
        reverse: true,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Container(
            //   width: 400,
            //   height: 50,
            //   margin: EdgeInsets.only(top:75, bottom: 10, right: 10, left: 10),
            //   child: TextField(
            //     controller: Name,
            //     obscureText: false,
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: 'TutorName',
            //     ),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: DropdownSearch(
                items: items,
                selectedItem: StudentController.text,
                enabled: true,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(

                    labelText: "Select Student Name",
                    hintText: "Select Student Name",
                  ),
                ),
                popupProps: PopupProps.menu(
                  showSearchBox: true,  // Enables the search box within the dropdown menu.
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: 'Search for a student...',

                    ),

                  ),
                  
                ),

                onChanged: (value) {
                  setState(() {
                    StudentController.text = value.toString();
                  });
                },
                //isExpanded: true,
              ),
            ),

          // Container(
          //   width: 400,
          //   height: 50,
          //   margin: EdgeInsets.all(10),
          //   child: TextField(
          //     controller: StudentController,
          //     obscureText: false,
          //     decoration: InputDecoration(
          //       border: OutlineInputBorder(),
          //       labelText: 'Student Name',
          //     ),
          //   ),
          // ),
          Container(
            width: 400,

            margin: EdgeInsets.all(10),
            child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                hintText: 'Write what you taught today here',
                labelText: 'Student Content Tracker',
              ),
              controller:contenttracker ,
              maxLines: 6,
            ),
          ),
          Container(width:400, height:50,margin: EdgeInsets.all(10),child: ElevatedButton(onPressed: ()=> _selectDate(context), child: Text("Select Date"))),

            Container(
              width:400, height:50,
                margin: EdgeInsets.all(10),
              child: ElevatedButton(onPressed: (){

                FirebaseDatabase.instance.ref().child("AttendanceLog/" +  counter.toString()+"/Info").set(
                    {
                       "Name": name,
                      "Hours" : HoursController.text,
                      "Date" : selectedDate.year.toString()+ '-' + month + "-" + day,


                    }
                ).then((value) {
                  if(type.contains("irector")){
                    print(type);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => directorNavigation(title: 'Home')),
                    );

                  }

                  if(type.contains("utor")){
                    print('its a tutor!');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => bottomNavigation(title: 'Home')),
                    );

                  }

                  // go back to Login screen
                  print("sucess");
                  FirebaseDatabase.instance.ref().child("counter").set(
                      {
                        'count' : counter + 1

                      });

                }).catchError((e){
                  print("Failed to save the user information." );
                  print(e);
                });
                FirebaseDatabase.instance.ref().child('Student/' + StudentController.text + '/ContentTracking').update(
                    {


                      month + '-'+day+'-'+selectedDate.year.toString():contenttracker.text
                    }
                ).catchError((e)
                {
                  print(e);
                });



              }, child: Text('Save')),
            ),
            Container( width:400, height:50, margin: EdgeInsets.all(10), child: ElevatedButton(onPressed: (){

              print(type);
              if(type.contains('irect')){
              FirebaseDatabase.instance.ref().child("AttendanceLog/" ).once().then((result){
                var codelistfromfb = [];
                var datecodelist = [];
                print('Secusese');
                Map map = result.snapshot.value as Map;

                //print(result.value);
                map.forEach(( key, value) {
                  //print(value);
                  //print(key);
                  delete.add(int.parse(key));
                  //todo put key in a list to know which ones to delete

                 //print(value['Info']);
                 //print(value['Info']['Date']);
                  codelistfromfb.add(value['Info']['Name']);
                  datecodelist.add(value['Info']['Date']);
                });
                codeList = codelistfromfb;
                codeDate = datecodelist;

                // refresh the UI - ListView based on the new data
                setState(() {

                });

              }).catchError((e) {
                print('failed');
                print(e);
              });};


            },

              child: Text('Verify Hours'),),),
          Container(
            height: (codeList.length*50)+5,
            width: 800,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: codeList.length,
                itemBuilder: (BuildContext context, int index) {

                  return Container(




                    height: 50,

                    margin: EdgeInsets.only(top:5),

                    color: Colors.blue[700],
                    child:  Center(child: Row(
                      children: [

                        Text('Hours: '),

                        Text('2'+ " "),
                        Text('Date: '),
                        Container(

                            child: Text(codeDate[index].toString())),
                        Text(' Name: '),
                        Container(child: Text(codeList[index].toString())),
                        Container(child: ElevatedButton(onPressed: (){
                          FirebaseDatabase.instance.ref().child('tutors/'+codeList[index].toString()).once().then((value)
                            {
                              Map map = value.snapshot.value as Map;
                              print(codeList[index].toString() );

                              hours = map['Hours'];
                              hours = hours+2;
                              print(hours);
                            }
                          );
                          Future.delayed(const Duration(milliseconds: 250),(){
                            FirebaseDatabase.instance.ref().child("tutors/"+ codeList[index].toString() ).update(
                                {


                                  'Hours'  : hours,


                                }
                            ).then((value) {
                              print(hours.toString() + "hours");
                              print(codeList[index].toString()+"final");
                            });
                            FirebaseDatabase.instance.ref().child("tutors/"+ codeList[index].toString() + '/logs' ).update(
                                {


                                  codeDate[index].toString()  : 2,


                                }
                            ).then((value) {
                              print(hours.toString() + "hours");
                              print(codeDate.toString());
                              print(codeList[index].toString()+"final");
                            });

                          });


                            // go back to Login screen
                          Future.delayed(const Duration(milliseconds: 400),(){
                          FirebaseDatabase.instance.ref().child('AttendanceLog/' + delete[index].toString()).remove().then((value){
                          delete.remove(delete[index]);

                          codeList.remove(codeList[index]);
                          //print(codeList);
                          setState(() {

                          });
                          });
                          });


                          //todo
                          //remove 1 from counter

                          //set up better numbering system

                        }, child: Text("Verify Hours")))

                      ],
                    )),
                  );
                }


            ),)

          ],
        ),
      ),
      //
    );

  }
}
