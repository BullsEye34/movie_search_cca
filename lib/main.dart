import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_search/di/injection_container.dart' as di;
import 'package:movie_search/features/movie_search/presentation/pages/movie_search_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themee = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Number Trivia',
      theme: themee.copyWith(
        colorScheme: themee.colorScheme.copyWith(
          secondary: Color(0xff140FA6),
        ),
      ),
      home: MovieSearchpage(),
    );
  }
}
