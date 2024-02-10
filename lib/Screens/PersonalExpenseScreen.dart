import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/transaction_cubit.dart';
import '../models/transcation.dart';


class PersonalExpenseScreen extends StatefulWidget {
  final Map<String, double> monthlyBudgets;

  PersonalExpenseScreen({required this.monthlyBudgets});

  @override
  _PersonalExpenseScreenState createState() => _PersonalExpenseScreenState();
}

class _PersonalExpenseScreenState extends State<PersonalExpenseScreen> {
  late Map<String, double> _monthlyBudgets;
  List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    _monthlyBudgets = widget.monthlyBudgets;
  }

  @override
  Widget build(BuildContext context) {
    _transactions = context.watch<TransactionCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense Tracker'),
      ),
      body: ListView.builder(
        itemCount: _monthlyBudgets.length,
        itemBuilder: (BuildContext context, int index) {
          String category = _monthlyBudgets.keys.elementAt(index);
          double budgetAmount = _monthlyBudgets[category] ?? 0.0;

          double totalExpensesForCategory = _getTotalExpensesForCategory(category);

          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(category),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Monthly Budget: \$${budgetAmount.toStringAsFixed(2)}'),
                      Text('Total Expenditure: \$${totalExpensesForCategory.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showBudgetDialog(context, category, budgetAmount);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double _getTotalExpensesForCategory(String category) {
    double totalExpenses = 0.0;
    for (var transaction in _transactions) {
      if (transaction.category == category) {
        totalExpenses += transaction.amount;
      }
    }
    return totalExpenses;
  }

  void _showBudgetDialog(BuildContext context, String category, double currentBudget) {
    double newBudget = currentBudget;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Monthly Budget'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter Monthly Budget'),
            onChanged: (value) {
              newBudget = double.tryParse(value) ?? currentBudget;
            },
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FloatingActionButton(
              child: Text('Save'),
              onPressed: () {
                _setMonthlyBudget(category, newBudget);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _setMonthlyBudget(String category, double amount) {
    setState(() {
      _monthlyBudgets[category] = amount;
    });
  }
}
