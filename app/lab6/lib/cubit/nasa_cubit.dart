import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/photo.dart';
import '../requests/api.dart';

abstract class NasaState extends Equatable {
  const NasaState();

  @override
  List<Object> get props => [];
}

class NasaLoadingState extends NasaState {}

class NasaLoadedState extends NasaState {
  final List<Photo> photos;

  const NasaLoadedState(this.photos);

  @override
  List<Object> get props => [photos];
}

class NasaErrorState extends NasaState {
  final String message;

  const NasaErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NasaCubit extends Cubit<NasaState> {
  NasaCubit() : super(NasaLoadingState());

  void loadPhotos(String roverName, int sol) async {
    emit(NasaLoadingState());
    try {
      final photos = await NasaApi.getPhotos(roverName, sol);
      emit(NasaLoadedState(photos));
    } catch (e) {
      emit(NasaErrorState(e.toString()));
    }
  }
}