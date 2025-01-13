import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'login page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Signup extends StatefulWidget {
  Signup({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  int _counter = 99713965;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController LastNameController = TextEditingController();
  TextEditingController Confirm = TextEditingController();
  bool _validate = false;
  String test = "";
  bool _validatepass = false;
  String passerror = "";
  bool _confirmation = false;
  String confirmerror = "";
  void initState() {

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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login(title: 'Login')),
    );
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
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // Here we take the value from the Signup object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:SingleChildScrollView(
        reverse: true,

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


               Container(
                margin: EdgeInsets.only(top:10),
                height: 150,
                child:
                const Image(
                  image: NetworkImage('https://cloud-52a7ds35h-hack-club-bot.vercel.app/0image.png'),
                ),

              ),







               Column(
                children: [
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.all(10),
                    child:  TextField(
                      scrollPadding: EdgeInsets.only(bottom:40),
                      controller: usernameController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        errorText: _validate ? test : null,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 400,
                    margin: EdgeInsets.all(10),
                    child:  TextField(
                      scrollPadding: EdgeInsets.only(bottom:40),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        errorText: _validatepass ? passerror : null,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 400,

                    margin: EdgeInsets.all(10),
                    child:  TextField(
                      scrollPadding: EdgeInsets.only(bottom:40),
                      controller: Confirm,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                        errorText: _confirmation ? confirmerror : null,
                      ),
                    ),
                  ),



                          Container(
                            height: 50,
                            width: 400,

                            margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom:0),
                            child: TextField(
                              scrollPadding: EdgeInsets.only(bottom:40),
                              controller: nameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ),
                          )









                ],
              ),



            const SizedBox(height: 30),
               Container(





                width: 250,
                height: 50,
                margin: EdgeInsets.only(bottom:40),
                child: ElevatedButton(
                  onPressed: (){
                    usernameController.text.isEmpty ? _validate = true : _validate = false;
                    usernameController.text.isEmpty ? test = "This field is required" : test = "";
                    passwordController.text.isEmpty ? _validatepass = true : _validatepass = false;
                    passwordController.text.isEmpty ? passerror = "This field is required" : test = "";

                    _validatepass = false;
                    _validate = false;
                    _confirmation = false;
                    print(usernameController.text);
                  print(passwordController.text);
                  if(passwordController.text != Confirm.text){
                    _validatepass = true;
                    passerror = "the passwords don't match";
                    _confirmation = true;
                    confirmerror = "The Passwords don't Match";
                    setState(() {

                    });
                  }
                  if(passwordController.text == Confirm.text){
                    _validatepass = false;
                    _confirmation = false;





                  FirebaseAuth.instance.createUserWithEmailAndPassword(

                  email: usernameController.text, password: passwordController.text)
                    .then((value) {
                    print("User Uid: " + value.user!.uid);
                    // use Firebase Database
                          FirebaseDatabase.instance.ref().child("users/" + value.user!.uid).set(
                      {
                      "Name" : nameController.text,

                        }
                   ).then((value) {
                     print("works");
                        // go back to Login screen
                Navigator.push(
                       context,
                  MaterialPageRoute(builder: (context) => Login(title: 'Login Page')),
                  );
              }).catchError((e){
                    print("Failed to save the user information.");
                });
                  }).catchError((e) {
                print("Failed to sign up!");
              print(e);
                  //write errors here
                    if(e.toString().contains("email address is badly") ==true ){
                      print('yay');
                      _validate=true;
                      test = "Email is not valid";
                      setState(() {

                      });
                    }
                    if(e.toString().contains('6 characters')){
                      _validatepass=true;
                      passerror = "The passoword must be Six Characters Long";
                      setState(() {

                      });
                    }
                    if(e.toString().contains('already in use by another') == true){
                      _validate = true;
                      test = "This email is in use by another account";
                      setState(() {

                      });
                    }
              });};
                  setState(() {

                  });

                  },
                  //Navigator.push(
                  //context},
                  child: const Text('Sign Up'),),


              ),
            Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
            )






          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
