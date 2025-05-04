import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/nasa_cubit.dart';
import 'detail_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Фотки с марсохода'),
      ),
      body: BlocBuilder<NasaCubit, NasaState>(
        builder: (context, state) {
          if (state is NasaLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NasaErrorState) {
            return Center(child: Text(state.message));
          } else if (state is NasaLoadedState) {
            return ListView.builder(
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                final photo = state.photos[index];
                return ListTile(
                  leading: Image.network(photo.imgSrc, width: 50, height: 50),
                  title: Text('Сол: ${photo.sol}'),
                  subtitle: Text(photo.camera.fullName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(photo: photo),
                      ),
                    );
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}