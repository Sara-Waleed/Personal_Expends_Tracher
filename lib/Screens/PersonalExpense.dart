import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expends_tracher/widgets/chart.dart';
import 'package:personal_expends_tracher/widgets/new_transaction.dart';
import 'package:personal_expends_tracher/widgets/transaction_list.dart';
import '../cubit/transaction_cubit.dart';
import '../models/transcation.dart';
import 'PersonalExpenseScreen.dart';





class PersonalExpense extends StatefulWidget {

  @override
  _PersonalExpenseState createState() => _PersonalExpenseState();
}

class _PersonalExpenseState extends State<PersonalExpense> {
  // Define _monthlyBudgets property here
  Map<String, double> _monthlyBudgets = {
    'Food': 500.0,
    'Transportation': 200.0,
    'Entertainment': 100.0,
    // Add more categories as needed
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, List<Transaction>>(
      builder: (context, transactions) {
        // Your existing widget tree using the transactions from the Cubit
        return Scaffold(
          appBar: AppBar(
            title: Text('Expense calculator'),
            actions: [
              IconButton(
                icon: Icon(Icons.summarize_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PersonalExpenseScreen(monthlyBudgets: _monthlyBudgets),
                    ),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Chart(transactions.where((tx) {
                  return tx.date.isAfter(
                    DateTime.now().subtract(
                      Duration(days: 7),
                    ),
                  );
                }).toList()),
                TransactionList(transactions, _deleteTransactions),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        );
      },
    );
  }

// Rest of your code...



  // This method gets called when FAB or + button in appbar is pressed
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransactions);
      },
    );
  }

  // Add

  //

  void _addNewTransactions(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
      category: 'Other', // Default category, you can change it or prompt the user to select a category
    );

    // Access TransactionCubit and call its addTransaction method
    context.read<TransactionCubit>().addTransaction(newTx);
  }

  void _deleteTransactions(String id) {
    // Access TransactionCubit and call its deleteTransaction method
    context.read<TransactionCubit>().deleteTransaction(id);
  }


}