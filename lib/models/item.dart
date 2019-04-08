import 'package:flutter/material.dart';

class Item extends StatelessWidget {

  String _eatery;
  String _supplier;
  String _description;
  int _rating;
  String _date;
  String _buyAgain;
  int _id;

  Item(this._eatery, this._supplier, this._description, this._rating, this._date, this._buyAgain);

  String get eatery => _eatery;
  String get supplier => _supplier;
  String get description => description;
  int get rating => _rating;
  String get date => _date;
  String get buyAgain => _buyAgain;
  int get id => _id;


  Item.fromMap(dynamic obj){
    this._eatery = obj['eatery'];
    this._supplier = obj['supplier'];
    this._description = obj['description'];
    this._rating = obj['rating'];
    this._date = obj['date'];
    this._buyAgain = obj['buyAgain'];
    this._id = obj['id'];
  }

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['eatery'] = _eatery;
    map['supplier'] = _supplier;
    map['description'] = _description;
    map['rating'] = _rating;
    map['date'] = _date;
    map['buyAgain'] = _buyAgain;
    if(_id != null) map['id'] = _id;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(_eatery,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                    ),
                  ),
                  Text(_supplier,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0
                    ),
                  )
                ],
              ),
              Text(_description,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                ),
              ),
              Text(_date,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
                  fontStyle: FontStyle.italic
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(_rating.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0
                    ),
                  ),
                  Text(_buyAgain.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }


}
