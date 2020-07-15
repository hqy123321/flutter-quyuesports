class User {
  User();

  int _id;
  String _name;
  String _desc;
 // String _xiangqing;

  int get id => _id;

  String get name => _name;

  String get desc => _desc;
  
 // String get xiangqing => _xiangqing;

  set desc(String value) {
    _desc = value;
  }

  set name(String value) {
    _name = value;
  }

  set id(int value) {
    _id = value;
  }
  // set xiangqing(String value) {
  //   _xiangqing = value;
  // }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['id'] = _id;
    map['name'] = _name;
    map['desc'] = _desc;
   // map['xiangqing'] = _xiangqing;

    return map;
  }

  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._desc = map['desc'];
   // this._xiangqing = map['xiangqing'];
  }
}
