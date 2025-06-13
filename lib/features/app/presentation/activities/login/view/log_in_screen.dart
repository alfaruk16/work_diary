import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/enums.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/core/widgets/text_field.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/login/bloc/bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const LogInScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(getIt<IFlutterNavigator>(), getIt<ApiRepo>(),
          getIt<LocalStorageRepo>()),
      child: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final userNameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return CommonBodyB(
        isAppBar: false,
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(
              width: size.width / 2,
              child: Image.asset(logoPng),
            ),
            const SizedBox(height: 15),
            SvgPicture.asset(
              loginSvg,
              width: 150,
            ),
            const SizedBox(height: 40),
            const TextB(
              text: "Welcome",
              textStyle: bHeadline2,
              fontWeight: FontWeight.w600,
            ),
            const TextB(
              text: "Please login to continue",
              textStyle: bSubtitle1,
            ),
            const SizedBox(height: 30),
            TextFieldB(
                isAccountType: true,
                labelText: "Email",
                errorText:
                    state.forms == Forms.invalid && state.userName.isEmpty
                        ? 'Enter username'
                        : '',
                focusNode: userNameFocusNode,
                onChanged: (value) {
                  bloc.add(UserNameChanged(userName: value));
                }),
            const SizedBox(height: 15),
            TextFieldB(
                isAccountType: true,
                labelText: "Password",
                errorText:
                    state.forms == Forms.invalid && state.password.isEmpty
                        ? 'Enter password'
                        : '',
                suffixIcon: GestureDetector(
                  onTap: () {
                    bloc.add(
                        PasswordVisibility(visibility: state.passwordObscure));
                  },
                  child: Icon(
                    state.passwordObscure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 24,
                    color: bLightGray,
                  ),
                ),
                obscureText: state.passwordObscure,
                focusNode: passwordFocusNode,
                onChanged: (value) {
                  bloc.add(PasswordChanged(password: value));
                }),
            const SizedBox(height: 26),
            ButtonB(
              press: () {
                bloc.add(LoginButtonPressed(
                    userNameFocusNode: userNameFocusNode,
                    passwordFocusNode: passwordFocusNode));
              },
              text: 'Log in',
              loading: state.loading,
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                bloc.add(ForgotPassword());
              },
              child: const TextB(text: 'Forgot Password'),
            ),
            const SizedBox(height: 15),
          ],
        )),
      );
    });
  }
}
