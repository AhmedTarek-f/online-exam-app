import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/common_widgets/custom_elevated_button.dart';
import 'package:online_exam_app/core/constants/app_images.dart';
import 'package:online_exam_app/core/constants/app_text.dart';
import 'package:online_exam_app/core/router/route_names.dart';
import 'package:online_exam_app/presentation/splash/presentation/views_model/splash_cubit.dart';
import 'package:online_exam_app/presentation/splash/presentation/views_model/splash_intent.dart';
import 'package:online_exam_app/presentation/splash/presentation/views_model/splash_state.dart';
import 'package:online_exam_app/utils/loaders/loaders.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<SplashCubit>(context);
    return BlocListener<SplashCubit, SplashState>(
      listener: (BuildContext context, SplashState state) {
        if (state is FetchUserDataFailureState) {
          Loaders.showErrorMessage(
            message: state.errorData.message,
            context: context,
          );
        } else if (state is FetchUserDataSuccessState) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RouteNames.dashboard, (route) => false);
        } else if (state is NavigationState) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RouteNames.login, (route) => false);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(AppImages.appImage, height: 200.r, width: 200.r),
          ),
          const RSizedBox(height: 52),
          BlocBuilder<SplashCubit, SplashState>(
            buildWhen: (previous, current) =>
                current is FetchUserDataLoadingState ||
                current is FetchUserDataFailureState,
            builder: (context, state) {
              if (state is FetchUserDataLoadingState) {
                return Center(
                  child: SizedBox(
                    width: 30.r,
                    height: 30.r,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              } else if (state is FetchUserDataFailureState) {
                return RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      CustomElevatedButton(
                        onPressed: () async {
                          await controller.doIntent(
                            intent: GetUserDataIntent(),
                          );
                        },
                        buttonTitle: AppText.tryAgain,
                      ),
                      const RSizedBox(height: 16),
                      CustomElevatedButton(
                        onPressed: () {
                          controller.doIntent(
                            intent: NavigateToLoginViewIntent(),
                          );
                        },
                        buttonTitle: AppText.reLogin,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(
                    width: 30.r,
                    height: 30.r,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
