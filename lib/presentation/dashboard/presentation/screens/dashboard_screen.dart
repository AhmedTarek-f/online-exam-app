import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/di/di.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/screens/profile_screen.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/widgets/custom_nav_bar_widget.dart';
import 'package:online_exam_app/presentation/profile/views/profile_view.dart';
import '../../../../core/router/route_names.dart';
import 'home_screen.dart';
import '../cubits/nav_bar_cuibts/nav_bar_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    Center(child: Text("Results")),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Always create a fresh cubit when DashboardScreen is built
      create: (context) => NavBarCubit()..changeTab(0),
      child: Builder(
        builder: (context) {
          return BlocBuilder<NavBarCubit, NavBarState>(
            builder: (context, state) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.questionView);
                  },
                ),
                backgroundColor: Colors.white,
                body: _screens[state.selectedIndex],
                bottomNavigationBar: SizedBox(
                  height: 80.h,
                  child: CustomBottomNavBar(
                    currentIndex: state.selectedIndex,
                    onTap: (index) {
                      context.read<NavBarCubit>().changeTab(index);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
