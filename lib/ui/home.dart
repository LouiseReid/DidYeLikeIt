import 'package:did_ye_like_it/ui/takeaways_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DidYeLikeIt?'),
        backgroundColor: Colors.blueGrey[500],
      ),
      body: TakeAwaysList(),
    );
  }
}
