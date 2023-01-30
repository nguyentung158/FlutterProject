import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/modals/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  Function deleteTx;
  TransactionList({required this.transactions, required this.deleteTx});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !widget.transactions.isEmpty
          ? ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  elevation: 6,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: FittedBox(
                          child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text('\$${widget.transactions[index].amount}'),
                      )),
                    ),
                    title: Text(
                      '${widget.transactions[index].title}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(widget.transactions[index].date)),
                    trailing: InkWell(
                      child: Icon(
                        Icons.delete,
                        color: Theme.of(context).primaryColor,
                      ),
                      onTap: () {
                        widget.deleteTx(widget.transactions[index].id);
                      },
                    ),
                  ),
                );
              },
              itemCount: widget.transactions.length,
            )
          : LayoutBuilder(builder: (context, constraints) {
              return Container(
                  height: constraints.maxHeight,
                  child: Column(
                    children: [
                      const Text('No transactions added yet'),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: constraints.maxHeight * 0.6,
                          child: Image.asset(
                            'assets/images/waiting.png',
                            fit: BoxFit.cover,
                          ))
                    ],
                  ));
            }),
    );
  }
}
