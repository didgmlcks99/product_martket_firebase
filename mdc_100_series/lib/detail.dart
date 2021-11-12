import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget{
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.edit,
              semanticLabel: 'edit',
            ),
            onPressed: () {
              print('Edit button');
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              semanticLabel: 'delete',
            ),
            onPressed: () {
              print('Delete button');
            },
          ),
        ],
      ),
    );
  }

}