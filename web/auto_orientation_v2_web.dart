import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Web implementation of the AutoOrientationPlugin.
class AutoOrientationWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'auto_orientation',
      const StandardMethodCodec(),
      registrar,
    );
    final pluginInstance = AutoOrientationWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    try {
      final html.ScreenOrientation? orientation = html.window.screen?.orientation;
      if (orientation == null) return null;

      switch (call.method) {
        case 'setLandscapeRight':
        case 'setLandscapeAuto':
          await orientation.lock('landscape-primary');
          break;
        case 'setLandscapeLeft':
          await orientation.lock('landscape-secondary');
          break;
        case 'setPortraitUp':
        case 'setPortraitAuto':
          await orientation.lock('portrait-primary');
          break;
        case 'setPortraitDown':
          await orientation.lock('portrait-secondary');
          break;
        case 'setAuto':
        case 'setScreenOrientationUser':
          orientation.unlock();
          break;
        default:
          throw PlatformException(
            code: 'Unimplemented',
            details: 'auto_orientation_v2 for Web does not implement ${call.method}',
          );
      }
    } catch (_) {
      // Fallback gracefully on browsers without ScreenOrientation API
    }
    return null;
  }
}
