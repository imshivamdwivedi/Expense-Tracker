import './widgets/transaction_list.dart';

import './widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.black,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline1: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ))),
      ),
      title: "Personal Expenses",
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  // This widget is the root of your application.

  // late String title;
  // late String amount;

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final List<Transcation> _userTransactions = [
    Transcation(
        id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transcation(
        id: 't2', title: 'Groceries', amount: 19.99, date: DateTime.now()),
  ];

  void _addTrasnaction(String txTitle, double txAmount) {
    final tx = Transcation(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    print(tx);
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //showmodalBottomSheet function provided by flutter
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
              _addTrasnaction), //we will return widget(you wanna show inside showmodal window sheet) here
          behavior: HitTestBehavior.opaque,
        );
      },
    ); //builder function itself provide context nd we will naem it bCtx
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Personal Expenses",
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Theme.of(context).accentColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                child: Text("Chart !"),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
