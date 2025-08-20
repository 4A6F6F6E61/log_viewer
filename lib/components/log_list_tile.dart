import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/log_parser/log_file.dart';

Color getFilterColor(String filter) {
  switch (filter.toLowerCase()) {
    case "error":
      return Colors.red;
    case "warn":
    case "warning":
      return Colors.yellow;
    case "info":
    case "notice":
      return Colors.green;
  }
  return Colors.magenta;
}

class LogListTile extends StatefulWidget {
  const LogListTile({super.key, required this.entry});

  final LogEntry entry;

  @override
  State<LogListTile> createState() => _LogListTileState();
}

class _LogListTileState extends State<LogListTile> {
  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Expander(
        header: Text.rich(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          TextSpan(
            children: [
              TextSpan(
                text: "[${entry.filter}]",
                style: TextStyle(color: getFilterColor(entry.filter)),
              ),
              TextSpan(text: entry.content),
            ],
          ),
        ),
        content: Text(entry.content),
      ),
    );
  }
}
