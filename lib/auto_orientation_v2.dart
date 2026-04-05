import 'package:flutter/services.dart';

/// Available modes for device orientation.
enum AutoOrientationMode {
  /// Force landscape right orientation.
  landscapeRight,

  /// Force landscape left orientation.
  landscapeLeft,

  /// Force portrait up orientation.
  portraitUp,

  /// Force portrait down orientation (may not be supported on all devices).
  portraitDown,

  /// Automatic portrait orientation (Up/Down) based on sensor.
  portraitAuto,

  /// Automatic landscape orientation (Left/Right) based on sensor.
  landscapeAuto,

  /// Full automatic orientation (all 4 directions) based on sensor.
  fullAuto,

  /// Reset to user-controlled orientation.
  user,
}

/// A Flutter plugin to programmatically control device orientation on iOS and Android.
class AutoOrientation {
  static const MethodChannel _channel = MethodChannel('auto_orientation');

  /// Set the device orientation to a specific [mode].
  ///
  /// The [forceSensor] parameter is only applicable on Android for "auto" modes,
  /// forcing the orientation based on the hardware sensor even if the user has
  /// disabled auto-rotation in system settings.
  static Future<void> setOrientation(
    AutoOrientationMode mode, {
    bool forceSensor = false,
  }) async {
    try {
      switch (mode) {
        case AutoOrientationMode.landscapeRight:
          await landscapeRightMode();
          break;
        case AutoOrientationMode.landscapeLeft:
          await landscapeLeftMode();
          break;
        case AutoOrientationMode.portraitUp:
          await portraitUpMode();
          break;
        case AutoOrientationMode.portraitDown:
          await portraitDownMode();
          break;
        case AutoOrientationMode.portraitAuto:
          await portraitAutoMode(forceSensor: forceSensor);
          break;
        case AutoOrientationMode.landscapeAuto:
          await landscapeAutoMode(forceSensor: forceSensor);
          break;
        case AutoOrientationMode.fullAuto:
          await fullAutoMode(forceSensor: forceSensor);
          break;
        case AutoOrientationMode.user:
          await setScreenOrientationUser();
          break;
      }
    } on MissingPluginException catch (_) {
      return;
    } catch (e) {
      rethrow;
    }
  }

  /// Rotates the device to landscape left mode.
  static Future<void> landscapeLeftMode() async {
    try {
      await _channel.invokeMethod('setLandscapeLeft');
    } on MissingPluginException catch (_) {
      return;
    }
  }

  /// Rotates the device to landscape right mode.
  static Future<void> landscapeRightMode() async {
    try {
      await _channel.invokeMethod('setLandscapeRight');
    } on MissingPluginException catch (_) {
      return;
    }
  }

  /// Rotates the device to portrait up mode.
  static Future<void> portraitUpMode() async {
    try {
      await _channel.invokeMethod('setPortraitUp');
    } on MissingPluginException catch (_) {
      return;
    }
  }

  /// Rotates the device to portrait down mode.
  static Future<void> portraitDownMode() async {
    try {
      await _channel.invokeMethod('setPortraitDown');
    } on MissingPluginException catch (_) {
      return;
    }
  }

  /// Rotates the device to portrait auto mode.
  ///
  /// If [forceSensor] is true (Android only), it uses the physical sensor
  /// regardless of system auto-rotate settings.
  static Future<void> portraitAutoMode({bool forceSensor = false}) async {
    try {
      await _channel.invokeMethod(
        'setPortraitAuto',
        {'forceSensor': forceSensor},
      );
    } on MissingPluginException catch (_) {
      return;
    }
  }

  /// Rotates the device to landscape auto mode.
  ///
  /// If [forceSensor] is true (Android only), it uses the physical sensor
  /// regardless of system auto-rotate settings.
  static Future<void> landscapeAutoMode({bool forceSensor = false}) async {
    try {
      await _channel.invokeMethod(
        'setLandscapeAuto',
        {'forceSensor': forceSensor},
      );
    } on MissingPluginException catch (_) {
      return;
    }
  }

  /// Rotates the device to full auto mode (all orientations).
  ///
  /// If [forceSensor] is true (Android only), it uses the physical sensor
  /// regardless of system auto-rotate settings.
  static Future<void> fullAutoMode({bool forceSensor = false}) async {
    try {
      await _channel.invokeMethod('setAuto', {'forceSensor': forceSensor});
    } on MissingPluginException catch (_) {
      return;
    }
  }

  /// Resets the orientation to the user's system preferences.
  static Future<void> setScreenOrientationUser() async {
    try {
      await _channel.invokeMethod('setScreenOrientationUser');
    } on MissingPluginException catch (_) {
      return;
    }
  }
}
