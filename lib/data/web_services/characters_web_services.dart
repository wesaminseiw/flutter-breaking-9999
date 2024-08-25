import 'package:dio/dio.dart';
import 'package:flutter_breaking/constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      if (response.statusCode == 200) {
        // Check if response data is a map
        if (response.data is Map<String, dynamic>) {
          // If the response data is a map, extract the 'results' key
          List<dynamic> characters = response.data['results'];
          return characters;
        } else {
          // If response data is not a map or does not contain 'results' key, throw an exception
          throw Exception('Response data is not in the expected format');
        }
      } else {
        // If response status code is not 200, handle it accordingly
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      // Handle DioException
      if (e is DioError) {
        print('Dio error: ${e.response?.statusCode} - ${e.message}');
      }
      // Re-throw other exceptions for further handling
      rethrow;
    }
  }
}
