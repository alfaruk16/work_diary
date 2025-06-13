import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/presentation/activities/check_in/bloc/check_in_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/circle_btn.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const CheckInScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckInBlock(getIt<IFlutterNavigator>()),
      child: const CheckInView(),
    );
  }
}

class CheckInView extends StatelessWidget {
  const CheckInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CheckInBlock>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CheckInBlock, CheckInState>(builder: (context, state) {
      return CommonBodyB(
        isAppBar: false,
        // backGround: const [
        //   Color(0XFF1D68F5),
        //   Color(0XFF0D3FE9),
        // ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(logoPng),
                CircleBtn(
                  btnSize: 55,
                  press: () {
                    bloc.add(GoToVisitPlan());
                  },
                  title: "Visit Plan",
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            const TextB(
              text: '10:30 AM',
              textStyle: bHeadline1,
              fontColor: bWhite,
              fontHeight: 1.2,
            ),
            const TextB(
              text: "Wednesday, Janu 15",
              fontHeight: 1.2,
              textStyle: bHeadline3,
              fontColor: bWhite,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: size.height * 0.05),
            CircleBtn(
              bgColor: const [Color(0XFFFFDF80), Color(0XFFF9C529)],
              btnSize: size.width * 0.57,
              press: () {
                bloc.add(GoToCheckInFormScreen());
              },
              child: SvgPicture.asset(
                checkOutSvg,
                colorFilter: const ColorFilter.mode(bBlue,  BlendMode.srcIn),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const TextB(
              text: "Check In",
              fontHeight: 1,
              textStyle: bHeadline3,
              fontColor: bWhite,
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.pin_drop,
                  size: 23,
                  color: bWhite,
                ),
                TextB(
                  fontHeight: 1,
                  text: "Location: Badda Link road, gulshan-1",
                  textStyle: bBody1,
                  fontColor: bWhite,
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            CircleBtn(
              press: () {
                bloc.add(GoToLoginScreen());
              },
              title: "Log in",
              icon: Icons.near_me,
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      );
    });
  }
}
