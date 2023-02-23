// import 'package:dio/dio.dart';

// class DioHelper {
//   static Dio? dio;
//   static init() {
//     dio = Dio(BaseOptions(
//         baseUrl: "https://cleaning.3m-erp.com/khadamaty/api/",
//         headers: {
//           "Content-Type": "application/json",
//           "lang": "ar",
//         }));
//   }

//   static Future<Response> postData({
//     required String url,
//     Map<String, dynamic>? query,
//     required Map<String, dynamic> data,
//   }) async {
//     dio!.options.headers = {
//       'lang': 'en',
//       'Content-Type': 'application/json',
//     };
//     return dio!.post(url, queryParameters: query, data: data);
//   }
// }
