import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:log_viewer/home/home.dart';
import 'package:log_viewer/log_parser/log_file.dart';
import 'package:log_viewer/theme.dart' as theme;
import 'package:log_viewer/window_menu_bar.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:fluent_window/fluent_window.dart';

final Uri repoUrl = Uri.parse('https://github.com/4A6F6F6E61/log_viewer');

Future<void> main() async {
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (_) {
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LogFile? currentFile;

  Future<void> openFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['log'],
    );

    if (result == null || result.files.isEmpty) {
      // TODO: Show Error Dialog
      return;
    }
    String path = result.files.single.path!;

    final logFile = await LogFile.file(path);

    await logFile.parse();

    setState(() {
      currentFile = logFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Log Viewer',
      theme: theme.themeData,

      home: FluentWindow(
        menuBar: WindowMenuBar(openFile: openFile),
        child: Home(
          currentFile: currentFile,
          setCurrentFile: (value) => setState(() {
            currentFile = value;
          }),
        ),
      ),
    );
  }
}
