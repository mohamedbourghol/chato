import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_audio_recorder2/flutter_audio_recorder2.dart';
import 'package:path_provider/path_provider.dart';


class RecordWidget extends StatefulWidget {
  const RecordWidget({Key? key}) : super(key: key);

  @override
  _RecordWidgetState createState() => _RecordWidgetState();
}

class _RecordWidgetState extends State<RecordWidget> {
  FlutterAudioRecorder2? _recorder;
  Recording? _current;
  RecordingStatus _currentStatus = RecordingStatus.Unset;
   late Timer timer;
  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding:  const EdgeInsets.all(8.0),
          child:  Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onLongPressEnd:(aa){
                          print("aa");
                          print(aa);
                          print("aa");

                        },
                        onLongPress: (){

                        },
                        onTap: () {
                        /*  switch (_currentStatus) {
                            case RecordingStatus.Initialized:
                              {
                                _start();
                                break;
                              }
                            case RecordingStatus.Recording:
                              {
                                _pause();
                                break;
                              }
                            case RecordingStatus.Paused:
                              {
                                _resume();
                                break;
                              }
                            case RecordingStatus.Stopped:
                              {
                                _init();
                                break;
                              }
                            default:
                              break;*/
                          //}
                        },
                        child: Text(_currentStatus.name),
                      ),
                    ),
                     TextButton(
                      onPressed:
                      _currentStatus != RecordingStatus.Unset ? _stop : null,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blueAccent.withOpacity(0.5),
                          )),
                      child:
                       const Text("Stop", style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                     TextButton(
                      onPressed: onPlayAudio,
                      child:
                       const Text("Play", style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blueAccent.withOpacity(0.5),
                          )),
                    ),
                  ],
                ),

              ]),
        ),
      ),
    );
  }

  _init() async {
    try {
      bool hasPermission = await FlutterAudioRecorder2.hasPermissions ?? false;

      if (hasPermission) {
        String customPath = '/flutter_audio_recorder_';
        io.Directory appDocDirectory;
//        io.Directory appDocDirectory = await getApplicationDocumentsDirectory();
        if (io.Platform.isIOS) {
          appDocDirectory = await getApplicationDocumentsDirectory();
        } else {
          appDocDirectory = (await getExternalStorageDirectory())!;
        }

        // can add extension like ".mp4" ".wav" ".m4a" ".aac"
        customPath = appDocDirectory.path +
            customPath +
            DateTime.now().millisecondsSinceEpoch.toString();

        // .wav <---> AudioFormat.WAV
        // .mp4 .m4a .aac <---> AudioFormat.AAC
        // AudioFormat is optional, if given value, will overwrite path extension when there is conflicts.
        _recorder =
            FlutterAudioRecorder2(customPath, audioFormat: AudioFormat.WAV);

        await _recorder!.initialized;
        // after initialization
        var current = await _recorder!.current(channel: 0);
        print(current);
        // should be "Initialized", if all working fine
        setState(() {
          _current = current;
          _currentStatus = current!.status!;
          print(_currentStatus);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content:  Text("You must accept permissions")));
      }
    } catch (e) {
      print(e);
    }
  }

  _start() async {
    try {
      await _recorder!.start();
      var recording = await _recorder!.current(channel: 0);
      setState(() {
        _current = recording;
      });

      const tick =  Duration(milliseconds: 50);
       Timer.periodic(tick, (Timer t) async {
        if (_currentStatus == RecordingStatus.Stopped) {
          t.cancel();
        }

        var current = await _recorder!.current(channel: 0);
        // print(current.status);
        setState(() {
          _current = current;
          _currentStatus = _current!.status!;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  _resume() async {
    await _recorder!.resume();
    setState(() {});
  }

  _pause() async {
    await _recorder!.pause();
    setState(() {});
  }

  _stop() async {
    var result = await _recorder!.stop();
    print("Stop recording: ${result!.path}");
    print("Stop recording: ${result.duration}");
   // File file = widget.localFileSystem.file(result.path);
  //  print("File length: ${await file.length()}");
    setState(() {
      _current = result;
      _currentStatus = _current!.status!;
    });
  }

  Widget _buildText(RecordingStatus status) {
    var text = "";
    switch (_currentStatus) {
      case RecordingStatus.Initialized:
        {
          text = 'Start';
          break;
        }
      case RecordingStatus.Recording:
        {
          text = 'Pause';
          break;
        }
      case RecordingStatus.Paused:
        {
          text = 'Resume';
          break;
        }
      case RecordingStatus.Stopped:
        {
          text = 'Init';
          break;
        }
      default:
        break;
    }
    return Text(text, style: TextStyle(color: Colors.white));
  }

  void onPlayAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(_current!.path!, isLocal: true).
    onError((error, stackTrace) async{
      print("error");
      print(error);
      print("error");
      return 0;
    });
  }
}
