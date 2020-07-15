import 'package:flutter/material.dart';

import './pages/nbaPage.dart';
import './pages/aboutPage.dart';
import './pages/homePage.dart';


class Tabs extends StatefulWidget {
  String userName;
  Tabs({Key key, this.userName}) : super(key: key);
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  
  int _currendIndex = 0 ;
  List<Widget> page = new List();
  @override
  void initState() {
    super.initState();
    page
    ..add(HomePage())
    ..add(NbaPage(userName: widget.userName,))
    ..add(AboutPage(userName: widget.userName,));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currendIndex, children: page,),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currendIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currendIndex = index ;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('首页')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.public),
              title: Text('发现')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('我的')
          ),
        ],
      ),
    );
  }
}
