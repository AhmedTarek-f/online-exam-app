import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/common_widgets/shimmer/shimmer_effect.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/cubits/home_cubit.dart';
import 'package:online_exam_app/utils/dimensions.dart';
import 'package:online_exam_app/utils/loaders/loaders.dart';

import '../widgets/custom_subject_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return BlocProvider<HomeCubit>(
      create: (context) => getIt.get<HomeCubit>()..getSubjects(),
      child: RPadding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
        ),
        child: ListView(
          children: [
            const RSizedBox(height: Dimensions.paddingSizeDefault),
            TextField(
              controller: _searchController,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: AppText.search,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radiusExtraLarge,
                  ),
                  borderSide: const BorderSide(width: 1, color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radiusExtraOverLarge,
                  ),
                  borderSide: BorderSide(
                    width: 1,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
            const RSizedBox(height: Dimensions.paddingSizeDefault),
            Text(
              AppText.browseBySubject,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const RSizedBox(height: Dimensions.paddingSizeDefault),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return ListView.separated(
                      separatorBuilder: (context, index) => const RSizedBox(
                            height: 30,
                          ),
                      itemCount: 6,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ShimmerEffect(
                          height: 60.h,
                          width: 100.w,
                          radius: 15.r,
                        );
                      });
                } else if (state is HomeSuccessState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.subjects.length,
                    itemBuilder: (context, index) {
                      final subject = state.subjects[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeSmall,
                        ),
                        child: CustomSubjectWidget(
                          image: subject.icon,
                          title: subject.name,
                        ),
                      );
                    },
                  );
                } else if (state is HomeErrorState) {
                  return Center(child: Text(state.errorMessage!));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
