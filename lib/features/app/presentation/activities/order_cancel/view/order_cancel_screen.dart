import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/features/app/presentation/activities/order_cancel/widgets/cancel_order_info.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';
import '../bloc/order_cancel_bloc.dart';

class OrderCancelScreen extends StatelessWidget {
  const OrderCancelScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const OrderCancelScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCancelBloc(),
      child: const OrderCancelView(),
    );
  }
}

class OrderCancelView extends StatelessWidget {
  const OrderCancelView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = context.read<OrderCancelBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<OrderCancelBloc, OrderCancelState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Cancel Order Note Details",
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Image.asset(
              cancelOrderPng,
              width: 200,
            ),
            const SizedBox(height: 15),
            const TextB(
              text: "This Order has been Canceled",
              fontSize: 20,
              fontColor: Color(0XFFFB8C00),
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
                text: "Monalica Wall Tile 25 box, Alexander Tile Floor 75 box",
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
                CancelOrderInfo(
                  leftText: "Brand",
                  rightText: "Monalica",
                ),
                CancelOrderInfo(
                  leftText: "Product Type",
                  rightText: "Wall Tile",
                ),
                CancelOrderInfo(
                  leftText: "Product Size",
                  rightText: "35x35",
                ),
                CancelOrderInfo(
                  leftText: "Quantity Box",
                  rightText: "25",
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: const [
                CancelOrderInfo(
                  leftText: "Brand",
                  rightText: "Alexander Tile",
                ),
                CancelOrderInfo(
                  leftText: "Product Type",
                  rightText: "Floor Tile",
                ),
                CancelOrderInfo(
                  leftText: "Product Size",
                  rightText: "24x24",
                ),
                CancelOrderInfo(
                  leftText: "Quantity Box",
                  rightText: "75",
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
                CancelOrderInfo(
                  leftText: "Order no of the day:",
                  rightText: "03",
                ),
                CancelOrderInfo(
                  leftText: "Shop Name:",
                  rightText: "Enayet & Brothers",
                ),
                CancelOrderInfo(
                  leftText: "Shop id:",
                  rightText: "Raj-1",
                ),
                CancelOrderInfo(
                  isIcon: true,
                  leftText: "Route:",
                  rightText: "Badda Link road, gulshan-1",
                ),
                CancelOrderInfo(
                  leftText: "Created by:",
                  rightText: "Created by me",
                ),
                CancelOrderInfo(
                  leftText: "Order Created:",
                  rightText: "09 Jul 2022",
                ),
                CancelOrderInfo(
                  leftText: "Committed to deliver:",
                  rightText: "12 Jul 2022",
                ),
                CancelOrderInfo(
                  color: Color(0XFFFB8C00),
                  leftText: "Order Canceled",
                  rightText: "12 Jul 2022",
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextB(
                    text: "Order Note",
                    fontColor: bBlack,
                    fontWeight: FontWeight.w500,
                  ),
                  TextB(
                    text:
                        "product are almost finished  please deliver the products as early as possible",
                    fontColor: bDarkGray,
                    fontHeight: 1.3,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TextB(
                    text: "Close Details",
                    textStyle: bBody1,
                    fontColor: Color(0XFFFB8C00),
                  ),
                  Icon(
                    Icons.keyboard_arrow_up,
                    color: Color(0XFFFB8C00),
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
