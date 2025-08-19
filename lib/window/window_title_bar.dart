import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/window/window_buttons.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Acrylic(
      child: SizedBox(
        width: double.infinity,
        height: appWindow.titleBarButtonSize.height,
        child: MoveWindow(
          child: Row(
            children: [
              Expanded(child: Row(children: [SizedBox(width: 8), Text("Log Viewer")])),
              WindowButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
