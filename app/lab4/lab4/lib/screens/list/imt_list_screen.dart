import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_calculator/screens/list/cubits/imt_list_cubit.dart';
import 'package:imt_calculator/screens/list/cubits/imt_list_state.dart';
import 'package:imt_calculator/services/database_helper.dart';
import 'package:intl/intl.dart';

class ImtListScreen extends StatelessWidget {
  const ImtListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImtListCubit(databaseHelper: DBIMT.db)..loadImtCalculations(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('История расчетов ИМТ'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<ImtListCubit>().loadImtCalculations(),
            ),
          ],
        ),
        body: BlocConsumer<ImtListCubit, ImtListState>(
          listener: (context, state) {
            if (state is ImtListError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            if (state is ImtListLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ImtListLoaded) {
              final calculations = state.imtCalculations;
              
              if (calculations.isEmpty) {
                return const Center(child: Text('Нет сохраненных расчетов'));
              }

              return ListView.separated(
                itemCount: calculations.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final calculation = calculations[index];
                  final dateTime = DateTime.fromMillisecondsSinceEpoch(calculation.timestamp);
                  
                  return Dismissible(
                    key: Key(calculation.id?.toString() ?? index.toString()),
                    background: Container(color: Colors.red),
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Удалить запись?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Отмена'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Удалить'),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (direction) {
                      context.read<ImtListCubit>().deleteCalculation(calculation.id!);
                    },
                    child: ListTile(
                      title: Text('ИМТ: ${calculation.imt.toStringAsFixed(2)}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Вес: ${calculation.weight} кг, Рост: ${calculation.height} см'),
                          Text('Категория: ${calculation.interpretation}'),
                          Text('Дата: ${DateFormat('yyyy-MM-dd HH:mm').format(dateTime)}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<ImtListCubit>().deleteCalculation(calculation.id!);
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Нет данных'));
          },
        ),
      ),
    );
  }
}