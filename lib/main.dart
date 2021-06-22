import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  //code to fix scrren rotation of screen
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
        errorColor: Colors.red,
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
    // Transcation(
    //     id: 't1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    // Transcation(
    //     id: 't2', title: 'Groceries', amount: 19.99, date: DateTime.now()),
  ];

  bool _showChart = false;
  List<Transcation> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addTrasnaction(String txTitle, double txAmount, DateTime Date) {
    final tx = Transcation(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: Date);

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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget texList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("show chart"),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.65,
              child: Chart(_recentTransaction))
          : texList
    ];
  }

  List<Widget> _buildPortaitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget texList) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.35,
          child: Chart(_recentTransaction)),
      texList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "Personal Expenses",
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
            ))
      ],
    );
    final texList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final pageBody = SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            ..._buildLandscapeContent(mediaQuery, appBar, texList),
          if (!isLandscape) ..._buildPortaitContent(mediaQuery, appBar, texList)
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
