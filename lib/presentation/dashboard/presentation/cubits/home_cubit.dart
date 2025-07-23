import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/entities/subjects/subjects_entity.dart';
import 'package:online_exam_app/domain/use_cases/subjects/subject_use_case.dart';
import 'package:online_exam_app/utils/exceptions/dio_exceptions.dart';
import 'package:online_exam_app/utils/exceptions/response_exception.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final SubjectUseCase subjectUseCase;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;
  @factoryMethod
  HomeCubit({required this.subjectUseCase}) : super(HomeInitial());

  void changeTab(int index) {
    _currentIndex = index;
    emit(HomeTabChanged(index));
  }

  Future<void> getSubjects() async {
    emit(HomeLoadingState());
    try {
      final subjects = await subjectUseCase.invoke();
      emit(HomeSuccessState(subjects));
    } catch (error) {
      if (error is DioExceptions) {
        emit(HomeErrorState(errorMessage: error.errorMessage));
      } else {
        emit(HomeErrorState(errorMessage: "An unexpected error occurred"));
      }
    }
  }
}
