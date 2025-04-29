
import 'package:imt_calculator/models/imt_calculation.dart';

abstract class ImtListState {}

class ImtListInitial extends ImtListState {}

class ImtListLoading extends ImtListState {}

class ImtListLoaded extends ImtListState {
  final List<ImtCalculation> imtCalculations;
  
  ImtListLoaded(this.imtCalculations);
}

class ImtListError extends ImtListState {
  final String errorMessage;
  
  ImtListError(this.errorMessage);
}