import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'package:work_diary/core/widgets/text.dart';

class AppBarB extends StatelessWidget {
  const AppBarB(
      {Key? key,
      this.appBarTittle,
      this.backButton = true,
      this.list,
      this.onBack,
      this.loading = false})
      : super(key: key);

  final String? appBarTittle;
  final bool backButton;
  final List<PopupMenuItem>? list;
  final VoidCallback? onBack;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: const BoxDecoration(color: bWhite),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (backButton)
                InkWell(
                  onTap: () {
                    if (onBack != null) {
                      onBack!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  borderRadius: BorderRadius.circular(40),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.arrow_back, color: bDarkGray),
                  ),
                ),
              if (!backButton)
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  borderRadius: BorderRadius.circular(40),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(Icons.menu, color: bDarkGray),
                  ),
                ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: TextB(
                  text: appBarTittle!,
                  fontSize: 16,
                  maxLines: 1,
                ),
              )),
              PopupMenuButton(
                  onSelected: (value) {},
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    child: const Icon(Icons.more_vert, color: bDarkGray),
                  ),
                  itemBuilder: (context) => list ?? []),
            ],
          ),
        ),
        loading
            ? const LinearProgressIndicator(
                minHeight: 2,
                color: bGreen,
              )
            : const Divider(height: 2, color: bBorderColor, thickness: 2),
      ],
    );
  }
}
