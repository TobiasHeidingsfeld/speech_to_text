import 'dart:async';
import 'dart:html' as html;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextPlugin {
  static const String PLATFORM_CHANNEL = "plugin.csdcorp.com/speech_to_text";
  static MethodChannel channel;

  static void registerWith(Registrar registrar) {
    channel = MethodChannel(PLATFORM_CHANNEL, const StandardMethodCodec(), registrar.messenger);
    final instance = SpeechToTextPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  SpeechToTextPlugin() {
    speechRecognition.onResult.listen(_handleResult);
    speechRecognition.interimResults = true;
    speechRecognition.continuous = true;
    speechRecognition.lang = "de-DE";
  }

  html.SpeechRecognition speechRecognition = html.SpeechRecognition();

  Future<dynamic> handleMethodCall(MethodCall call) async {
    print(call);

    switch (call.method) {
      case "initialize":
        return true;
      case SpeechToText.listenMethod:
        speechRecognition.start();
        return true;
      case "stop":
        speechRecognition.stop();
        return true;
      default:
    }
  }

  void _handleResult(html.SpeechRecognitionEvent event) {
    print(event.results);
    //channel.invokeMethod(SpeechToText.textRecognitionMethod, {});
  }
}
