import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/screens/profile_screen.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/widgets/custom_nav_bar_widget.dart';
import '../../../../core/router/route_names.dart';

import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/presentation/dashboard/domain/controllers/home_controller.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/cubits/home_cubit.dart';
import 'package:online_exam_app/presentation/profile/views/profile_view.dart';
import 'home_screen.dart';
import '../cubits/nav_bar_cuibts/nav_bar_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    Center(child: Text("Results")),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        return Scaffold(

          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {

              Navigator.pushNamed(context,RouteNames.questionView);
            },

          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              _getTitle(currentIndex),
              style: Theme.of(context).textTheme.titleLarge,
            ),

          ),
          backgroundColor: Colors.white,
          body: _screens[state.selectedIndex],
          bottomNavigationBar: SizedBox(
            height: 80.h,
            child: CustomBottomNavBar(
              currentIndex: state.selectedIndex,
              onTap: (index) => context.read<NavBarCubit>().changeTab(index),
            ),
          ),
        );
      },
    );
  }

  Widget _getTab(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const Center(child: Text('Results'));
      case 2:
        return const ProfileView();
      default:
        return const SizedBox.shrink();
    }
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Results';
      case 2:
        return 'Profile';
      default:
        return '';
    }
  }
}
