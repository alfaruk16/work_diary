import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/utils/asset_image.dart';
import 'package:work_diary/core/utils/text_styles.dart';
import 'package:work_diary/core/widgets/button.dart';
import 'package:work_diary/core/widgets/common_body.dart';
import 'package:work_diary/core/widgets/radio_button.dart';
import 'package:work_diary/core/widgets/text.dart';
import 'package:work_diary/features/app/domain/repositories/local_storage_repo.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';
import 'package:work_diary/features/app/presentation/activities/compnaies/bloc/companies_bloc.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  static Route<dynamic> route() => MaterialPageRoute<dynamic>(
        builder: (_) => const CompaniesScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompaniesBloc(getIt<IFlutterNavigator>(), getIt<ApiRepo>(),
          getIt<LocalStorageRepo>()),
      child: const CompaniesView(),
    );
  }
}

class CompaniesView extends StatelessWidget {
  const CompaniesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CompaniesBloc>();

    return BlocBuilder<CompaniesBloc, CompaniesState>(
        builder: (context, state) {
      return CommonBodyB(
        isAppBar: false,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Image.asset(logoPng),
            const SizedBox(height: 15),
            SvgPicture.asset(
              loginSvg,
              width: 150,
            ),
            const SizedBox(height: 20),
            const TextB(
              text: "Select Company",
              textStyle: bHeadline2,
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(
              height: 20,
            ),
            RadioGroupB(
              radioValues: state.radios,
              index: (index) {
                bloc.add(CompanySelected(index: index));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonB(
                text: 'Continue',
                press: () {
                  bloc.add(GoToDashboard());
                })
          ],
        ),
      );
    });
  }
}
