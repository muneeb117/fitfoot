import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';
import '../bloc/app_states.dart';
import '../widgets/application_widget.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBlocs, AppStates>(builder: (context, state) {
      return Scaffold(
        body: buildPage(state.index),
        bottomNavigationBar: Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13.h),
              topRight: Radius.circular(13.h),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.nav.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 20.r,
                offset: Offset(0, -5.r),
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              canvasColor: AppColors.nav,
            ),
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: AppColors.unselected,
              selectedItemColor: AppColors.surface,
              unselectedFontSize: 10.0.sp,
              currentIndex: state.index,
              backgroundColor: Colors.transparent,
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10.0.sp,
              ),
              onTap: (value) {
                context.read<AppBlocs>().add(AppTriggeredEvents(value));
              },
              items: bottomTabs,
            ),
          ),
        ),
      );
    });
  }
}
