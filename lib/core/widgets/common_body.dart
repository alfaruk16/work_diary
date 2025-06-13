import 'package:flutter/material.dart';
import 'package:work_diary/core/utils/colors.dart';
import 'widgets.dart';

class CommonBodyB extends StatelessWidget {
  const CommonBodyB(
      {Key? key,
      required this.child,
      this.appBarTitle = "",
      this.isAppBar = true,
      this.backGround,
      this.topSection,
      this.drawer,
      this.bottomSection,
      this.back = true,
      this.sidePadding = 20,
      this.menuList,
      this.onBack,
      this.bottomNav,
      this.onWillPop = true,
      this.loading = false})
      : super(key: key);

  final Widget child;
  final double sidePadding;
  final Widget? bottomSection;
  final Widget? bottomNav;
  final Widget? topSection;
  final Widget? drawer;
  final String? appBarTitle;
  final bool isAppBar;
  final bool back;
  final Color? backGround;
  final List<PopupMenuItem>? menuList;
  final VoidCallback? onBack;
  final bool onWillPop;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return onWillPop;
        },
        child: Scaffold(
          drawer: drawer,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Site AppBar===
                if (isAppBar)
                  AppBarB(
                      appBarTittle: appBarTitle!,
                      backButton: back,
                      list: menuList,
                      onBack: onBack,
                      loading: loading),

                if (topSection != null)
                  Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 15,
                      ),
                      child: topSection!),

                Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.symmetric(horizontal: sidePadding),
                        child: child)),

                if (bottomSection != null)
                  Container(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 10,
                        right: 20,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                        color: bWhite,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0XFF979797).withOpacity(0.25),
                            offset: const Offset(0, -1),
                            blurRadius: 4,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: bottomSection!),

                if (bottomNav != null) bottomNav!,
              ],
            ),
          ),
        ));
  }
}
