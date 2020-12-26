import 'dart:math';

import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color bgColor;

  @override
  void initState() {
    const colors=[
      Colors.blue,
      Colors.black,
      Colors.red,
      Colors.purple
    ];
    bgColor= colors[Random().nextInt(4)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          foregroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                "₹ ${widget.transaction.amount.toStringAsFixed(2)}", /*style: TextStyle(fontWeight: FontWeight.bold),*/
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
          style: TextStyle(
            color: Colors.blueGrey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
          onPressed: () {
            widget.deleteTx(widget.transaction.id);
          },
          icon: Icon(Icons.delete),
          label: Text("Delete"),
          textColor: Theme.of(context).errorColor,
        )
            : IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () {
            widget.deleteTx(widget.transaction.id);
          },
        ),
      ),
    );
  }
}
