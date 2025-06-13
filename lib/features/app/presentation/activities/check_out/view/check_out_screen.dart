import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/presentation/activities/check_out/bloc/check_out_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/circle_btn.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const CheckOutScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CheckOutBloc(getIt<IFlutterNavigator>()),
      child: const CheckOutView(),
    );
  }
}

class CheckOutView extends StatelessWidget {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<CheckOutBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<CheckOutBloc, CheckOutState>(builder: (context, state) {
      return CommonBodyB(
        isAppBar: false,
        // backGround: const [
        //   Color(0XFF1D68F5),
        //   Color(0XFF0D3FE9),
        // ],
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(logoPng),
                CircleBtn(
                  btnSize: 55,
                  press: () {},
                  title: "Visit Plan",
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
            const TextB(
              text: "07:22 AM",
              textStyle: bHeadline1,
              fontColor: bWhite,
              fontHeight: 1.2,
            ),
            TextB(
              text: DateFormat("EEEE, MMMM dd").format(DateTime.now()),
              fontHeight: 1.2,
              textStyle: bHeadline3,
              fontColor: bWhite,
              fontWeight: FontWeight.normal,
            ),
            SizedBox(height: size.height * 0.05),
            CircleBtn(
              bgColor: const [Color(0XFFFF4841), Color(0XFFE33F3B)],
              btnSize: size.width * 0.57,
              press: () {
                context.read<CheckOutBloc>().add(GoToCheckInEvent());
              },
              child: SvgPicture.asset(
                checkOutSvg,
                colorFilter: const ColorFilter.mode(bWhite,  BlendMode.srcIn),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const TextB(
              text: "Check Out",
              fontHeight: 1,
              textStyle: bHeadline3,
              fontColor: bWhite,
            ),
            SizedBox(height: size.height * 0.01),
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
            SizedBox(height: size.height * 0.07),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                CircleBtn(
                  title: "10:30 AM",
                  subTitle: "Check In",
                  icon: Icons.access_alarm,
                ),
                CircleBtn(
                  title: "-- : --",
                  subTitle: "Check Out",
                  icon: Icons.schedule,
                ),
                CircleBtn(
                  title: "08:25 H",
                  subTitle: "Total Time",
                  icon: Icons.update,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
