import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:log_viewer/main.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO: Make every entry do something
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
            MenuFlyoutItem(text: const Text('Open'), onPressed: openFile),
            const MenuFlyoutSeparator(),
            MenuFlyoutItem(
              text: const Text('Exit'),
              onPressed: () {
                appWindow.close();
              },
            ),
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
          items: [
            MenuFlyoutItem(
              text: const Text('About'),
              onPressed: () async {
                await showDialog<String>(
                  context: context,
                  builder: (context) => ContentDialog(
                    title: const Text('Log Viewer'),
                    content: const Text(
                      'A simple log file viewer using the Fluent design build with Flutter by Joona Brückner',
                    ),
                    actions: [
                      FilledButton(
                        child: const Text('Github'),
                        onPressed: () async {
                          Navigator.pop(context);
                          if (!await launchUrl(repoUrl)) {
                            throw Exception('Could not launch $repoUrl');
                          }
                        },
                      ),
                      Button(child: const Text('Done'), onPressed: () => Navigator.pop(context)),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
