import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactios extends StatefulWidget {
  final Function addTrans;

  NewTransactios(this.addTrans);

  @override
  _NewTransactiosState createState() => _NewTransactiosState();
}

class _NewTransactiosState extends State<NewTransactios> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime _selectDate= DateTime.now();

  void _onSubmit() {
    if (amount.text.isEmpty) {
      return;
    }
    final enterdTitle = title.text;
    final enterdAmount = double.parse(amount.text);
    if (enterdTitle.isEmpty || enterdAmount <= 0 || _selectDate == null) {
      return;
    }
    widget.addTrans(
      enterdTitle,
      enterdAmount,
      _selectDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickdate) {
      if (pickdate == null) {
        return;
      }
      setState(() {
        _selectDate = pickdate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Product Name'),
                controller: title,
                keyboardType: TextInputType.text,
                onSubmitted: (val) => _onSubmit(),
              ),
              Container(height: 20),
              TextField(
                decoration: InputDecoration(labelText: 'Product Price'),
                controller: amount,
                keyboardType: TextInputType.number,
                onSubmitted: (val) => _onSubmit(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 30,
                child: Row(
                  children: <Widget>[
                    Text(
                      DateFormat.yMMMEd().format(_selectDate),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: FlatButton(
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: _datePicker,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: RaisedButton(
                  onPressed: _onSubmit,
                  child: Text('Add Transaction'),
                  color: Colors.green,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
