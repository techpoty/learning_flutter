import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return GetMaterialApp(
          title: 'Dark or Light mode switch',
          //theme: ThemeData(primarySwatch: Colors.amber,), //the light theme
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system, //the current Theme mode depends on device settings at the beginning
          home: const MyHomePage(title: 'Change Theme Mode(Dark/Light)'),
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
            icon: const Icon(Icons.lightbulb),
              //change theme as user clicks this btn
              onPressed: (){
              Get.isDarkMode ? Get.changeTheme(ThemeData.light()) :  Get.changeTheme(ThemeData.dark());
              },
          ),
        ],
      ),
      body: Center(
        child: Text( Get.isDarkMode ?  'App In Dark Mode ':  'App In Light Mode',
              style: Theme.of(context).textTheme.headline4,
            ),
      ),
    );
  }
}
