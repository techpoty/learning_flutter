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
      home: const MyHomePage(title: 'Curved Bottom Navigation bar'),
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
  // bg color
  Color bgColor = const Color(0XFF214283); //Colors.black;

  int _page = 0; //current page index

  //pages text
  List<String> pages = <String>['Home', 'Search', 'Money', 'User', 'Settings'];


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () => _onBackButtonPressedShowExitDialog(context),
      child:  Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: bgColor,
        ),
        backgroundColor: bgColor,
        body:  Center(
          child:GradientText(
            'Page: '+pages.elementAt(_page),
            style: const TextStyle(
                fontSize: 60.0,
                fontWeight: FontWeight.bold

            ),
            colors: const [
              Colors.white,
              Colors.yellowAccent,
              Colors.red,
            ],
            textAlign: TextAlign.center,
          ),
        ),

        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.search, size: 30),
            Icon(Icons.monetization_on_outlined, size: 30),
            Icon(Icons.person, size: 30),
            Icon(Icons.settings, size: 30),
          ],
          color: Colors.yellowAccent,
          buttonBackgroundColor: Colors.white,
          backgroundColor: bgColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),

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
