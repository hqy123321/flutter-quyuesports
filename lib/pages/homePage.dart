import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'searchBar.dart';
import 'venuesList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{

   @override
  bool get wantKeepAlive => true;

  DateTime _dateTime = DateTime.now();
  String venues = '[{"title": "城市玩家运动空间", "address": "火炬高新区", "floor": "木质地板", "service": "WIFI", "score": "4.6分"},'
  '{"title": "逸飞准备运动公园", "address": "湖里区","floor": "硅PU", "service": "WIFI,会员卡,专业培训", "score": "4.8分"},'
  '{"title": "翔俊羽综合体育馆", "address": "新店镇", "floor": "塑料地板", "service": "WIFI,会员卡,专业培训", "score": "4.7分"},'
  '{"title": "少年强篮球大同馆", "address": "大同街道", "floor": "木质地板", "service": "专业培训", "score": "4.6分"},'
  '{"title": "劲动篮球馆", "address": "观澜街道", "floor": "木质地板", "service": "专业培训,WIFI", "score": "4.4分"},'
  '{"title": "天空篮球公园", "address": "翔安区", "floor": "塑料地板", "service": "WIFI,会员卡,专业培训", "score": "4.8分"},'
  '{"title": "留仙洞篮球场", "address": "海沧区", "floor": "木质地板", "service": "会员卡", "score": "4.9分"},'
  '{"title": "新莲华科技蓝羽馆", "address": "第三大道", "floor": "硅PU", "service": "会员卡,专业培训", "score": "3.8分"},'
  '{"title": "第七区篮球公园", "address": "湖里区", "floor": "塑料地板", "service": "WIFI,会员卡", "score": "4.8分"}]';
  List _list = [];
 Future<Null> _vslist() async{
    _list = jsonDecode(venues);
    await new Future.delayed(new Duration(seconds: 3));
    print(_list.first);
    return null ;
  }
  @override
  void initState() {
    super.initState();
    _vslist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: RefreshIndicator(
        onRefresh: _vslist,
        child: _body(),
      )
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text('厦门'),)
          );
        },
        child: new Row(
          children: <Widget>[
            new Icon(Icons.pin_drop),
            new Text('厦门'),
          ],
        ),
      ),
      title: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: searchBarDelegate());
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border: Border.all(width: 1, color: Colors.white)
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text('请输入场馆名称或地址', style: TextStyle(fontSize: 10.0),),
                new Icon(Icons.search, size: 15.0,)
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('签到成功'),)
            );
          },
          icon: Icon(Icons.touch_app),
        )
      ],
    );
  }

  Widget _body() {
    return ListView(
      children: <Widget>[
        new Container(
          child: AspectRatio(
            aspectRatio: 16/9,
            child: Container(
              child: Image.asset("images/home.jpg", fit: BoxFit.fill,)
            )
          ),
        ),
        new Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                trailing: GestureDetector(
                  onTap: () {
                    DatePicker.showDateTimePicker(context,
                      // 是否展示顶部操作按钮
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                        _dateTime = date ;
                        });
                      },
                      // 当前时间
                      currentTime: DateTime.now(),
                      // 语言
                      locale: LocaleType.zh);
                  },
                  child: Icon(Icons.today),
                ),
                title: Text("${_dateTime.month}月"+"${_dateTime.day}日"),
              ),
              Divider(color: Colors.grey),
              ListTile(
                trailing: GestureDetector(
                  onTap: () {
                    DatePicker.showTimePicker(context,
                      showTitleActions: true,
                      onConfirm: (date) {
                        setState(() {
                          _dateTime = date ;
                        });
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.zh
                    );
                  },
                  child: Icon(Icons.access_time),
                ),
                title: Text("${_dateTime.hour}时"+"${_dateTime.minute}分"),
              ),
              Divider(color: Colors.grey),
              new Container(
                width: double.infinity,
                child: RaisedButton(
                  elevation: 3.0,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) {
                          return VenuesList(list: _list);
                        }
                      )
                    );
                  },
                  child: Text("立即找场", style: TextStyle(color: Colors.white),),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text('热门推荐'),
              ),
              ListTile(
                title: Text(_list[0]['title']),
                subtitle: Text(_list[0]['address']),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Venues(list: _list, index: 0,)
                    )
                  );
                },
              ),
              Divider(color: Colors.grey,),
              ListTile(
                title: Text(_list[1]['title']),
                subtitle: Text(_list[1]['address']),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Venues(list: _list, index: 1,)
                    )
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}