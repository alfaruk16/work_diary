import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/presentation/activities/order_completed/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/order_note_details/widgets/order_info.dart';

import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class OrderCompletedScreen extends StatelessWidget {
  const OrderCompletedScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const OrderCompletedScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCompletedBloc(),
      child: const OrderCompletedView(),
    );
  }
}

class OrderCompletedView extends StatelessWidget {
  const OrderCompletedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<OrderCompletedBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<OrderCompletedBloc, OrderCompletedState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Completed Order Note",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              completedOrderPng,
              width: 200,
            ),
            const SizedBox(height: 15),
            const TextB(
              text: "This Order has been Completed",
              fontSize: 20,
              fontColor: bGreen,
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
                text: "Monalica Wall tile 35x35 25 box",
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
                OrderInfo(
                  leftText: "Brand",
                  rightText: "Monalica",
                ),
                OrderInfo(
                  leftText: "Product Type",
                  rightText: "Wall Tile",
                ),
                OrderInfo(
                  leftText: "Product Size",
                  rightText: "35x35",
                ),
                OrderInfo(
                  leftText: "Quantity Box",
                  rightText: "25",
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Column(
              children: const [
                OrderInfo(
                  leftText: "Order no of the day:",
                  rightText: "03",
                ),
                OrderInfo(
                  leftText: "Shop Name:",
                  rightText: "Enayet & Brothers",
                ),
                OrderInfo(
                  leftText: "Shop id:",
                  rightText: "Raj-1",
                ),
                OrderInfo(
                  isIcon: true,
                  leftText: "Route:",
                  rightText: "Badda Link road, gulshan-1",
                ),
                OrderInfo(
                  leftText: "Created by:",
                  rightText: "Created by me",
                ),
                OrderInfo(
                  leftText: "Order Created:",
                  rightText: "09 Jul 2022",
                ),
                OrderInfo(
                  leftText: "Committed to deliver:",
                  rightText: "12 Jul 2022",
                ),
                OrderInfo(
                  color: bGreen,
                  leftText: "Order Canceled",
                  rightText: "12 Jul 2022",
                ),
              ],
            ),
            const SizedBox(height: 30),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextB(
                    text: "Close Details",
                    textStyle: bBody1,
                    fontColor: bGreen,
                  ),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: bGreen,
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
