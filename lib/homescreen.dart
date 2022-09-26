import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dataSource =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
  VideoPlayerController? _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(
      dataSource,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true,),
    )..initialize().then((_) {
        setState(
          () {},
        );
      });
    _controller!.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: _controller!.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(
                        _controller!,
                      ),
                    )
                  : VideoProgressIndicator(
                      _controller!,
                      allowScrubbing: true,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                    setState(() {});
                  },
                  icon: Icon(
                    _controller!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_next),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.restart_alt),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
