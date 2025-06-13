import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/presentation/activities/attendance/bloc/attendance_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/plan_status_card.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const AttendanceScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AttendanceBloc(),
      child: const AttendanceView(),
    );
  }
}

class AttendanceView extends StatelessWidget {
  const AttendanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<AttendanceBloc>();

    return BlocBuilder<AttendanceBloc, AttendanceState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Attendance",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 110,
                  child: DropdownSearchB(
                    items: const [DropdownItem(name: 'Select', value: -1)],
                    selected: (index) {},
                  ),
                ),
                SizedBox(
                  width: 230,
                  child: TextFieldB(
                      suffixIcon: const Icon(
                        Icons.calendar_today,
                        size: 25,
                        color: bSkyBlue,
                      ),
                      hintText: "01 July 2022",
                      controller: state.dateController,
                      focusNode: state.dateFocusNode,
                      onChanged: (value) {}),
                ),
              ],
            ),
            const SizedBox(height: 18),
            const PlanStatusCard(),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }
}
