import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transactions_list.dart';
import './widgets/new_transactions.dart';
import './models/transactions.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
      title: 'DTH(Daily_Transaction_History)',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transactions> _usrTransactions = [];

  List<Transactions> get _recenttTransaction {
    return _usrTransactions.where((tx) {
      return tx.time.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime dateTime) {
    final newtx = Transactions(
      title: txTitle,
      amount: txAmount,
      time: dateTime,
      id: DateTime.now().toString(),
    );
    setState(() {
      _usrTransactions.add(newtx);
    });
  }

  void _deleteTrasaction(String id) {
    setState(() {
      _usrTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DTH(Daily_Transaction_History)"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(
                Icons.add_circle,
                size: 35,
              ),
              onPressed: () => _settingModalBottomSheet(context),
            ),
          )
        ],
        elevation: 20,
      ),
      body: Column(
        children: <Widget>[
          Chart(_recenttTransaction),
          TransactionList(_usrTransactions, _deleteTrasaction),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _settingModalBottomSheet(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransactios(_addTransaction);
      },
    );
  }
}
