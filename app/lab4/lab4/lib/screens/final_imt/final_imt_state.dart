import 'package:equatable/equatable.dart';

abstract class FinalImtState extends Equatable {
  const FinalImtState();

  @override
  List<Object> get props => [];
}

class FinalImtLoading extends FinalImtState {}


class FinalImtCalculationError extends FinalImtError {
  const FinalImtCalculationError() : super(errorMessage: 'Ошибка расчета ИМТ');
}

class FinalImtDatabaseError extends FinalImtError {
  const FinalImtDatabaseError() : super(errorMessage: 'Ошибка сохранения данных');
}

class FinalImtInitial extends FinalImtState {}

class FinalImtCalculating extends FinalImtState {}

class FinalImtCalculated extends FinalImtState {
  final double imt;
  final String interpretation;

  const FinalImtCalculated({required this.imt, required this.interpretation});

  @override
  List<Object> get props => [imt, interpretation];
}

class FinalImtError extends FinalImtState {
  final String errorMessage;

  const FinalImtError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}