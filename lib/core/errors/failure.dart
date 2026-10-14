import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMsg;

  Failure({required this.errorMsg});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMsg});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMsg});
}

class ApiFailure extends Failure {
  ApiFailure({required super.errorMsg});

  factory ApiFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ApiFailure(errorMsg: 'Connction time outTime with api');
      case DioExceptionType.sendTimeout:
        return ApiFailure(errorMsg: 'Send messege fail with api');
      case DioExceptionType.receiveTimeout:
        return ApiFailure(errorMsg: 'Receive messege fail with api');
      case DioExceptionType.badCertificate:
        return ApiFailure(errorMsg: 'Bad certificate received');
      case DioExceptionType.badResponse:
        return ApiFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ApiFailure(
          errorMsg: 'the reust was cancelled ,please try again!',
        );
      case DioExceptionType.connectionError:
        return ApiFailure(
          errorMsg: 'the internet connection fail,please try again!',
        );
      case DioExceptionType.unknown:
        return ApiFailure(errorMsg: 'Unexpected error ,please try again!');
      // ignore: unreachable_switch_default
      default:
        return ApiFailure(
          errorMsg: 'Oops ther was an error ,please try again!',
        );
    }
  }
  factory ApiFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response != null && response is Map<String, dynamic>) {
        if (response.containsKey('detail')) {
          return ApiFailure(errorMsg: response['detail'].toString());
        }

        if (response.containsKey('message')) {
          return ApiFailure(errorMsg: response['message'].toString());
        }

        if (response.containsKey('error')) {
          if (response['error'] is Map) {
            return ApiFailure(
              errorMsg: response['error']['message'] ?? "Unknown Error",
            );
          } else {
            return ApiFailure(errorMsg: response['error'].toString());
          }
        }
      }
      return ApiFailure(errorMsg: 'Authentication Error, Please try again');
    } else if (statusCode == 404) {
      return ApiFailure(errorMsg: 'Your request not found, please try later!');
    } else if (statusCode == 500) {
      return ApiFailure(errorMsg: 'Internal Server error, please try later!');
    } else {
      return ApiFailure(errorMsg: 'Opps There was an Error, Please try again');
    }
  }
}
