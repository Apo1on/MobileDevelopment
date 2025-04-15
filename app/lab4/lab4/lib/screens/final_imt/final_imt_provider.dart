import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'final_imt_cubit.dart';
import 'final_imt_screen.dart';

class FinalImtProvider extends StatelessWidget {
  final double weight;
  final double height;

  const FinalImtProvider({Key? key, required this.weight, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FinalImtCubit(weight: weight, height: height)..calculateImt(),
      child: const FinalImtScreen(),
    );
  }
}