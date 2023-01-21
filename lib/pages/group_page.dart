import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isDarkTheme = theme.brightness == Brightness.dark;

    return Scaffold(
        body: Container(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: isDarkTheme ? null : Color(0xFFEFF5F5),
          ),
          SafeArea(
            child: Container(
              color: isDarkTheme ? null : Color(0xFFEFF5F5),
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              child: Column(
                children: <Widget>[
                  _header(),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(height: 16),
                  Expanded(child: _body()),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Group',
              style: TextStyle(
                fontSize: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Enterprise News',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          SizedBox(
            height: 6,
          ),
          Container(height: 2, width: 230, color: Colors.black),
          SizedBox(
            height: 6,
          ),
          Text('Version 1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.blue.shade400)),
          SizedBox(
            height: 16,
          ),
          Text('1-Sout Ruoshim',
              style: TextStyle(fontSize: 24, color: Colors.black)),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),
          Text('2-Sin Samthib',
              style: TextStyle(fontSize: 24, color: Colors.black)),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),
          Text('3-Sreng Poutry',
              style: TextStyle(fontSize: 24, color: Colors.black)),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),
          Text('4-Heang Seyla',
              style: TextStyle(fontSize: 24, color: Colors.black)),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),
          Text('5-Kann Makara',
              style: TextStyle(fontSize: 24, color: Colors.black)),
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
