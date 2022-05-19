import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart' as GET;

class Api {
  static final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.110:7000/',
      receiveDataWhenStatusError: true,
    ),
  );

  static void initializeInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          var token = await GetStorage().read('login_token');

          var headers = {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token}',
          };

          request.headers.addAll(headers);
          print('${request.method} ${request.path}');
          print('${request.headers}');
          return handler.next(request); //continue
        },
        onResponse: (response, handler) {
          print('${response.data}');
          if (response.data['error'] == 1) throw response.data['message'];

          return handler.next(response); // continue
        },
        onError: (error, handler) {
          print(error);
          if (GET.Get.isDialogOpen == true) {
            GET.Get.back();
          }

          GET.Get.snackbar(
            'error'.tr,
            '${error.message}',
            snackPosition: GET.SnackPosition.BOTTOM,
            // backgroundColor: Colors.red,
            // colorText: Colors.white,
          );

          return handler.next(error); //continue
        },
      ),
    );
  }

  static Future<Response> getGenres() async {
    return await dio.get('api/genres');
  }

  static Future<Response> getMovies({
    int page = 1,
    String? type,
    int? genre,
  }) async {
    return await dio.post(
      'api/movies',
      queryParameters: {'type': type, 'genre_id': genre, 'page': page},
    );
  }
}
