import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class NewTransaction extends StatefulWidget {
  final addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime selectedDate;

  void submitTransaction() {
    if (amountController.text == null) {
      return;
    }
    String title = titleController.text;
    double amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTransaction(title, amount, selectedDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedData) {
      if (pickedData == null) {
        return;
      }
      setState(() {
        selectedDate = pickedData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: "Title"),
                  controller: titleController,
                  /*onChanged: (val) {
                            title = val;
                          },*/
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Amount"),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) {
                    submitTransaction();
                  },
                  /*onChanged: (val) {
                          },*/
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          selectedDate == null
                              ? "No Date Chosen!"
                              : "Picked Date: ${DateFormat.yMMMd().format(selectedDate)}",
                          style: TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: presentDatePicker,
                      )
                    ],
                  ),
                ),
                RaisedButton(
                  child: Text("Add Transaction"),
                  color: Theme.of(context).primaryColor,
                  onPressed: submitTransaction,
                  textColor: Theme.of(context).textTheme.button.color,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
