import 'package:flutter/material.dart';
import 'package:sportsvenues/widget/collection.dart';
import 'package:sportsvenues/widget/login.dart';
import 'package:sportsvenues/widget/opinion.dart';
import 'package:sportsvenues/widget/profile.dart';


class AboutPage extends StatefulWidget {
  String userName;
  AboutPage({Key key, this.userName}) : super(key: key);
  @override
  _AboutPageState createState() => _AboutPageState();
}
class _AboutPageState extends State<AboutPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print(widget.userName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _topList(context),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: _bottomList(context),
          )
        ],
      ),
    );
  }

  Widget _topList(BuildContext context) {
    return widget.userName == null ? Container(
      color: Colors.grey[200],
      width: double.infinity,
      child: Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text('Hey,一起来一场篮球友谊赛吧',style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          new Container(
            width: MediaQuery.of(context).size.width/2,
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: RaisedButton(
              elevation: 3,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Login()
                  )
                );
              },
              child: Text("登录|注册", style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      )
    ) : Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      color: Colors.grey[200],
      width: double.infinity,
      child: ListTile(
        leading: ClipOval(
          child: Image.asset('images/about.jpg', width: 60, height: 60,fit: BoxFit.fill,),
        ), 
        title: new Row(
          children: <Widget>[
            new Text(widget.userName),
            Padding(
              padding: EdgeInsets.only(left: 20.0,right: 5.0),
              child: new Icon(Icons.local_florist, color: Colors.orange,),
            ),
            new Text('萌新', style: TextStyle(color: Colors.orange),)
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Profile(userName: widget.userName,),
            )
          );
        },
      ),
    );
  }

  Widget _bottomList(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          new ListTile(
            leading: Icon(Icons.assistant_photo),
            title: Text('我的活动'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Collection()
                )
              );
            }
          ),
          Divider(color: Colors.grey,),
          new ListTile(
            leading: Icon(Icons.border_color),
            title: Text('意见反馈'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Opinion()
                )
              );
            },
          ),
          Divider(color: Colors.grey,),
          new ListTile(
            leading: Icon(Icons.touch_app),
            title: Text('点赞评分'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('谢谢您的点赞'),)
              );
            },
          ),
        ],
      ),
    );
  }
}