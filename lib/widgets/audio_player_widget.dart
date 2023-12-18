import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  const AudioPlayerWidget(this.url, {super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = const Duration();
  Duration position = const Duration();
  bool playing = false;

  @override
  initState() {
    handleAudio();
    super.initState();
  }

  handleAudio() async {
    if (playing) {
      await audioPlayer.pause();
      setState(() {
        playing = false;
      });
    } else {
      await audioPlayer.play(UrlSource(widget.url));
      setState(() {
        playing = true;
      });
    }

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        this.duration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration duration) {
      setState(() {
        this.duration = position;
      });
    });

    // audioPlayer.onDurationChanged.listen((Duration dd) {
    //   if (mounted) {
    //     setState(() {
    //       duration = dd;
    //     });
    //   }
    // });
    // audioPlayer.onPositionChanged.listen((Duration dd) {
    //   if (mounted) {
    //     setState(() {
    //       position = dd;
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            width: 64,
            height: 64,
            image: AssetImage('images/mp3.png'),
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 40,
          ),
          Slider.adaptive(
            min: 0.0,
            value: position.inSeconds.toDouble(),
            max: duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                audioPlayer.seek(Duration(seconds: value.toInt()));
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  audioPlayer.seek(
                    Duration(seconds: position.inSeconds - 10),
                  );
                },
                icon: const Icon(
                  Icons.fast_rewind_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              IconButton(
                onPressed: () => handleAudio(),
                icon: Icon(
                  playing == false
                      ? Icons.play_circle_fill
                      : Icons.pause_circle_filled,
                  color: Colors.white,
                  size: 56,
                ),
              ),
              IconButton(
                onPressed: () {
                  audioPlayer.seek(
                    Duration(seconds: position.inSeconds + 10),
                  );
                },
                icon: const Icon(
                  Icons.fast_forward_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
