import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importing the intl package
import 'package:personal_expends_tracher/models/transcation.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(String) deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
        children: <Widget>[
          Text(
            "No transactions added yet",
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            child: Image.asset("assets/images/no_transaction.gif"),
          ),
        ],
      )
          : ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child:
                    Text('\$${transactions[index].amount.toString()}'),
                  ),
                ),
              ),
              title: Text(
                transactions[index].title!,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    deleteTransaction(transactions[index].id!),
              ),
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
