import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


/* As per the  requirements I didnt use any kind of fancy designs just I tried in the concept of iframe 
Here the youtube video after getting completed will show the suggestions and the suggested video will be running in the same
Screen.
*/

// the id of the youtube videos are taken

const List<String> _videoIds = [
  'vxTW22y8zV8',
  'uFM7bLuCrKo',
  'RU7M2RwW42U',
  'EOeQ2ojUhGM',
  'y8S_UIxHzH4',
  'aLUDhbQojxA',
];

void main() {
  runApp(const YoutubeApp());
}

class YoutubeApp extends StatelessWidget {
  const YoutubeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youtube Player',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const YoutubeVideo(),
    );
  }
}

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({super.key});

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  late YoutubePlayerController _controller;

  // initializing the controls and youtube video id in the controller
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    // the the total video id are been loaded here
    _controller.loadPlaylist(
      list: _videoIds,
      listType: ListType.playlist,
      startSeconds: 0,
    );
  }


  // here the youtube video will be running in the iframe (as per the requirements I used iframe concept here )
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Youtube Video'),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 750) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          player,
                        ],
                      ),
                    ),

                    // Here you can also add any other controls like buttons to choose the videos in the list also 
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Container(
                        ),
                      ),
                    ),
                  ],
                );
              }
              return ListView(
                children: [
                  player,
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
