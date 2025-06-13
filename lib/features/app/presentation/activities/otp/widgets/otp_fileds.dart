import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_diary/features/app/presentation/activities/otp/bloc/bloc.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/text_field.dart';

class OtpFields extends StatelessWidget {
  const OtpFields(
      {Key? key,
      required this.one,
      required this.two,
      required this.three,
      required this.four,
      required this.five,
      required this.six})
      : super(key: key);

  final FocusNode one;
  final FocusNode two;
  final FocusNode three;
  final FocusNode four;
  final FocusNode five;
  final FocusNode six;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpBloc, OtpState>(builder: (context, state) {
      final bloc = context.read<OtpBloc>();

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 48,
            child: TextFieldB(
                paddingHeight: 10,
                paddingWidth: 5,
                isAccountType: true,
                maxLength: 1,
                textStyle: bAccountField,
                textAlign: TextAlign.center,
                textInputType: TextInputType.number,
                focusNode: one,
                onChanged: (value) {
                  bloc.add(OtpOneChanged(text: value, nextFocus: two));
                }),
          ),
          SizedBox(
            width: 45,
            child: TextFieldB(
                paddingHeight: 10,
                isAccountType: true,
                maxLength: 1,
                textStyle: bAccountField,
                textAlign: TextAlign.center,
                textInputType: TextInputType.number,
                focusNode: two,
                onChanged: (value) {
                  bloc.add(OtpTwoChanged(
                      text: value, prevFocus: one, nextFocus: three));
                }),
          ),
          SizedBox(
            width: 48,
            child: TextFieldB(
                paddingHeight: 10,
                isAccountType: true,
                maxLength: 1,
                textStyle: bAccountField,
                textAlign: TextAlign.center,
                textInputType: TextInputType.number,
                focusNode: three,
                onChanged: (value) {
                  bloc.add(OtpThreeChanged(
                      text: value, prevFocus: two, nextFocus: four));
                }),
          ),
          SizedBox(
            width: 48,
            child: TextFieldB(
                paddingHeight: 10,
                isAccountType: true,
                maxLength: 1,
                textStyle: bAccountField,
                textAlign: TextAlign.center,
                textInputType: TextInputType.number,
                focusNode: four,
                onChanged: (value) {
                  bloc.add(OtpFourChanged(
                      text: value, prevFocus: three, nextFocus: five));
                }),
          ),
          SizedBox(
            width: 48,
            child: TextFieldB(
                paddingHeight: 10,
                maxLength: 1,
                isAccountType: true,
                textStyle: bAccountField,
                textAlign: TextAlign.center,
                textInputType: TextInputType.number,
                focusNode: five,
                onChanged: (value) {
                  bloc.add(OtpFiveChanged(
                      text: value, prevFocus: four, nextFocus: six));
                }),
          ),
          SizedBox(
            width: 48,
            child: TextFieldB(
                paddingHeight: 10,
                isAccountType: true,
                maxLength: 1,
                textStyle: bAccountField,
                textAlign: TextAlign.center,
                textInputType: TextInputType.number,
                focusNode: six,
                onChanged: (value) {
                  bloc.add(OtpSixChanged(text: value, prevFocus: five));
                }),
          ),
        ],
      );
    });
  }
}
