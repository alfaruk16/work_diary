import 'package:injectable/injectable.dart';
import 'package:work_diary/core/error/custom_error.dart';
import 'package:work_diary/core/error/custom_exception.dart';
import 'package:work_diary/core/ioc/global.dart';
import 'package:work_diary/core/navigator/iflutter_navigator.dart';
import 'package:work_diary/core/network_info/network_info.dart';
import 'package:work_diary/core/utils/utilities.dart';
import 'package:work_diary/features/app/data/data_sources/remote_gateway_base.dart';
import 'package:work_diary/features/app/domain/repositories/api_repo.dart';

const String noInternetConnection = 'No Internet Connection';

@LazySingleton(as: ApiRepo)
class ApiRepoImpl extends RemoteGatewayBase implements ApiRepo {
  const ApiRepoImpl(this.networkInfo);

  final NetworkInfo networkInfo;

  @override
  Future<T?> post<T, K>(
      {required String endpoint,
      dynamic body,
      required T responseModel,
      String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await postMethod<T, void>(
          endpoint: endpoint, data: body, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> get<T, K>(
      {required String endpoint,
      body,
      required T responseModel,
      String? token}) async {
    dynamic data;
    if (await networkInfo.isConnected) {
      data = await getMethod<T, void>(endpoint: endpoint);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }

  @override
  Future<T?> multipart<T, K>(
      {required String endpoint,
      Map<String, String>? body,
      List<ImageFile>? files,
      required T responseModel,
      String? token}) async {
    dynamic data;

    if (await networkInfo.isConnected) {
      data = await multiPartMethod<T, void>(
          endpoint: endpoint, data: body, files: files, token: token);
    } else {
      AppException(CustomError(message: noInternetConnection),
          getIt<IFlutterNavigator>());
    }
    return data;
  }
}
