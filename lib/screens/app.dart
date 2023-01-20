import 'package:flutter/material.dart';
import 'package:news_flutter/logics/news_logic.dart';
import 'package:news_flutter/screens/splash_screen.dart';
import 'package:provider/provider.dart';
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NewsLogic()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}