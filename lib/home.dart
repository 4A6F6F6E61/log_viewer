import 'package:fluent_ui/fluent_ui.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: Text(widget.title),
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter'),
            Button(onPressed: _incrementCounter, child: const Icon(FluentIcons.add)),
          ],
        ),
      ),
    );
  }
}
