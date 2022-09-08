import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hidden_city/http/videopage_files/video.dart';
import 'package:video_player/video_player.dart';

class FullscreenWidget extends StatefulWidget {
  final VideoPlayerController controller;

  const FullscreenWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<FullscreenWidget> createState() => _FullscreenWidgetState();
}

class _FullscreenWidgetState extends State<FullscreenWidget> {
  bool _hide = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return WillPopScope(
      onWillPop: _onback,
      child: widget.controller.value.isInitialized
          ? Container(alignment: Alignment.topCenter, child: buildVideo())
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<bool> _onback() async {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return true;
  }

  Widget buildVideo() => Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () {
            _hide = !_hide;
            setState(() {});
          },
          child: Stack(
            fit: StackFit.loose,
            children: <Widget>[
              Center(child: buildVideoPlayer()),
              buildPlay(context, true, widget.controller, _hide, func: () {
                widget.controller.value.isPlaying
                    ? widget.controller.pause()
                    : widget.controller.play();

                _hide = !_hide;
                setState(() {});
              }, forw: () async {
                Duration? newDur = (await widget.controller.position)! +
                    const Duration(seconds: 5);
                widget.controller.seekTo(newDur);
                _hide = !_hide;
                setState(() {});
              }, rew: () async {
                Duration? newDur = (await widget.controller.position)! -
                    const Duration(seconds: 5);
                widget.controller.seekTo(newDur);
                _hide = !_hide;
                setState(() {});
              }),
              if (_hide)
                Positioned(
                    bottom: 20,
                    left: 70,
                    right: 45,
                    child: buildIndicator(widget.controller)),
            ],
          ),
        ),
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: widget.controller.value.aspectRatio,
          child: VideoPlayer(widget.controller),
        ),
      );

  Widget buildFullScreen({
    required Widget child,
  }) {
    final size = widget.controller.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
