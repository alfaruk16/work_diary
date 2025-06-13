import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/widgets/widgets.dart';
import 'package:work_diary/features/app/domain/entities/complete_visit_response.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/get_location_repo.dart';
import 'package:work_diary/features/app/presentation/activities/check_in_form/bloc/check_in_form_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';

class CheckInFormScreen extends StatelessWidget {
  const CheckInFormScreen({Key? key, required this.visitData})
      : super(key: key);
  final VisitData visitData;

  static Route<dynamic> route({required VisitData visitData}) =>
      MaterialPageRoute<dynamic>(
        builder: (_) => CheckInFormScreen(
          visitData: visitData,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckInFormBloc(getIt<IFlutterNavigator>(),
          getIt<ImagePicker>(), getIt<GetLocationRepo>(), getIt<ApiRepo>())
        ..add(GetId(visitData: visitData)),
      child: const CheckInFormView(),
    );
  }
}

class CheckInFormView extends StatelessWidget {
  const CheckInFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CheckInFormBloc>();

    return BlocBuilder<CheckInFormBloc, CheckInFormState>(
        builder: (context, state) {
      return CommonBodyB(
          appBarTitle: "Check In Form",
          menuList: [
            PopupMenuItem(
              value: PopUpMenu.createNewVisitPlan.name,
              child: const TextB(text: "Create New Visit Plan"),
              onTap: () {
                bloc.add(GoToCreateNewVisitPlan());
              },
            ),
            PopupMenuItem(
              value: PopUpMenu.allVisitPlan.name,
              child: const TextB(text: "All Visit Plan"),
              onTap: () {
                bloc.add(GoToTodayVisitPlan());
              },
            ),
            PopupMenuItem(
              value: PopUpMenu.dashboard.name,
              child: const TextB(text: "Dashboard"),
              onTap: () {
                bloc.add(GoToDashboard());
              },
            )
          ],
          bottomSection: ButtonB(
            press: () {
              bloc.add(SaveWithAttendance());
            },
            text: "Continue to Start",
            textColor: bWhite,
            bgColor: bBlue,
            loading: state.loading,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              BigCamera(
                press: () {
                  bloc.add(PickImage());
                },
                errorText: state.forms == Forms.invalid && state.images.isEmpty
                    ? 'Upload Image'
                    : '',
              ),
              GridViewFileImageB(
                crossAxisCount: 3,
                images: state.images,
                cancel: (index) {
                  bloc.add(CancelAnImage(index: index));
                },
              ),
            ],
          ));
    });
  }
}
