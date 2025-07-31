part of 'home_cubit.dart';

abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeTabChanged extends HomeState {
  final int index;

  HomeTabChanged(this.index);
}

final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String? errorMessage;

  HomeErrorState({required this.errorMessage});
}

final class HomeSuccessState extends HomeState {
  final List<SubjectsEntity> subjects;

  HomeSuccessState(this.subjects);
}
