import 'dart:convert';
import 'package:metronews_app/models/news_response.dart';
import 'package:metronews_app/utils/constants.dart';
import 'package:http/http.dart' as http; // mendefinisikan sebuah package atau library menjadi sebuah variabel secara langsung.

class NewsService {
  static const String _baseUrl = Constants.baseUrl;
  static final String _apiKey = Constants.apiKey;

  // untuk membuat req GET ke server
  Future<NewsResponse> getTopHeadlines({
    // mendefinisi parameter dalam fungsi
    String country = Constants.defaultCountry,
    String? category,
    int page = 1,
    int pageSize = 20,
  }) async {
    // asinkronus itu 
    try {
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        'country': country,
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };

    // statement yang akan dijalankan ketika category tidak ksong
    if (category != null && category.isNotEmpty) {
      queryParams['category'] = category;
    }

    // Uri (Uniform Resource Identifier) = mengidentifkasi sebuah URL
    // parsing = melempar dan mengambil sebuah data

    // berfungsi untuk parsing data dari json ke UI
    // simplenya: kita daftarin base_url + endPoint yg akan digunakan
    final uri = Uri.parse('$_baseUrl${Constants.topHeadlines}')
    .replace(queryParameters: queryParams); // base_url & endpoints

    // untuk menyimpan respon yg diberikan oleh server
    final response = await http.get(uri);

    // kode yg dijalankan ketika req ke API SUKSES
    if (response.statusCode == 200) {
      // untuk merubah data dari json ke bahasa dart.
      final jsonData = json.decode(response.body);
      return NewsResponse.fromJson(jsonData);
      // kode yang akan dijalankan jika request ke API GAGAL / (status != 200)
    } else {
      throw Exception('Failed to load news, please try again later');
    }  

    // kode dijalankan ketika error lain, selain error yang di atas
    } catch (e) {
      throw Exception('Another problem occurs, please try again later');
    }
  }


  Future<NewsResponse> searchNews({
    // ini adalh nilai yg dimasukkan ke kolom pencarian
    required String query,
    int page = 1, // mendefinisikan halamn berita ke berapa
    int pageSize = 20, // berapa banyak berita yg diingakn ketika sekali proses rendering data
    String? sortBy,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'apiKey': _apiKey,
        'q': query,
        'page': page.toString(),
        'pageSize': pageSize.toString()
      };

      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sortBy'] = sortBy;
      }

      final uri = Uri.parse('$_baseUrl${Constants.everything}')
      .replace(queryParameters: queryParams);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return NewsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load, please try again later');
      }
    } catch (e) {
      throw Exception('another problem occurs, please try again later');
    }
  }
}

// e = error
// encoding = data yng susah dibaca ( json = RADT)
// decoding = data yang mudah untuk dibaca ( dart = DART )