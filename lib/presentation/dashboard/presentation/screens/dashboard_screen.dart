import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/screens/profile_screen.dart';
import 'package:online_exam_app/presentation/dashboard/presentation/widgets/custom_nav_bar_widget.dart';
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
}
