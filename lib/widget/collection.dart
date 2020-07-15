import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../database/user_table_provider.dart';
import 'introduce.dart';

import '../database/user.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {

  UserDbProvider provider = UserDbProvider();
  List<User> userList;
  int count = 0;  //在为被初始化前item的数量为0

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if(userList == null) {
      userList = List<User>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('我的活动'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              navigateToDetail(User());
            },
            child: Text('发布活动', style: TextStyle(color: Colors.white),),
          )
        ],
      ),
     body: getListView(),
    );
  }
  
  Widget getListView() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            elevation: 3.0,
            child: ListTile(
              title: Text(this.userList[index].name),
              subtitle: Text(this.userList[index].desc),
              trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.red,),
                onTap: () {
                  _delete(context, userList[index]);
                },
              ),
              onTap: () {
                navigateToDetail(userList[index]);
              },
            ),
          );
        }
      ),
    );
  }


  //跳转到编辑添加数据页面
  void navigateToDetail(User user) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) {
      return Introduce(user);
    }));
    debugPrint("result:"+result.toString());
    if(result ==true){
      updateListView();
    }
  }

  //删除某条数据
  void _delete(BuildContext context, User user) async {
    var id = user.id;
    debugPrint("delete id :$id");
    int result = await provider.deleteUser(user.id);
    debugPrint("delete result :$result");
    if (result != 0) {
      updateListView(); //删除成功后更新列表
    }
  }

  void updateListView() {
    Future<List<User>> listUsersFuture = provider.getAllUser();
    listUsersFuture.then((userList) {
      setState(() {
        this.userList = userList;
        this.count = userList.length;
      });
    });
  }
}