import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/reset_password/bloc/reset_password_bloc.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const ResetPasswordScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ResetPasswordBloc(getIt<IFlutterNavigator>(), getIt<ApiRepo>()),
      child: ResetPasswordView(),
    );
  }
}

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final usernameFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ResetPasswordBloc>();

    return BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
      builder: (context, state) {
        return CommonBodyB(
          isAppBar: false,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Image.asset(logoPng),
              const SizedBox(height: 15),
              SvgPicture.asset(
                resetPasswordSvg,
                width: 150,
              ),
              const SizedBox(height: 20),
              const TextB(
                text: "Reset Password",
                textStyle: bHeadline2,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 12),
              const TextB(
                text:
                    "Enter the email or mobile related to your record and we'll send OTP to your phone or email with guidelines to reset your password.",
                textStyle: bSubtitle1,
                alignMent: TextAlign.center,
              ),
              const SizedBox(height: 30),
              TextFieldB(
                isAccountType: true,
                labelText: "Email",
                errorText:
                    state.forms == Forms.invalid && state.username.isEmpty
                        ? 'Enter your Email'
                        : '',
                focusNode: usernameFocusNode,
                onChanged: (value) {
                  bloc.add(UserNameChanged(username: value));
                },
              ),
              const SizedBox(height: 15),
              ButtonB(
                press: () {
                  bloc.add(SendOTP(usernameFocusNode: usernameFocusNode));
                },
                text: 'Send OTP',
                loading: state.loading,
              ),
            ],
          )),
        );
      },
    );
  }
}
