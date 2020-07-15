import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

enum Xingbie {nan, nv}
enum Nianling {qi, ba, jiu}
enum Shuiping {one, two, three, four}
class Profile extends StatefulWidget {
  String userName;
  Profile({Key key, this.userName}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String chice;
  String nl;
  String sp;
  _setProfile() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(chice,_chice);
    prefs.setString(nl, _nl);
    prefs.setString(sp, _sp);
  }
  _getProfile() async{
    final prefs = await SharedPreferences.getInstance();
  }
  String _chice = "";                //性别选择框
  String _nl = "";                   //年龄选择框
  String _sp ="" ;                   //水平选择框
  Color _colors = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的资料'),
        centerTitle: true,
      ),
      body: _body(),
    );
  }
  Widget _body() {
    return Container(
      color: Colors.grey[200],
      width: double.infinity,
      child: Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 10.0),
            color: _colors,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: new Text('头像'),
                ),
                new GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "头像");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        new ClipOval(
                          child: Container(
                            color: Colors.grey,
                            height: 60.0,
                            width: 60.0,
                          ),
                        ),
                        new Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                )
              ],
            )
          ),
          new Container(
            color: _colors,
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('我的等级'),
                  new GestureDetector(
                    onTap: () {
                      Fluttertoast.showToast(msg: "等级:  萌新");
                    },
                    child: Row(
                      children: <Widget>[
                        new Icon(Icons.local_florist, color: Colors.orange,),
                        new Text('萌新', style: TextStyle(color: Colors.orange),),
                        new Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
          _bottomList(),
          new Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: RaisedButton(
              elevation: 3,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                  (route) => route == null
                );
              },
              child: Text("退出登录", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }

  Widget _bottomList() {
    return Container(
      color: _colors,
      child: Column(
        children: <Widget>[
          new GestureDetector(         //昵称
            child: new Padding(
              padding: EdgeInsets.only(left: 15.0, top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('昵称'),
                  new Row(
                    children: <Widget>[
                      new Text(widget.userName),
                      new Icon(Icons.keyboard_arrow_right)
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200],),
          new GestureDetector(         //性别
            onTap: () {
              _xingbie(context);
            },
            child: new Container(
              padding: EdgeInsets.only(left: 15.0, top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('性别'),
                  new Row(
                    children: <Widget>[
                      new Text("$_chice"),
                      new Icon(Icons.keyboard_arrow_right)
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200],),
          new GestureDetector(         //年龄
            onTap: () {
              _nianling(context);
            },      
            child: new Padding(
              padding: EdgeInsets.only(left: 15.0, top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('年龄'),
                  new Row(
                    children: <Widget>[
                      new Text("$_nl"),
                      new Icon(Icons.keyboard_arrow_right)
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey[200],),
          new GestureDetector(         //水平
            onTap: () {
              _shuiping(context);
            },
            child: new Padding(
              padding: EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('水平'),
                  new Row(
                    children: <Widget>[
                      new Text("$_sp"),
                      new Icon(Icons.keyboard_arrow_right)
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future _xingbie(BuildContext context) async{         ///性别对话框
    final xingbie = await showDialog(context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('性别'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('男'),
              onPressed: () {
              Navigator.of(context).pop(Xingbie.nan);
              },
            ),
            SimpleDialogOption(
              child: Text('女'),
              onPressed: () {
              Navigator.of(context).pop(Xingbie.nv);
              },
            ),
          ],
        );
      }
    );
    switch(xingbie) {
      case Xingbie.nan:setState(() {
      _chice = "男";
      });
      break;
      case Xingbie.nv:setState(() {
        _chice = "女";
      });
      break;
     default:
    }
  }
  Future _nianling(BuildContext context) async{         ///年龄对话框
    final nianling = await showDialog(context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('年龄'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('70后'),
              onPressed: () {
              Navigator.of(context).pop(Nianling.qi);
              },
            ),
            SimpleDialogOption(
              child: Text('80后'),
              onPressed: () {
              Navigator.of(context).pop(Nianling.ba);
              },
            ),
            SimpleDialogOption(
              child: Text('90后'),
              onPressed: () {
              Navigator.of(context).pop(Nianling.jiu);
              },
            ),
          ],
        );
      }
    );
    switch(nianling) {
      case Nianling.qi:setState(() {
      _nl = "70后";
      });
      break;
      case Nianling.ba:setState(() {
      _nl = "80后";
      });
      break;
      case Nianling.jiu:setState(() {
        _nl = "90后";
      });
      break;
     default:
    }
  }
  Future _shuiping(BuildContext context) async{         ///水平对话框
    final shuiping = await showDialog(context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('水平'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('初学者'),
              onPressed: () {
              Navigator.of(context).pop(Shuiping.one);
              },
            ),
            SimpleDialogOption(
              child: Text('一般'),
              onPressed: () {
              Navigator.of(context).pop(Shuiping.two);
              },
            ),
            SimpleDialogOption(
              child: Text('业余爱好'),
              onPressed: () {
              Navigator.of(context).pop(Shuiping.three);
              },
            ),
            SimpleDialogOption(
              child: Text('高手'),
              onPressed: () {
              Navigator.of(context).pop(Shuiping.four);
              },
            ),
          ],
        );
      }
    );
    switch(shuiping) {
      case Shuiping.one:setState(() {
      _sp = "初学者";
      });
      break;
      case Shuiping.two:setState(() {
      _sp = "一般";
      });
      break;
      case Shuiping.three:setState(() {
      _sp = "业余爱好";
      });
      break;
      case Shuiping.four:setState(() {
        _sp = "高手";
      });
      break;
     default:
    }
  }
}