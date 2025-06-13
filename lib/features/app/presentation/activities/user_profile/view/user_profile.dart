import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/presentation/activities/dashboard/widgets/profile_header.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/widgets/performance_button.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/widgets/information_item.dart';
import 'package:work_diary/features/app/presentation/activities/user_profile/widgets/title.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const UserProfileScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserProfileBloc(getIt<IFlutterNavigator>(),
          getIt<LocalStorageRepo>(), getIt<ImagePicker>(), getIt<ApiRepo>()),
      child: const UserProfileView(),
    );
  }
}

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<UserProfileBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "My Profile",
        child: state.userDetails.data != null
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: Alignment.topCenter,
                    clipBehavior: Clip.none,
                    children: [
                      if (state.userDetails.data != null)
                        ProfileHeader(
                          size: 110,
                          image: state.userDetails.data!.avatar,
                          isRowHeader: false,
                          userName: state.userDetails.data!.name ?? '',
                          title: state.userDetails.data!.designation ?? '',
                        ),
                      Positioned(
                        right: size.width * 0.24,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {
                              bloc.add(PickImage());
                            },
                            child: Ink(
                              width: 50,
                              height: 50,
                              padding: const EdgeInsets.all(9),
                              decoration: BoxDecoration(
                                color: bWhite,
                                shape: BoxShape.circle,
                                border: Border.all(color: bLightGray),
                              ),
                              child: SvgPicture.asset(cameraSvg),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                      onTap: () {
                        bloc.add(GoToPerformance());
                      },
                      child: const PerformanceButton()),
                  const SizedBox(height: 15),
                  Ttile(
                    press: () {
                      bloc.add(EditPhoneEvent(ctx: context));
                    },
                    title: "Personal Information",
                    titlLinkText: "Edit Phone",
                  ),
                  const SizedBox(height: 12),
                  InformationItem(
                    titleText: "Last Name",
                    valueText: state.userDetails.data!.name ?? '',
                  ),
                  InformationItem(
                    titleText: "Designation",
                    valueText: state.userDetails.data!.designation ?? '',
                  ),
                  InformationItem(
                    titleText: "Department",
                    valueText: state.userDetails.data!.department ?? '',
                  ),
                  InformationItem(
                    titleText: "User Id",
                    valueText: state.userDetails.data!.code ?? '',
                  ),
                  InformationItem(
                    titleText: "Phone",
                    valueText: state.userDetails.data!.mobile ?? '',
                  ),
                  InformationItem(
                    titleText: "Email",
                    valueText: state.userDetails.data!.email ?? '',
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      bloc.add(GoToResetPasswordScreen());
                    },
                    child: const TextB(
                      text: "Change Password",
                      fontColor: bBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Ttile(
                    title: "Company Information",
                  ),
                  const SizedBox(height: 12),
                  InformationItem(
                    titleText: "Company",
                    valueText: state.userDetails.data!.company!.name ?? "",
                  ),
                  InformationItem(
                    titleText: "Address",
                    valueText: state.userDetails.data!.company!.address ?? "",
                  ),
                ],
              )
            : const Text("Loading..."),
      );
    });
  }
}
