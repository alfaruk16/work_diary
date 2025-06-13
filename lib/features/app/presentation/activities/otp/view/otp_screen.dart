import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/otp/bloc/bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/features/app/presentation/activities/otp/widgets/otp_fileds.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key, required this.userName}) : super(key: key);

  final String userName;

  static Route<dynamic> route(String userName) => MaterialPageRoute<dynamic>(
        builder: (_) => OtpScreen(
          userName: userName,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpBloc(getIt<IFlutterNavigator>(), getIt<ApiRepo>(),
          getIt<LocalStorageRepo>()),
      child: OtpView(
        userName: userName,
      ),
    );
  }
}

class OtpView extends StatelessWidget {
  OtpView({Key? key, required this.userName}) : super(key: key);
  final String userName;

  final otpOneFocusNode = FocusNode();
  final otpTwoFocusNode = FocusNode();
  final otpThreeFocusNode = FocusNode();
  final otpFourFocusNode = FocusNode();
  final otpFiveFocusNode = FocusNode();
  final otpSixFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OtpBloc>();
    bloc.add(UpdateUserName(userName: userName));

    return BlocBuilder<OtpBloc, OtpState>(builder: (context, state) {
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
              otpSvg,
              width: 200,
            ),
            const SizedBox(height: 30),
            const TextB(
              text: "Type your OTP",
              textStyle: bHeadline2,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 12),
            const TextB(
              text:
                  "An OTP is sent to your registered email or mobile number. Please type the sent OTP and press “OK” ",
              textStyle: bSubtitle1,
              alignMent: TextAlign.center,
            ),
            const SizedBox(height: 30),
            OtpFields(
                one: otpOneFocusNode,
                two: otpTwoFocusNode,
                three: otpThreeFocusNode,
                four: otpFourFocusNode,
                five: otpFiveFocusNode,
                six: otpSixFocusNode),
            const SizedBox(height: 20),
            ButtonB(
              press: () {
                bloc.add(SubmitOtp(
                    one: otpOneFocusNode,
                    two: otpTwoFocusNode,
                    three: otpThreeFocusNode,
                    four: otpFourFocusNode,
                    five: otpFiveFocusNode,
                    six: otpSixFocusNode));
              },
              text: 'Send OTP',
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextB(
                  text: "Didn't receive the code? ",
                  fontSize: 19,
                ),
                InkWell(
                  onTap: () {
                    bloc.add(ResendOTP());
                  },
                  child: const TextB(
                    text: "Resend",
                    fontSize: 19,
                    fontColor: bBlue,
                  ),
                ),
              ],
            )
          ],
        )),
      );
    });
  }
}
