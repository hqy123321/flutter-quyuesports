import 'package:flutter/material.dart';
import 'package:sportsvenues/database/user.dart';
import 'package:sportsvenues/database/user_table_provider.dart';


class NbaPage extends StatefulWidget {
  String userName;
  NbaPage({Key key, this.userName}) : super(key: key);
  @override
  _NbaPageState createState() => _NbaPageState();
}

class _NbaPageState extends State<NbaPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

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
        title: Text('活动'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: updateListView,
        child: getListView(),
      )
    );
  }

  Widget getListView() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext conext, int index) {
          return Card(
            
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        new Text('20:00', style: TextStyle(color: Colors.red),),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(this.userList[index].name),
                        )
                      ],
                    ),
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('介绍:   ${this.userList[index].desc}')
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text('组织者:   ${widget.userName}')
                  ),
                  new Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('初级水平', style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),),
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text('中级水平', style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),),
                          )
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Icon(Icons.people, color: Colors.grey,),
                        new Container(
                          child: Row(
                            children: <Widget>[
                              new Text('0/18人'),
                              new Text('  待确定', style: TextStyle(color: Colors.blueAccent),)
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          );
        },
      ),
    );
  }

  Future<Null> updateListView() async{
    await new Future.delayed(new Duration(seconds: 2));
    Future<List<User>> listUsersFuture = provider.getAllUser();
    listUsersFuture.then((userList) {
      setState(() {
        this.userList = userList;
        this.count = userList.length;
      });
    });
    return null;
  }
}