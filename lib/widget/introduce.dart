import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../database/user_table_provider.dart';
import '../database/user.dart';

class Introduce extends StatefulWidget {
  final User user;
  Introduce(this.user);

  @override
  _IntroduceState createState() => _IntroduceState(user);
}

class _IntroduceState extends State<Introduce> {
  UserDbProvider provider = UserDbProvider();
  User user;

  _IntroduceState(this.user);

  DateTime _dateTime = DateTime.now();
  TextEditingController zhuti = new TextEditingController();
  TextEditingController renshu = new TextEditingController();
  TextEditingController xiangqin = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    zhuti.text = user.name;
    xiangqin.text = user.desc;
    
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
      appBar: AppBar(
        title: new Text('发布活动'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          _body(context),
        ],
      )
    ),
  );
}

  Widget _body(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            color: Colors.grey[300],
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
              child: Text('活动信息'),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: zhuti,
              onChanged:(value){
                updateName();  // 更新userName
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "活动主题",
              ),
            ),
          ),
          Divider(color: Colors.grey),
          new ListTile(
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
            title: Text("${_dateTime.month}月"+"${_dateTime.day}日${_dateTime.hour}时"),
          ),
          new Container(
            color: Colors.grey[300],
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
              child: Text('活动情况'),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 15.0),
            child: TextField(
              controller: renshu,
              onChanged:(value){
                
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "活动人数",
              ),
            ),
          ),
          Divider(color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
            child: Text('活动详情', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0,),)
          ),
          new Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(color: Color(0xffdedede))
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 8.0, 10.0),
              child: TextField(
                style: TextStyle(fontSize: 15, color: Colors.black),
                maxLines: 10,
                maxLength: 100,
                maxLengthEnforced: true,
                controller: xiangqin,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入100字以内的意见反馈",
                ),
                textInputAction: TextInputAction.unspecified,
                onChanged: (result) {
                  updateDescription();
                },
              ),
            )
          ),
          _getAddBtn(context),
        ],
      ),
    );
  }

  ///按键发起活动
  _getAddBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 3.0,
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        padding: EdgeInsets.symmetric(vertical: 10.0),
        onPressed: () {
          setState(() {
            _save();
          });
        },
        child: Text("发起活动", style: TextStyle(color: Colors.white),),
      ),
    );
  }

  void updateName() {
    user.name = zhuti.text;
  }

  void updateDescription() {
    user.desc = xiangqin.text;
  }
  void _save() async {
    int result;
    if(user.id == null) {
      user.id = new DateTime.now().millisecondsSinceEpoch;  //id 为当前时间戳
      result = await provider.insertUser(user);
    }else {
      result = await provider.update(user);
    }

    moveToLastScreen();

    int t = user.id;
    String n = user.name;
    String d = user.desc;
    debugPrint("t:$t n:$n d:$d");
    debugPrint("result: $result");
    if (result != 0) {
      _showAlertDialog("保存成功");
    } else {
      _showAlertDialog("保存失败");
    }
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      //title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
