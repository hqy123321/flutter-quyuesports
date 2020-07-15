
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VenuesList extends StatelessWidget {
  List list ;
  VenuesList({this.list});
  bool isExpand = true ;
  @override
  Widget build(BuildContext context) {
    print(list.first);
    return Scaffold(
      appBar: AppBar(
        title: Text('场馆列表'),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.separated(
          itemCount: list.length,
          separatorBuilder: (context, index) {
            return Divider(color: Colors.grey,);
          },
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Venues(list: list, index: index,)
                  )
                );
              },
              child: ListTile(
                title: Text(list[index]['title']),
                subtitle: Text(list[index]['address']),
                trailing: Text(list[index]['score'], style: TextStyle(color: Colors.orangeAccent),)
              ),
            );
          },
        ),
      )
    );
  }
}

class Venues extends StatelessWidget {
  DateTime dateTime = new DateTime.now();
  
  List list;
  int index;
  Venues({this.list, this.index});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(list[index]['title']), 
        centerTitle: true,
      ),
      body: ListView(
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset('images/venuss.jpg',height: 90.0,width: 140.0, fit: BoxFit.cover,),
                  new Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(list[index]['title'], style:TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text('发票', style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),),
                            )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(color: Colors.grey,),
            new Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: new Text('温馨提示: 因疫情防控需要,入场请佩戴口罩,并配合场馆测量体温,登记身份等工作.'),
            ),
            Divider(color: Colors.grey,),
            new ListTile(
              leading: Icon(Icons.pin_drop),
              title: Text('厦门市'+list[index]['address']+list[index]['title']),
              trailing: new GestureDetector(
                onTap: () {
                },
                child: GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "拨打电话");
                  },
                  child: Icon(Icons.phone),
                )
              )
            ),
            Divider(color: Colors.grey,),
            new Container(
              height: 115,
              padding: EdgeInsets.symmetric(vertical: 15.0),
              color: Colors.grey[200],
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Colors.white,
                    margin: EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Text("${dateTime.month}月${dateTime.day+index}号"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: new Text("8时-23时"),
                        ),
                        new GestureDetector(
                          onTap: () {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('预约成功'),)
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text('预定', style: TextStyle(color: Colors.blueAccent, fontSize: 10.0),),
                            )
                          ),
                        )
                      ],
                    ),
                  );
                },
              )
            ),
            _bottomList()
          ],
        ),
    );
  }

  Widget _bottomList() {
    return Container(
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text("场地设施", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
          new Container(
            padding: EdgeInsets.only(left: 30.0, top: 10.0),
            child: Column(
              children: <Widget>[
                new Text('地板材质:  ${list[index]['floor']}'),
                new Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: new Text('休息区域:  风扇,空调'),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey,),
          new Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: new Text('场馆服务', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
          ),
          new Container(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text('更多服务:  ${list[index]['service']}'),
                new Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: new Text('场馆买品:  饮料'),
                ),
                new Text('地下停车:  两小时5元')
              ],
            ),
          ),
        ],
      ),
    );
  }
}