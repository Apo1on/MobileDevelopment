import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_calculator/screens/list/cubits/imt_list_state.dart';
import 'package:imt_calculator/services/database_helper.dart';


class ImtListCubit extends Cubit<ImtListState> {
  final DBIMT databaseHelper;

  ImtListCubit({required this.databaseHelper}) : super(ImtListInitial());

  Future<void> loadImtCalculations() async {
    emit(ImtListLoading());
    try {
      final calculations = await databaseHelper.getAllImtCalculations();
      emit(ImtListLoaded(calculations));
    } catch (e) {
      emit(ImtListError('Не удалось загрузить данные'));
    }
  }

  Future<void> deleteCalculation(int id) async {
    try {
      await databaseHelper.deleteImtCalculation(id);
      await loadImtCalculations();
    } catch (e) {
      emit(ImtListError('Не удалось удалить запись'));
    }
  }
}