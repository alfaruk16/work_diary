import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/text.dart';

Future showNoInternetConnection(IFlutterNavigator navigator,
    {required Function dismiss}) {
  return showDialog(
      context: navigator.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: const EdgeInsets.all(10),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      navigator.pop();
                      dismiss(true);
                    },
                    child: const Icon(Icons.close, color: Colors.red),
                  ),
                ),
                const SizedBox(height: 10),
                SvgPicture.asset(noInternetSvg),
                const SizedBox(height: 20),
              ],
            ));
      });
}
