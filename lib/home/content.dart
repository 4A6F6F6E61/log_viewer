import 'dart:developer' as dev;

import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/components/log_list_tile.dart';
import 'package:log_viewer/log_parser/log_file.dart';

class Content extends StatefulWidget {
  const Content({super.key, required this.currentFile});

  final LogFile? currentFile;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  Widget buildItem(BuildContext context, int i, Animation<double> _) {
    return LogListTile(entry: widget.currentFile!.entries[i]);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 8.0),
        child: widget.currentFile != null
            ? AnimatedList(
                key: listKey,
                initialItemCount: widget.currentFile!.entries.length,
                itemBuilder: buildItem,
                padding: EdgeInsetsGeometry.symmetric(horizontal: 8.0),
              )
            : Center(child: Text("Please Open a Log File")),
      ),
    );
  }
}
