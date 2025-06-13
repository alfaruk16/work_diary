import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/presentation/activities/postpone/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/postpone/widgets/details_item.dart';
import 'package:work_diary/features/app/presentation/activities/postpone/widgets/reason.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class PostponeScreen extends StatelessWidget {
  const PostponeScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const PostponeScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostponeBloc(getIt<IFlutterNavigator>()),
      child: const PostponeView(),
    );
  }
}

class PostponeView extends StatelessWidget {
  const PostponeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PostponeBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<PostponeBloc, PostponeState>(builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Postpone Visit Plan",
        bottomSection: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              bloc.add(GoToTodaysVisitPlanScreen());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                TextB(
                  text: "All Visit Plan",
                  fontColor: Color(0XFFF34C75),
                ),
                Icon(
                  Icons.navigate_next,
                  size: 18,
                  color: Color(0XFFF34C75),
                )
              ],
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Image.asset(logoPng),
            const SizedBox(height: 15),
            const TextB(
              text: "This Visit Plan is Postpone",
              textStyle: bHeadline4,
              fontColor: Color(0XFFF34C75),
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 100,
              child: Divider(
                height: 0,
                thickness: 3,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: size.width,
              child: const TextB(
                text: "Shop sign installation, and Catalog distribution",
                fontHeight: 1.3,
                textStyle: bHeadline3,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Column(
              children: const [
                DetailsItem(
                  leftText: "Visit Plan:",
                  rightText: "03",
                ),
                DetailsItem(
                  leftText: "Shop Name:",
                  rightText: "Enayet & Brothers",
                ),
                DetailsItem(
                  leftText: "Shop id:",
                  rightText: "Raj-1",
                ),
                DetailsItem(
                  isIcon: true,
                  leftText: "Route:",
                  rightText: "Badda Link road, gulshan-1",
                ),
                DetailsItem(
                  leftText: "Created Date:",
                  rightText: "26 Jul 2022",
                ),
                DetailsItem(
                  leftText: "Visit Created For:",
                  rightText: "28 Jul 2022",
                ),
                DetailsItem(
                  leftText: "Postpone Date:",
                  rightText: "28 Jul 2022",
                ),
                DetailsItem(
                  leftText: "Created by:",
                  rightText: "Created by me",
                ),
                DetailsItem(
                  color: Color(0XFFF2416C),
                  leftText: "Postpone by:",
                  rightText: "Admin",
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Reason(),
          ],
        ),
      );
    });
  }
}
