import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:log_viewer/window/window_menu_bar.dart';
import 'package:log_viewer/window/window_title_bar.dart';

// TODO: Move Window code into seperate Package, so it can be easily reused in other projects
class AppWindow extends StatelessWidget {
  const AppWindow({super.key, required this.child, required this.menuBar});

  final Widget child;
  final Widget? menuBar;

  @override
  Widget build(BuildContext context) {
    if (!Platform.isLinux) {
      Window.setEffect(
        effect: WindowEffect.acrylic,
        color: Color(0xCC222222),
        dark: FluentTheme.of(context).brightness == Brightness.dark,
      );

      return Column(
        children: [
          WindowTitleBar(),
          Expanded(child: child),
        ],
      );
    }
    Window.setEffect(
      effect: WindowEffect.transparent,
      color: Colors.transparent,
      dark: FluentTheme.of(context).brightness == Brightness.dark,
    );
    // Fake Acrylic effect for development because it doesn't work under Linux
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/background_red.png"), fit: BoxFit.cover),
      ),
      child: Acrylic(
        tint: Color(0xCC222222),
        blurAmount: 20,
        child: Column(
          children: [
            WindowTitleBar(menuBar: menuBar),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
