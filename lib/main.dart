import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:log_viewer/home/home.dart';
import 'package:log_viewer/theme.dart' as theme;
import 'package:log_viewer/window/window.dart';
import 'package:scaled_app/scaled_app.dart';

Future<void> main() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (size) {
      if (Platform.isLinux) {
        return 1.2;
      }
      return 1;
    },
  );
  await Window.initialize();

  if (Platform.isWindows) {
    await Window.hideWindowControls();
  }

  runApp(const MyApp());

  if (!Platform.isMacOS) {
    doWhenWindowReady(() {
      appWindow
        ..minSize = Size(640, 360)
        ..size = Size(1300, 800)
        ..alignment = Alignment.center
        ..show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',
      theme: theme.themeData,
      home: const AppWindow(child: Home()),
    );
  }
}
