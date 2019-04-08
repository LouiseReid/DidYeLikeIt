import 'package:flutter/material.dart';

class Item extends StatelessWidget {

  String _eatery;
  String _supplier;
  int _rating;
  String _date;
  bool _buyAgain;
  int _id;

  Item(this._eatery, this._supplier, this._rating, this._date, this._buyAgain);

  String get eatery => _eatery;
  String get supplier => _supplier;
  int get rating => _rating;
  String get date => _date;
  bool get buyAgain => _buyAgain;
  int get id => _id;

  Item.fromMap(dynamic obj){
    this._eatery = obj['eatery'];
    this._supplier = obj['supplier'];
    this._rating = obj['rating'];
    this._date = obj['date'];
    this._buyAgain = obj['buyAgain'];
    this._id = obj['id'];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['eatery'] = _eatery;
    map['supplier'] = _supplier;
    map['rating'] = _rating;
    map['date'] = _date;
    map['buyAgain'] = _buyAgain;
    if(_id != null) map['id'] = _id;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }


}
