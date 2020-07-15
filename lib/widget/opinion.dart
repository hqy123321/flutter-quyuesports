import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';




class Opinion extends StatefulWidget {
  @override
  _OpinionState createState() => _OpinionState();
}

class _OpinionState extends State<Opinion> {
  TextEditingController _input = new TextEditingController();
  String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('意见反馈'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if(_input.text == null || _input.text== "") {
                Fluttertoast.showToast(msg: "请输入内容");
              }else {
                Fluttertoast.showToast(msg: "提交成功");
              }
            },
            child: Text('提交', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
      body: _body(),
    );
  }
  Widget _body() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
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
                maxLength: 150,
                maxLengthEnforced: true,
                controller: _input,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "请输入150字以内的意见反馈",
                ),
                textInputAction: TextInputAction.unspecified,
                onChanged: (str) {
                  result = str ;
                },
              ),
            )
          ),

        ],
      ),
    );
  }
}