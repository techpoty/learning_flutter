import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      home: const MyHomePage(title: 'Double Click the Back Button to Close App'),
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

  //define a back button clicked time
  DateTime backPressedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonDoubleClicked(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.brown,
        ),
        backgroundColor: Colors.brown,
        body:  Center(
          child:  GradientText(
            'Click Again To Close App',
            style: const TextStyle(
                fontSize: 63.0,
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
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

 Future<bool> _onBackButtonDoubleClicked(BuildContext context) async{

    //the difference
    final difference = DateTime.now().difference(backPressedTime);
    backPressedTime = DateTime.now();
    if(difference >= const Duration(seconds: 2)){
         toast(context, " Click Again To Close The App ");
         return false;
    }else{
      SystemNavigator.pop(animated: true);
      return true;
    }

  }
  //define a toast method
  void toast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center,),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

}
