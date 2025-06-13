import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/core/ioc/ioc.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/widgets/dropdown_search.dart';
import 'package:work_diary/features/app/presentation/activities/order_note_details/bloc/bloc.dart';
import 'package:work_diary/features/app/presentation/activities/order_note_details/widgets/order_info.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/text.dart';

class OrderNoteDetailsScreen extends StatelessWidget {
  const OrderNoteDetailsScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const OrderNoteDetailsScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderNoteDetailsBloc(getIt<IFlutterNavigator>()),
      child: const OrderNoteDetailsView(),
    );
  }
}

class OrderNoteDetailsView extends StatelessWidget {
  const OrderNoteDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OrderNoteDetailsBloc>();
    final size = MediaQuery.of(context).size;

    return BlocBuilder<OrderNoteDetailsBloc, OrderNoteDetailsState>(
        builder: (context, state) {
      return CommonBodyB(
        appBarTitle: "Order Note Details",
        bottomSection: ButtonB(
          text: "Submit",
          press: () {
            bloc.add(GoToOrderCompletedScreen());
          },
          textColor: bWhite,
          bgColor: bBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Image.asset(orderDetailsPng),
            const SizedBox(height: 15),
            const TextB(
              text: "Order is Pending please do complete",
              textStyle: bHeadline4,
              fontColor: bBlue,
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
              ],
            ),
            const SizedBox(height: 20),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextB(
                  text: "Please select Order status",
                  textStyle: bBody1,
                  fontColor: bBlack,
                ),
                const SizedBox(height: 3),
                DropdownSearchB(
                  items: const [DropdownItem(name: 'Select', value: -1)],
                  selected: (index) {},
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
