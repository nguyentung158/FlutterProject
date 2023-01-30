import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  const NewTransaction({super.key, required this.addTx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  TextEditingController _tiltleController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate = null;

  void submitData() {
    String title = _tiltleController.text;

    double amount = _amountController.text.isEmpty
        ? -1
        : double.parse(_amountController.text);

    if (title.isEmpty || amount < 0 || _selectedDate == null) return;

    widget.addTx(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            initialDate: DateTime.now(),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _tiltleController,
                onSubmitted: (value) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: ((value) => submitData()),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked date: ${DateFormat.yMd().format(_selectedDate!)}',
                      style: TextStyle(fontFamily: 'OpenSans'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _presentDatePicker(context);
                    },
                    child: Text(
                      'Choose date',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: 'OpenSans'),
                    ),
                  )
                ],
              ),
              TextButton(
                  onPressed: submitData,
                  child: const Text(
                    'Add transaction',
                    style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans'),
                  ))
            ])),
      ),
    );
  }
}
