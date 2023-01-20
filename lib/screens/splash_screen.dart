import 'package:flutter/material.dart';
import 'package:news_flutter/logics/news_logic.dart';
import 'package:news_flutter/screens/home.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    //await context.read<RandomUserLogic>().read();
    await context.read<NewsLogic>().read();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        print("Navigate");
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      }

    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.supervised_user_circle, size: 100),
      ),
    );
  }
}
