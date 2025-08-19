import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/components/filter_toggle_button.dart';
import 'package:log_viewer/home/content.dart';

const double spacing = 8.0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> with SingleTickerProviderStateMixin {
  late TextEditingController searchController;
  late bool showFilter;

  late bool enableError;
  late bool enableWarning;

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
                  children: [
                    Expanded(
                      child: TextBox(controller: searchController, placeholder: "Search..."),
                    ),
                    SizedBox(width: 10),
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
                      children: [
                        FilterToggleButton(
                          checked: enableError,
                          checkedColor: Colors.red.withAlpha(69),
                          onChanged: (enable) {
                            setState(() {
                              enableError = enable;
                            });
                          },
                          label: "Error",
                        ),
                        SizedBox(width: 10),
                        FilterToggleButton(
                          checked: enableWarning,
                          checkedColor: Colors.yellow.withAlpha(69),
                          onChanged: (enable) {
                            setState(() {
                              enableWarning = enable;
                            });
                          },
                          label: "Warning",
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
        Content(),
      ],
    );
  }
}
