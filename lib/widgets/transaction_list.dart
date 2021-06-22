import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import "./TransactionItem.dart";

class TransactionList extends StatelessWidget {
  final List<Transcation> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "No Transaction added yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),

                //works as sperators
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/image/waiting.png',
                        fit: BoxFit.cover)),
              ],
            );
          })
        : ListView(
            children: transactions
                .map((tx) => TransactionItem(
                      deleteTx: deleteTx,
                      transaction: tx,
                      key: ValueKey(tx.id),
                    ))
                .toList(),
          );
  }
}
