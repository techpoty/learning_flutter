import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

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
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Songs in Assets'),
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

  //variable
  Color bgColor = Colors.red;
  //player
  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: bgColor,
      ),
      body:  FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString("AssetManifest.json"),
        // future: rootBundle.loadString("AssetManifest.json"),
        builder: (context, item){
          if(item.hasData){

            Map? jsonMap = json.decode(item.data!);
            List? songs = jsonMap?.keys.toList();
           // List? songs = jsonMap?.keys.where((element) => element.endsWith(".mp3")).toList();

            return ListView.builder(
              itemCount: songs?.length,
              itemBuilder: (context, index){
                var path = songs![index].toString();
                var title = path.split("/").last.toString(); //get file name
                title = title.replaceAll("%20", ""); //remove %20 characters
                title = title.split(".").first;

                return Container(
                  margin: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.white70, width: 1.0, style: BorderStyle.solid),
                  ),

                  child: ListTile(
                    textColor: Colors.white,
                    title: Text(title),
                    subtitle: Text("path: $path",
                             style: const TextStyle(color: Colors.white70, fontSize: 12),),
                    leading: const Icon(Icons.audiotrack, size: 20, color: Colors.white70,),
                    onTap: () async{
                      toast(context, "Playing: $title");
                      //play this song
                      await _player.setAsset(path);
                      await _player.play();
                    },
                  ),
                );
              },
            );
          }else{
            return const Center(
              child: Text("No Songs in the Assets"),
            );
          }
        },
      ),
    );
  }

  //A toast method
  void toast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text, textAlign: TextAlign.center,),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }
}
