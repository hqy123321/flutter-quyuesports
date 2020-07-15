import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportsvenues/widget/registered.dart';

import '../tabs.dart';

class Login extends StatefulWidget {
  String name;
  String passWord;
  Login({Key key, this.name, this.passWord}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _userName = new TextEditingController();
  TextEditingController _passWord = new TextEditingController();

  var userName;
  var passwords;
  
  _get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(widget.name);
    passwords = prefs.getString(widget.passWord);
    print(userName);
    print(passwords);
  }
  _delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userName);
    prefs.remove(passwords);
    prefs.clear();
  }
  
  @override
  void initState() {
    super.initState();
    _get();
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
            title: Text('登录'),
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
                _password(),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  height: 44,
                  width: MediaQuery.of(context).size.width - 110,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5)),
                  child: FlatButton(
                    child: Text(
                      '登录',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      print(userName);
                      print(passwords);
                      if (_formKey.currentState.validate()) {
                        Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => new Tabs(userName: userName,))
                        , (route) => route == null);
                      }
                    },
                  ),
                ),
                Container(
                  child: Center(
                    child: FlatButton(
                      child: Text('注册账号',style: TextStyle(color: Colors.blueAccent)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Registered()
                          )
                        );
                      },
                    ),
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
      controller: _userName,
      decoration: InputDecoration(
        hintText: '请输入用户名',
      ),
      validator: (value) {
        if (userName != _userName.text){
          return '用户名输入错误';
        }else{
          return null;
        }
      },
    );
  }

  Widget _password() {
    return TextFormField(
      obscureText: true,
      autofocus: false,
      controller: _passWord,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: '请输入密码',

      ),
      validator: (value) {
        if (passwords != _passWord.text){
          return '密码输入错误' ;
        } else {
          return null;
        }
      },
    );
  }
}


