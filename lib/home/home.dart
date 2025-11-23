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

  Map<String, bool> enabledFilters = {};

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
    // Update the filters
    widget.currentFile?.filters.forEach((filter) {
      if (enabledFilters.containsKey(filter)) return;
      enabledFilters[filter] = true;
    });
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
                    child: SizedBox(
                      height: 50,
                      width: double.maxFinite,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          if (widget.currentFile != null)
                            for (final entry in enabledFilters.entries)
                              FilterToggleButton(
                                checked: entry.value,
                                checkedColor: getFilterColor(entry.key, alpha: 69),
                                onChanged: (v) {
                                  setState(() {
                                    enabledFilters[entry.key] = v;
                                  });
                                },
                                label: entry.key,
                              ),
                        ],
                      ),
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
