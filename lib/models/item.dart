import 'package:flutter/material.dart';
import 'package:did_ye_like_it/utils/fomat_helpers.dart';

class Item extends StatelessWidget {
  String _eatery;
  String _supplier;
  String _description;
  int _rating;
  int _id;

  Item(this._eatery, this._supplier, this._description, this._rating);

  String get eatery => _eatery;

  String get supplier => _supplier;

  String get description => description;

  int get rating => _rating;

  int get id => _id;

  Item.fromMap(dynamic obj) {
    this._eatery = obj['eatery'];
    this._supplier = obj['supplier'];
    this._description = obj['description'];
    this._rating = obj['rating'];
    this._id = obj['id'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['eatery'] = _eatery;
    map['supplier'] = _supplier;
    map['description'] = _description;
    map['rating'] = _rating;
    if (_id != null) map['id'] = _id;
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                capitalize(_eatery),
                style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.5),
              ),
              Text(
                capitalize(_supplier),
                style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.5),
              )
            ],
          ),
        ),
        Text(
          capitalize(_description),
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
              children: _starsForRatings()),
        ),
      ],
    ));
  }

  List<Icon> _starsForRatings() {
    List<Icon> stars = [];
    for (int i = 0; i < _rating; i++) {
      stars.add(Icon(Icons.star, color: Colors.amberAccent, size: 20.0));
    }
    return stars;
  }

}
