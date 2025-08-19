import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/home/content.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  bool showFilter = false;

  bool enableError = true;
  bool enableWarning = true;
  bool enableInfo = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          borderColor: Colors.transparent,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextBox(controller: searchController, placeholder: "Search..."),
                  ),
                  SizedBox(width: 10),
                  // This Button toggles the filters
                  Button(
                    onPressed: () {
                      setState(() {
                        showFilter = !showFilter;
                      });
                    },
                    child: Row(
                      children: [
                        Text("Filter"),
                        SizedBox(width: 8),
                        Icon(FluentIcons.chevron_down),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 10),
                child: Row(
                  children: [
                    ToggleButton(
                      checked: enableError,
                      onChanged: (enable) {
                        setState(() {
                          enableError = enable;
                        });
                      },
                      style: ToggleButtonThemeData(
                        checkedButtonStyle: ButtonStyle(
                          backgroundColor: WidgetStateMapper({
                            WidgetState.any: Colors.red.withAlpha(69),
                          }),
                        ),
                      ),
                      child: Text("Error"),
                    ),
                    ToggleButton(
                      checked: enableWarning,
                      onChanged: (enable) {
                        setState(() {
                          enableWarning = enable;
                        });
                      },
                      style: ToggleButtonThemeData(
                        checkedButtonStyle: ButtonStyle(
                          backgroundColor: WidgetStateMapper({
                            WidgetState.any: Colors.yellow.withAlpha(69),
                          }),
                        ),
                      ),
                      child: Text("Waring"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Content(),
      ],
    );
  }
}
