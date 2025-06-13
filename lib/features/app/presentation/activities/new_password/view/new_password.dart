import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/new_password/bloc/bloc.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const NewPasswordScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewPasswordBloc(getIt<IFlutterNavigator>(),
          getIt<ApiRepo>(), getIt<LocalStorageRepo>()),
      child: NewPasswordView(),
    );
  }
}

class NewPasswordView extends StatelessWidget {
  NewPasswordView({Key? key}) : super(key: key);

  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewPasswordBloc>();

    return BlocBuilder<NewPasswordBloc, NewPasswordState>(
        builder: (context, state) {
      return CommonBodyB(
        isAppBar: false,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 10),
            Image.asset(logoPng),
            const SizedBox(height: 15),
            SvgPicture.asset(
              newPasswordSvg,
              width: 200,
            ),
            const SizedBox(height: 30),
            const TextB(
              text: "New Password",
              textStyle: bHeadline2,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 12),
            const TextB(
              text: "Please type your new passwrd",
              textStyle: bSubtitle1,
              alignMent: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextFieldB(
              isAccountType: true,
              labelText: "New Password",
              focusNode: passwordFocusNode,
              onChanged: (value) {
                bloc.add(PasswordChanged(password: value));
              },
              errorText: state.password.isEmpty && state.forms == Forms.invalid
                  ? 'Enter New Password'
                  : '',
            ),
            const SizedBox(height: 15),
            TextFieldB(
                isAccountType: true,
                labelText: "Re-Type Password",
                focusNode: confirmPasswordFocusNode,
                errorText: state.confirmPassword.isEmpty &&
                        state.forms == Forms.invalid
                    ? 'Enter Confirm Password'
                    : '',
                onChanged: (value) {
                  bloc.add(ConfirmPasswordChanged(confirmPassword: value));
                }),
            const SizedBox(height: 20),
            ButtonB(
              press: () {
                bloc.add(ResetPasswordPressed(
                    passwordFocusNode: passwordFocusNode,
                    confirmPasswordFocusNode: confirmPasswordFocusNode));
              },
              text: 'Save Password',
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: const TextB(
                text: "Close",
                fontSize: 19,
              ),
            ),
          ],
        ),
      );
    });
  }
}
