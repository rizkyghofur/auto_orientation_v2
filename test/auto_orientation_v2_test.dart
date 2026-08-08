import 'package:auto_orientation_v2/auto_orientation_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('auto_orientation');
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      log.add(methodCall);
      return null;
    });
    log.clear();
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('setOrientation landscapeRight calls native method', () async {
    await AutoOrientation.setOrientation(AutoOrientationMode.landscapeRight);
    expect(log, <Matcher>[
      isMethodCall('setLandscapeRight', arguments: null),
    ]);
  });

  test('setOrientation portraitUp calls native method', () async {
    await AutoOrientation.setOrientation(AutoOrientationMode.portraitUp);
    expect(log, <Matcher>[
      isMethodCall('setPortraitUp', arguments: null),
    ]);
  });

  test('setOrientation landscapeAuto with forceSensor calls native method',
      () async {
    await AutoOrientation.setOrientation(
      AutoOrientationMode.landscapeAuto,
      forceSensor: true,
    );
    expect(log, <Matcher>[
      isMethodCall('setLandscapeAuto', arguments: {'forceSensor': true}),
    ]);
  });

  test('setOrientation user calls native method', () async {
    await AutoOrientation.setOrientation(AutoOrientationMode.user);
    expect(log, <Matcher>[
      isMethodCall('setScreenOrientationUser', arguments: null),
    ]);
  });

  test('landscapeRightMode calls native method', () async {
    await AutoOrientation.landscapeRightMode();
    expect(log, <Matcher>[
      isMethodCall('setLandscapeRight', arguments: null),
    ]);
  });

  testWidgets(
      'AutoOrientationScope applies targetMode on init and onDisposeMode on dispose',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AutoOrientationScope(
          targetMode: AutoOrientationMode.landscapeRight,
          onDisposeMode: AutoOrientationMode.portraitUp,
          child: Text('Scoped Screen'),
        ),
      ),
    );

    expect(log, <Matcher>[
      isMethodCall('setLandscapeRight', arguments: null),
    ]);

    log.clear();

    await tester.pumpWidget(
      const MaterialApp(
        home: Text('Other Screen'),
      ),
    );

    expect(log, <Matcher>[
      isMethodCall('setPortraitUp', arguments: null),
    ]);
  });
}
