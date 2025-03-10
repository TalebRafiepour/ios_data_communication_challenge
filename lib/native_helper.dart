import 'package:flutter/services.dart';

class NativeHelper {
  static const _instance = NativeHelper._();

  factory NativeHelper() => _instance;

  const NativeHelper._();


  static const eventChannel = EventChannel('com.example.test/timer_event');

  Stream<dynamic> get getTime {
    try {
      return eventChannel.receiveBroadcastStream();
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
