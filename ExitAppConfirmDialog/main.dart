import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Confirmation Dialog to Quit App'),
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.pink,
        ),
        backgroundColor: Colors.pink,
        body:  Center(
          child:  GradientText(
            'Confirm to exit app',
            style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold

            ),
            colors: const [
              Colors.white,
              Colors.blue,
            ],
            textAlign: TextAlign.center,
          ),

        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

 Future<bool> _onBackButtonPressed(BuildContext context)  async{
    bool? exitApp = await showDialog(
      context: context,
      builder: (BuildContext context){
        //create and return a dialog
        return AlertDialog(
          title: const Text("Really ??"),
          content:  const Text("Do you want to close the app??"),
          actions: <Widget> [
            //a no btn
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      }
    );

    return exitApp ?? false;

  }
}
