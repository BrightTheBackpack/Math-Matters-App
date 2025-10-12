import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:math_matters/FeedbackPage.dart';
import 'package:math_matters/schudule.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'dart:async';
class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _launchURL() async {
    String url = 'https://www.mathmatters4all.org/';
    if (!url.contains('http')) url = 'https://$url';


    launch(url);
  }

  var _selectedIndex = 0;
  late List<Widget> _widgetoption;
  @override
  void initState(){

    super.initState();
    _widgetoption = [HomePage(title: 'wut')];


  }


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      backgroundColor: Color(0xff00104e),
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
          children: <Widget>[


            Container(width:200, height:200,child:Image.network('https://cloud-52a7ds35h-hack-club-bot.vercel.app/0image.png')),



            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(onPressed: _launchURL, child: Text('Our Website'),      style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Adjust for squareness
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(onPressed: (){
                   {
                    String url = 'https://www.instagram.com/mathmatters4all/';
                    if (!url.contains('http')) url = 'https://$url';


                    launch(url);
                  }

                },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Adjust for squareness
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Instagram')),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(onPressed: (){
                  {

                    String url = 'https://discord.gg/tmdh9tq82k';
                    if (!url.contains('http')) url = 'https://$url';


                    launch(url);
                  }

                },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Adjust for squareness
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Discord')),

              ],
            ),
         //   Row(
           //   mainAxisAlignment: MainAxisAlignment.center,
//
  //            children: [
//
   //             ElevatedButton(onPressed: (){
     //             {
       //             Navigator.push(
         //             context,
           //           MaterialPageRoute(builder: (context) => FeedbackPage(title: 'Login and Signup')),
             //       );
               //   }

           //     }, child: Text('Feedback Page')),
//
  //            ],
    //        ),

            







          ],

        ),

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}