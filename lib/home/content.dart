import 'dart:developer' as dev;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/log_parser/log_file.dart';

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Button(
          onPressed: () async {
            final logFile = await LogFile.asset("/assets/example.log");

            logFile.parse();

            dev.log("First Line:", name: "LogParser");
            dev.log(logFile.entries.first.toString(), name: "");
            dev.log("------------------------------------------", name: "LogParser");
          },
          child: Text("Load LogFile"),
        ),
      ),
    );
  }
}
