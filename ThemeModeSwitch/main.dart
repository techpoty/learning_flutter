import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Using "static" so that we can easily access it later
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   //use value listenable builder widget to listen on user choices
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier ,
      builder: (context, currentMode, child){
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.amber,), //the light theme
          darkTheme: ThemeData.dark(),
          themeMode: currentMode, //the current to be changing according to user choices
          home: const MyHomePage(title: 'Theme Mode Switch'),
        );
      },
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        //theme changing btn
        actions: [
          IconButton(
            //set the icon according
            icon: Icon(MyApp.themeNotifier.value == ThemeMode.light? Icons.dark_mode : Icons.light_mode),
              //change theme as user clicks this btn
              onPressed: (){
              MyApp.themeNotifier.value = MyApp.themeNotifier.value == ThemeMode.light? ThemeMode.dark :ThemeMode.light;
              },
          ),
        ],
      ),
      body: Center(
        child: Text( MyApp.themeNotifier.value == ThemeMode.light?  'Mode Light ':  'Mode Dark',
              style: Theme.of(context).textTheme.headline3,
            ),
      ),
    );
  }
}
