import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:math_matters/BottomNavigation.dart';
import 'HomePage.dart';
import 'StudentNavigation.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({Key?key, required this.title}) : super(key: key);

  final String title;

  @override
  _FeedbackpageState createState() => _FeedbackpageState();
}

class _FeedbackpageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  String Typetest = "";
  void initState() {
    FirebaseDatabase.instance.ref().child("users/" + FirebaseAuth.instance.currentUser!.uid + "/type").once().then((value)
    {
      print(FirebaseAuth.instance.currentUser!.uid);
      Map map = value.snapshot.value as Map;
      Typetest = map.toString();
      print(map.toString());
      print("hi");
      print(Typetest);


    }

    );

  }

  TextEditingController contactController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Page'),
      ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...[
                        Text('We at Math Matters strive to improve our organization. Please leave a comment on what you enjoyed and what you think needs improving'
                        ,textAlign: TextAlign.center, style: TextStyle(fontSize: 18),),
                        TextField(

                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Contact Info',
                            labelText: 'Student Name',
                          ),
                          controller: contactController,
                        ),


                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            hintText: 'Write your feedback here',
                            labelText: 'Feedback',
                          ),
                          controller: feedbackController,
                          maxLines: 6,
                        ),

                        ElevatedButton(
                            onPressed: () {
                              var timestamp = DateTime.now().millisecondsSinceEpoch.toString();

                              FirebaseDatabase.instance.ref().child("feedback/" + timestamp).set(
                                  {
                                    "contact" : contactController.text,
                                    "title" : titleController.text,
                                    "feedback" : feedbackController.text,
                                  }
                              ).then((res) {
                                print('Your feedback has been Received!');

                                print(Typetest);
                                if(Typetest.contains('tud')== true){
                                  print("here");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => StudentNav(title: 'Home Page')),
                                  );
                                }else{
                                  print("why does it go here");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => StudentNav(title: 'Home Page')),
                                );}
                              }).catchError((e){
                                print("Failed, please try again");
                                print(e);
                              });

                            },
                            child: Text('Send Feedback')
                        ),


                      ].expand(
                            (widget) => [
                          widget,
                          const SizedBox(
                            height: 30,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
