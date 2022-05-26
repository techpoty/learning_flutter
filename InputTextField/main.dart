import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter User Input Field'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userInput =""; int size =18;
  void showWhatEntered(String value){
    setState(() {
      userInput = value;
      size = value.length*2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressedShowExitDialog(context),
      child:  Scaffold(
        appBar: AppBar(title: Text(widget.title), backgroundColor: Colors.brown,),
        body:  SingleChildScrollView(
          child: Column(
           children:  [
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: TextField(
                 decoration: const InputDecoration(
                   border: OutlineInputBorder(),
                   hintText: 'User Input widget',
                 ),
                 onChanged: (value){
                   showWhatEntered(value);
                 },
               ),
             ),const Padding(
               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
               child: TextField(
                 decoration: InputDecoration(
                   //border: OutlineInputBorder(),
                   hintText: 'Another Text field input',
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
               child: Text(
                 "Entered: $userInput",
                 style: TextStyle(fontSize: size.toDouble()),
               ),
             ),
           ],
          ),
        )


        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  //define a toast method
  void toast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center,),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

//close app confirm dialog
  Future<bool> _onBackButtonPressedShowExitDialog(BuildContext context)  async{
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context){
          //create and return a dialog
          return AlertDialog(
            title: const Text("Really??"),
            content:  const Text("Do you want to close the app ?"),
            actions: <Widget> [
              //a no btn
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
                child: const Text("No, Stay"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes, Close"),
              ),
            ],
          );
        }
    );
    return exitApp ?? false;
  }

}
