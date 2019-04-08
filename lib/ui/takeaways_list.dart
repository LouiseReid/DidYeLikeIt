import 'package:did_ye_like_it/models/item.dart';
import 'package:did_ye_like_it/utils/db_helper.dart';
import 'package:flutter/material.dart';

class TakeAwaysList extends StatefulWidget {
  @override
  _TakeAwaysListState createState() => _TakeAwaysListState();
}

class _TakeAwaysListState extends State<TakeAwaysList> {
  var db = new DBHelper();
  final List<Item> _items = <Item>[];
  final TextEditingController _eateryController = new TextEditingController();
  final TextEditingController _supplierController = new TextEditingController();
  final TextEditingController _descriptionController =
  new TextEditingController();
  final TextEditingController _ratingController = new TextEditingController();
  final TextEditingController _buyAgainController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _getTakeAways();
  }

  void _handleSubmit(String eatery, String supplier, String description,
      int rating, String buyAgain) async {
    Item item = new Item(eatery, supplier, description, rating,
        DateTime.now().toIso8601String(), buyAgain);
    int savedItemId = await db.save(item);

    Item addedItem = await db.getById(savedItemId);

    setState(() {
      _items.insert(0, addedItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(),
    );
  }

  _getTakeAways() async {
    List items = await db.getAll();
    items.forEach((item) {
      setState(() {
        _items.add(Item.fromMap(item));
      });
    });
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Column(
        children: <Widget>[
          TextField(
            controller: _eateryController,
            autofocus: true,
            decoration:
            InputDecoration(labelText: 'Eatery', hintText: 'eg Pizza Hut'),
          ),
          TextField(
            controller: _supplierController,
            decoration: InputDecoration(
                labelText: 'Supplier', hintText: 'eg Deliveroo'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
                labelText: 'Description', hintText: 'eg cheese pizza'),
          ),
          TextField(
            controller: _ratingController,
            decoration: InputDecoration(labelText: 'Rating', hintText: 'eg 5'),
          ),
          TextField(
            controller: _buyAgainController,
            decoration:
            InputDecoration(labelText: 'Buy Again?', hintText: 'eg yes'),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleSubmit(
                _eateryController.text,
                _supplierController.text,
                _descriptionController.text,
                int.parse(_ratingController.text),
                _buyAgainController.text);
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        )
      ],
    );
    showDialog(context: context,
        builder: (_) {
          return alert;
        }
    );
  }
}
