import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'final_imt_state.dart';

class FinalImtCubit extends Cubit<FinalImtState> {
  final double weight;
  final double height;

  FinalImtCubit({required this.weight, required this.height}) : super(FinalImtInitial());

  Future<void> calculateImt() async {
    emit(FinalImtCalculating());

    try {
      double heightInMeters = height / 100;
      final imt = weight / (pow(heightInMeters, 2));
      final interpretation = explainIMT(imt);

      emit(FinalImtCalculated(imt: imt, interpretation: interpretation));
    } catch (e) {
      emit(FinalImtError(errorMessage: 'Ошибка при расчете ИМТ: ${e.toString()}'));
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
}