import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/components/filter_toggle_button.dart';
import 'package:log_viewer/home/content.dart';
import 'package:log_viewer/log_parser/log_file.dart';
import 'package:log_viewer/theme.dart';

const double spacing = 10.0;

class Home extends StatefulWidget {
  const Home({super.key, required this.currentFile, required this.setCurrentFile});

  final LogFile? currentFile;
  final void Function(LogFile) setCurrentFile;

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late bool showFilter;

  late bool enableError;
  late bool enableWarning;
  late bool enableInfo;

  late AnimationController sizeAnimController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    sizeAnimController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    showFilter = false;
    enableError = true;
    enableWarning = true;
    enableInfo = true;
  }

  @override
  void dispose() {
    sizeAnimController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void toggleFilters() {
    setState(() {
      showFilter = !showFilter;
      if (showFilter) {
        sizeAnimController.forward();
      } else {
        sizeAnimController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          borderColor: Colors.transparent,
          padding: EdgeInsetsGeometry.all(0),
          borderRadius: BorderRadiusGeometry.circular(0),
          child: Padding(
            padding: const EdgeInsets.only(top: spacing, left: spacing, right: spacing),
            child: Column(
              children: [
                Row(
                  spacing: spacing,
                  children: [
                    Expanded(
                      child: TextBox(controller: searchController, placeholder: "Search..."),
                    ),
                    Button(
                      onPressed: toggleFilters,
                      child: Row(
                        children: [
                          Text("Filter"),
                          SizedBox(width: spacing),
                          Icon(showFilter ? FluentIcons.chevron_up : FluentIcons.chevron_down),
                        ],
                      ),
                    ),
                  ],
                ),
                SizeTransition(
                  sizeFactor: sizeAnimController,
                  child: Padding(
                    padding: EdgeInsets.only(top: spacing),
                    child: Row(
                      spacing: spacing,
                      children: [
                        // TODO: Generate this filter list based on the actual File
                        FilterToggleButton(
                          checked: enableError,
                          checkedColor: getFilterColor("Error", alpha: 69),
                          onChanged: (enable) {
                            setState(() {
                              enableError = enable;
                            });
                          },
                          label: "Error",
                        ),
                        FilterToggleButton(
                          checked: enableWarning,
                          checkedColor: getFilterColor("Warning", alpha: 69),
                          onChanged: (enable) {
                            setState(() {
                              enableWarning = enable;
                            });
                          },
                          label: "Warning",
                        ),
                        FilterToggleButton(
                          checked: enableInfo,
                          checkedColor: getFilterColor("Info", alpha: 69),
                          onChanged: (enable) {
                            setState(() {
                              enableInfo = enable;
                            });
                          },
                          label: "Info",
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  borderColor: Colors.transparent,
                  padding: EdgeInsetsGeometry.all(0),
                  borderRadius: BorderRadiusGeometry.circular(0),
                  child: SizedBox(height: spacing),
                ),
              ],
            ),
          ),
        ),
        Content(currentFile: widget.currentFile),
      ],
    );
  }
}
