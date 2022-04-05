import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterPlay Songs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'FlutterPlay Songs'),
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
  Color bgColor = Colors.brown;

  //define on audio plugin
  final OnAudioQuery _audioQuery = OnAudioQuery();

  //today
  //player
  final AudioPlayer _player = AudioPlayer();

  //request permission from initStateMethod
  @override
  void initState() {
    super.initState();
    requestStoragePermission();
  }

  //dispose the player when done
  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        //backgroundColor: bgColor,
        elevation: 20,
        backgroundColor: bgColor,
      ),
    backgroundColor: bgColor,
      body: FutureBuilder<List<SongModel>>(
        //default values
        future: _audioQuery.querySongs(
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item){
          //loading content indicator
          if(item.data == null){
            return const Center(child: CircularProgressIndicator(),);
          }
          //no songs found
          if(item.data!.isEmpty){
            return const Center(child: Text("No Songs Found"),);
          }

          // You can use [item.data!] direct or you can create a list of songs as
          // List<SongModel> songs = item.data!;
          //showing the songs
          return ListView.builder(
            itemCount: item.data!.length,
            itemBuilder: (context, index){

              return Container(
                margin: const EdgeInsets.only(top: 15.0, left: 12.0, right: 16.0),
                padding: const EdgeInsets.only(top: 30.0, bottom: 30),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const[
                    BoxShadow(
                      blurRadius: 4.0,
                      offset: Offset(-4, -4),
                      color: Colors.white24,
                    ),
                    BoxShadow(
                      blurRadius: 4.0,
                      offset: Offset(4, 4),
                      color: Colors.black,
                    ),
                  ],
                ),
                child:ListTile(
                  textColor: Colors.white,
                  title: Text(item.data![index].title),
                  subtitle: Text(item.data![index].displayName,
                    style: const TextStyle(
                      color: Colors.white60,
                    ),
                  ),
                  trailing: const Icon(Icons.more_vert),
                  leading: QueryArtworkWidget(
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,

                  ),
                  onTap: () async {
                      toast(context, "Playing:  " + item.data![index].title);
                      // Try to load audio from a source and catch any errors.
                        String? uri = item.data![index].uri;
                        await _player.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
                        await _player.play();
                  },
                ),
              );

            });
        },
      ),
    );
  }
  //define a toast method
  void toast(BuildContext context, String text){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    ));
  }

  void requestStoragePermission() async {
    //only if the platform is not web, coz web have no permissions
    if(!kIsWeb){
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if(!permissionStatus){
        await _audioQuery.permissionsRequest();
      }

      //ensure build method is called
      setState(() { });
    }
  }

}
