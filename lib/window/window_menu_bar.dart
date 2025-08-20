import 'package:fluent_ui/fluent_ui.dart';

class WindowMenuBar extends StatelessWidget {
  const WindowMenuBar({super.key, required this.openFile});

  final void Function() openFile;

  @override
  Widget build(BuildContext context) {
    return MenuBar(
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
            MenuFlyoutItem(text: const Text('Open'), onPressed: openFile),
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
              groupValue: "landscape",
              onChanged: (v) => {},
            ),
            RadioMenuFlyoutItem<String>(
              text: const Text('Portrait'),
              value: 'portrait',
              groupValue: "landscape",
              onChanged: (v) => {},
            ),
            const MenuFlyoutSeparator(),
            RadioMenuFlyoutItem<String>(
              text: const Text('Small icons'),
              value: 'small_icons',
              groupValue: "medium_icons",
              onChanged: (v) => {},
            ),
            RadioMenuFlyoutItem<String>(
              text: const Text('Medium icons'),
              value: 'medium_icons',
              groupValue: "medium_icons",
              onChanged: (v) => {},
            ),
            RadioMenuFlyoutItem<String>(
              text: const Text('Large icons'),
              value: 'large_icons',
              groupValue: "medium_icons",
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
  }
}
