import 'dart:math';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class TransactionItem extends StatefulWidget {
  TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  Transcation transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.black,
      Colors.purple
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
                child: Text(
              '\$ ${widget.transaction.amount}',
            )),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMEd().format(widget.transaction.date)),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  "Delete",
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              )
            : IconButton(
                onPressed: () => widget.deleteTx(widget.transaction.id),
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
      ),
    );
  }
}
