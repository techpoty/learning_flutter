import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glassmorphism In Emulator',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Glassmorphism In Emulator'),
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
  Color bgColor = Colors.pink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: bgColor,
      ),
      backgroundColor:bgColor,
      body: Center(

         child: InkWell(
           onTap: (){
             print("Neumorphic Card Was Clicked");
           },
           child: Container(
             margin: const EdgeInsets.all(12.0),
             padding: const EdgeInsets.only(top: 30.0, bottom: 30),
             decoration: BoxDecoration(
               color: bgColor,
               borderRadius: BorderRadius.circular(20.0),
               boxShadow: const [
                 BoxShadow(
                   blurRadius: 4.0,
                   offset: Offset(-4, -4),
                   color: Colors.white24,
                 ),
                 BoxShadow(
                   blurRadius: 6.0,
                   offset: Offset(8, 8),
                   color: Colors.black,
                 )
               ],
             ),

             child:  const ListTile(
               title: Text(
                 "Some Card Title",
                 style: TextStyle(
                   fontSize: 30,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               subtitle: Text(
                 "some small subtitle",
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.normal,
                   fontStyle: FontStyle.italic,

                 ),
               ),
               leading: Icon(Icons.account_box, size: 50, color: Colors.yellow,),
               textColor: Colors.white,
               trailing: Icon(Icons.more_vert, size: 30, color: Colors.yellow,),
             ),
           ),

         ),


      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}
