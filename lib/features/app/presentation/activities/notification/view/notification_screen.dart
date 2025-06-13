import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/notification/widgets/no_notification.dart';
import 'package:work_diary/features/app/presentation/activities/notification/widgets/notification_msg_list.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/common_body.dart';

import '../bloc/notification_bloc.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const NotificationScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationBloc(),
      child: const NotificationView(),
    );
  }
}

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<NotificationBloc>();

    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      return CommonBodyB(
        sidePadding: 0,
        appBarTitle: "Notification",
        child: Material(
          color: bWhite,
          child: Column(
            children: [
              state is NotificationInitial
                  ? const NoNotification()
                  : NotificationMsgList(
                      press: () {},
                      itemCount: 15,
                      title:
                          "Please do stock check with all visit plan is that because we want to know",
                      subTitle: "Sunday at 12:39 Pm",
                    ),
            ],
          ),
        ),
      );
    });
  }
}
