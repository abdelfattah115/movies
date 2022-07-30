import 'package:flutter/material.dart';
import 'package:movies/core/services/service_locator.dart';
import 'package:movies/movies/presentation/screen/movies_screen.dart';

void main() {
  ServiceLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainMoviesScreen(),
    );
  }
}
