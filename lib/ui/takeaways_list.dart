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

  @override
  void initState() {
    super.initState();
    _getTakeAways();
    _ratingController.addListener(_validate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (_, int index) {
                  return Card(
                    color: Colors.white70,
                    child: ListTile(
                      title: _items[index],
                      trailing: Column(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Colors.redAccent[200]),
                              iconSize: 25.0,
                              onPressed: () {
                                _deleteItem(_items[index].id, index);
                              })
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Divider(height: 1.2)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add TakeAway',
          backgroundColor: Colors.blueGrey,
          child: ListTile(
            title: Icon(Icons.add),
          ),
          onPressed: _showFormDialog),
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

  _showFormDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.blueGrey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25.0),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _eateryController,
                  autofocus: true,
                  style: _textStyle(),
                  decoration: _inputDecoration('Eatery', "Toni's Pizziera"),
                ),
                TextField(
                    controller: _supplierController,
                    style: _textStyle(),
                    decoration: _inputDecoration('Supplier', 'Deliveroo')),
                TextField(
                    controller: _descriptionController,
                    style: _textStyle(),
                    decoration:
                        _inputDecoration('Description', 'cheese pizza')),
                TextField(
                    controller: _ratingController,
                    style: _textStyle(),
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration('Rating', null, '/5'))
              ],
            ),
            actions: <Widget>[
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                onPressed: () {
                  _handleSubmit(
                      _eateryController.text,
                      _supplierController.text,
                      _descriptionController.text,
                      int.parse(_ratingController.text));
                },
                child: Text('Save'),
              ),
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  _textStyle() {
    return TextStyle(
      color: Colors.white,
    );
  }

  _inputDecoration(String label, [String hint, String suffix]) {
    return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white,
          decorationColor: Colors.white,
        ),
        suffixText: suffix,
        hintText: hint != null ? 'eg $hint' : null,
        hintStyle: TextStyle(color: Colors.white, fontSize: 12.0),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }

  void _validate() {
    if (_ratingController.text.isNotEmpty &&
        int.parse(_ratingController.text) > 5) {
      _ratingController.text = 5.toString();
    }
  }

  void _handleSubmit(
      String eatery, String supplier, String description, int rating) async {
    Item item = new Item(eatery, supplier, description, rating);
    int savedItemId = await db.save(item);

    Item addedItem = await db.getById(savedItemId);

    setState(() {
      _items.add(addedItem);
    });

    Navigator.pop(context);
    _clearTextEditors();
  }

  void _deleteItem(int id, int index) {
    db.delete(id);
    setState(() {
      _items.removeAt(index);
    });
  }

  void _clearTextEditors() {
    _ratingController.clear();
    _descriptionController.clear();
    _supplierController.clear();
    _eateryController.clear();
  }
}
