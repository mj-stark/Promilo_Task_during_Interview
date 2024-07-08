import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({super.key});

  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  late YoutubePlayerController _controller;
  final List<String> _videoIds = [
    'vxTW22y8zV8', 
  ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      onWebResourceError: (value) => _videoIds, 
      params: YoutubePlayerParams(
        mute: false,
        loop: true,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _onVideoTap(String videoId) {
    _controller.loadVideoById(videoId: videoId);
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('YouTube Video Player'),
          ),
          body: Column(
            children: [
              // The player widget
              Expanded(
                flex: 2,
                child: player,
              ),
              const SizedBox(height: 20),
              // List of video suggestions
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: _videoIds.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Video ${index + 1}'),
                      onTap: () => _onVideoTap(_videoIds[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
