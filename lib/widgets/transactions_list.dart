import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> _usrTransactions;
  final Function _deleteTrans;
  TransactionList(this._usrTransactions, this._deleteTrans);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _usrTransactions.isEmpty
          ? Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              ),
          )
          : Container(
              // decoration: BoxDecoration(border: Border.all(width: 4, color: Colors.red)),
              height: 400,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: ListView.builder(
                itemBuilder: (contxt, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                    elevation: 10,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 33,
                        child: FittedBox(
                          child: Text('\$${_usrTransactions[index].amount}'),
                        ),
                      ),
                      title: Text(
                        _usrTransactions[index].title,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat.yMMMEd()
                            .format(_usrTransactions[index].time),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 30,
                        ),
                        onPressed: () =>
                            _deleteTrans(_usrTransactions[index].id),
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                itemCount: _usrTransactions.length,
              ),
            ),
    );
  }

  Future<Widget> listOfitems(BuildContext context, index) async {
    return GestureDetector(
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 3, color: Theme.of(context).primaryColorLight),
              ),
              padding: EdgeInsets.all(8),
              child: Text(
                '\$' + _usrTransactions[index].amount.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _usrTransactions[index].title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).primaryColorLight,
                      fontWeight: FontWeight.bold),
                ),
                Container(height: 5),
                Text(
                  DateFormat.yMMMMd().format(_usrTransactions[index].time),
                  style: TextStyle(
                      fontSize: 18, color: Theme.of(context).primaryColorLight),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        print('nothing');
      },
    );
  }
}
