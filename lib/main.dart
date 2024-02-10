import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screens/PersonalExpense.dart';
import 'cubit/transaction_cubit.dart';





void main() => runApp(
  BlocProvider(
    create: (context) => TransactionCubit(),
    child: MyApp(),
  ),
);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense calculator',
      debugShowCheckedModeBanner: false,
      home: PersonalExpense(),
      // Adding theme globally includes (fonts and colors)
      theme: ThemeData(
        primarySwatch: Colors.pink,
        hintColor: Colors.pinkAccent,
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(
          subtitle1: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        // Theme applicable for Appbar (setting different font style for Appbar title)
        // appBarTheme: AppBarTheme(
        //   textTheme: ThemeData.light().textTheme.copyWith(
        //     subtitle1: TextStyle(
        //       fontFamily: 'OpenSans',
        //       fontSize: 20,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),

      ),
    );
  }
}
