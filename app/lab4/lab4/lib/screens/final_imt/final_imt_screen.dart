import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'final_imt_cubit.dart';
import 'final_imt_state.dart';

class FinalImtScreen extends StatelessWidget {
  const FinalImtScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
      ),
      body: BlocBuilder<FinalImtCubit, FinalImtState>(
        builder: (context, state) {
          if (state is FinalImtInitial) {
            return const Center(child: Text('Нажмите кнопку для расчета ИМТ'));
          } else if (state is FinalImtCalculating) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FinalImtCalculated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Ваш ИМТ: ${state.imt.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Интерпретация: ${state.interpretation}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Вернуться'),
                  ),
                ],
              ),
            );
          } else if (state is FinalImtError) {
            return Center(child: Text('Ошибка: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('Ты как вылез из состояний'));
          }
        },
      ),
    );
  }
}