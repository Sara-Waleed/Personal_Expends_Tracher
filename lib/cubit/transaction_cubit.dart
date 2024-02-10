import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expends_tracher/models/transcation.dart';

class TransactionCubit extends Cubit<List<Transaction>> {
  TransactionCubit() : super([]);

  void addTransaction(Transaction transaction) {
    emit([...state, transaction]);
  }

  void deleteTransaction(String id) {
    emit(state.where((tx) => tx.id != id).toList());
  }
}
