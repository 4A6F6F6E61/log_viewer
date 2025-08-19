import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:log_viewer/window/window_title_bar.dart';

// TODO: Move Window code into seperate Package, so it can be easily reused in other projects
class AppWindow extends StatelessWidget {
  const AppWindow({super.key, required this.child});

  final Widget child;

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

var _orientation = 'landscape';
var _iconSize = 'medium_icons';

// TODO: Implement actual menubar
var menuBar = MenuBar(
  items: [
    MenuBarItem(
      title: 'File',
      items: [
        MenuFlyoutSubItem(
          text: const Text('New'),
          items: (context) {
            return [
              MenuFlyoutItem(text: const Text('Plain Text Documents'), onPressed: () {}),
              MenuFlyoutItem(text: const Text('Rich Text Documents'), onPressed: () {}),
              MenuFlyoutItem(text: const Text('Other Formats'), onPressed: () {}),
            ];
          },
        ),
        MenuFlyoutItem(text: const Text('Open'), onPressed: () {}),
        MenuFlyoutItem(text: const Text('Save'), onPressed: () {}),
        const MenuFlyoutSeparator(),
        MenuFlyoutItem(text: const Text('Exit'), onPressed: () {}),
      ],
    ),
    MenuBarItem(
      title: 'Edit',
      items: [
        MenuFlyoutItem(text: const Text('Undo'), onPressed: () {}),
        MenuFlyoutItem(text: const Text('Cut'), onPressed: () {}),
        MenuFlyoutItem(text: const Text('Copy'), onPressed: () {}),
        MenuFlyoutItem(text: const Text('Paste'), onPressed: () {}),
      ],
    ),
    MenuBarItem(
      title: 'View',
      items: [
        MenuFlyoutItem(text: const Text('Output'), onPressed: () {}),
        const MenuFlyoutSeparator(),
        RadioMenuFlyoutItem<String>(
          text: const Text('Landscape'),
          value: 'landscape',
          groupValue: _orientation,
          onChanged: (v) => {},
        ),
        RadioMenuFlyoutItem<String>(
          text: const Text('Portrait'),
          value: 'portrait',
          groupValue: _orientation,
          onChanged: (v) => {},
        ),
        const MenuFlyoutSeparator(),
        RadioMenuFlyoutItem<String>(
          text: const Text('Small icons'),
          value: 'small_icons',
          groupValue: _iconSize,
          onChanged: (v) => {},
        ),
        RadioMenuFlyoutItem<String>(
          text: const Text('Medium icons'),
          value: 'medium_icons',
          groupValue: _iconSize,
          onChanged: (v) => {},
        ),
        RadioMenuFlyoutItem<String>(
          text: const Text('Large icons'),
          value: 'large_icons',
          groupValue: _iconSize,
          onChanged: (v) => {},
        ),
      ],
    ),
    MenuBarItem(
      title: 'Help',
      items: [MenuFlyoutItem(text: const Text('About'), onPressed: () {})],
    ),
  ],
);
