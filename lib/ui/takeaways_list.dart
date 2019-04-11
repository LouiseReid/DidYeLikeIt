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
  int _ratingController;

  @override
  void initState() {
    super.initState();
    _getTakeAways();
  }

  void _handleSubmit(
      String eatery, String supplier, String description, int rating) async {
    Item item = new Item(eatery, supplier, description, rating);
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
                            icon: Icon(Icons.remove_circle_outline, color: Colors.redAccent[200]),
                            iconSize: 25.0,
                            onPressed: () {
                              _deleteItem(_items[index].id, index);
                            }
                          )
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

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleSubmit(_eateryController.text, _supplierController.text,
                _descriptionController.text, _ratingController);
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

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _deleteItem(int id, int index) {
    db.delete(id);
    setState(() {
      _items.removeAt(index);
    });
  }
}
