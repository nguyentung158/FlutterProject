import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_personal_expense/modals/transaction.dart';
import 'package:flutter_personal_expense/widgets/chart.dart';
import 'package:flutter_personal_expense/widgets/new_transaction.dart';
import 'package:flutter_personal_expense/widgets/transaction_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Quicksand',
          primarySwatch: Colors.blue,
          textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: TextStyle(
                  fontFamily: 'OpenSans', fontWeight: FontWeight.bold))),
      home: MyHomePage(title: 'Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  bool _showChart = false;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        title: 'New shoes',
        amount: 50,
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        title: 'New jacket',
        amount: 100,
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        title: 'New shoes',
        amount: 50,
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        title: 'New jacket',
        amount: 100,
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        title: 'New shoes',
        amount: 50,
        date: DateTime.now(),
        id: DateTime.now().toString()),
    Transaction(
        title: 'New jacket',
        amount: 100,
        date: DateTime.now(),
        id: DateTime.now().toString()),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: selectedDate,
        id: selectedDate.toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startAddNewContext(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: ((sheetContext) {
          return GestureDetector(
            onTap: (() {}),
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addTx: _addTransaction),
          );
        }));
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    AppBar appBar = AppBar(
      title: const Text(
        'App',
        style: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewContext(context),
            icon: const Icon(Icons.add))
      ],
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: (() => _startAddNewContext(context)),
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart'),
                  Switch.adaptive(
                      value: widget._showChart,
                      onChanged: (value) {
                        setState(() {
                          widget._showChart = value;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              Container(
                child: Chart(recentTransactions: _recentTransactions),
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
              ),
            if (isLandscape)
              widget._showChart
                  ? Container(
                      child: Chart(recentTransactions: _recentTransactions),
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                    )
                  : Container(),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: TransactionList(
                transactions: _userTransactions,
                deleteTx: _deleteTransaction,
              ),
            )
          ],
        ),
      ),
    );
  }
}
