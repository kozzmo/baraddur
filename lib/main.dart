import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_game_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baraddur',
      home: Scaffold(
          body: MainGamePage()
      ),
    );
  }
}