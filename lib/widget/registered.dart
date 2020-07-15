import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Registered extends StatefulWidget {
  @override
  _RegisteredState createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();

  String _name ;
  String _password;
  String passWord;
  String name;
  
  void _userRegister() {
    _name = _controllerName.text;
    _password = _controllerPwd.text;
    if (_formKey.currentState.validate()) {
      save();//使用sharedPreferences存储数据
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login()
        ),
        (route) => route == null
      );
    }
  }

  save() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(name, _name);
    prefs.setString(passWord,_password);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //点击空白收起键盘
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('注册'),
          ),
          body: _body(),
        ),
      ),
    );
  }
  Widget _body() {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                _phone(),
                SizedBox(height: 20.0,),
                _passWord(),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  height: 44,
                  width: MediaQuery.of(context).size.width - 110,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5)),
                  child: FlatButton(
                    child: Text(
                      '注册',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      _userRegister();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _phone() {
    return TextFormField(
      autofocus: false,
      controller: _controllerName,
      decoration: InputDecoration(
        hintText: '请输入用户名',
      ),
      validator: (value) {
        if (_controllerName.text.length == 0 ){
          return '用户名不能为空';
        }
        return null ;
      },
    );
  }

  Widget _passWord() {
    return TextFormField(
      obscureText: true,
      autofocus: false,
      controller: _controllerPwd,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: '请输入密码',

      ),
      validator: (value) {
        if (_controllerPwd.text.length == 0 || _controllerPwd.text.length < 6){
          return '密码不能为空并且长度不能小于6';
        }
        return null ;
      },
    );
  }
}