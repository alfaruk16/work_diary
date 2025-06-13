import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/presentation/activities/notification/bloc/notification_bloc.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/text.dart';

class NoNotification extends StatelessWidget {
  const NoNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      final bloc = context.read<NotificationBloc>();
      final size = MediaQuery.of(context).size;

      return Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            const Image(
              image: AssetImage(bellPng),
              height: 200,
            ),
            const SizedBox(height: 20),
            const TextB(
              text: "No Notifications Yet",
              fontColor: bSkyBlue,
              textStyle: bHeadline4,
            ),
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 3,
              decoration: BoxDecoration(
                color: bLightGray,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const SizedBox(height: 40),
            const TextB(
              text: "When you get notifications, they’ll\n show up here",
              alignMent: TextAlign.center,
              textStyle: bHeadline5,
              fontWeight: FontWeight.normal,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 147,
              child: ButtonB(
                heigh: 53,
                text: "Refresh",
                press: () {
                  bloc.add(LoadedNotificationEvent());
                },
                textColor: bWhite,
                bgColor: bSkyBlue,
              ),
            )
          ],
        ),
      );
    });
  }
}
