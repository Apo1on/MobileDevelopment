import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'final_imt_state.dart';
import '../../models/imt_calculation.dart';
import '../../services/database_helper.dart';

class FinalImtCubit extends Cubit<FinalImtState> {
  final double weight;
  final double height;

  FinalImtCubit({required this.weight, required this.height})
      : super(FinalImtInitial());

  Future<void> calculateImt() async {
    emit(FinalImtLoading());
    if (weight <= 0 || height <= 0) {
      emit(const FinalImtCalculationError());
      return;
    }
    
      final heightInMeters = height / 100;
      final rawImt = weight / pow(heightInMeters, 2);
      final imt = double.parse(rawImt.toStringAsFixed(2)); 
      final interpretation = explainIMT(imt);

      final calculation = ImtCalculation(
        weight: weight,
        height: height,
        imt: imt,
        interpretation: interpretation,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
      
      await DBIMT.db.newCalculation(calculation);
    emit(FinalImtCalculated(imt: imt, interpretation: interpretation));
    } 
}

  String explainIMT(double imt) {
    if (imt < 18.5) {
      return 'Недостаточный вес';
    } else if (imt < 25) {
      return 'Нормальный вес';
    } else if (imt < 30) {
      return 'Избыточный вес';
    } else {
      return 'Ожирение';
    }
  }
