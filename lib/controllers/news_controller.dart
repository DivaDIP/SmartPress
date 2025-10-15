import 'package:get/get.dart';
import 'package:metronews_app/models/news_articles.dart';
import 'package:metronews_app/services/news_services.dart';
import 'package:metronews_app/utils/constants.dart';

class NewsController extends GetxController {
  final NewsService _newsServices = NewsService();

  //setters
  // Observable variables
  final _isLoading = false.obs; // apakah aplikasi sedang memuat berita
  final _articles = <NewsArticles>[].obs; // ini untuk menampilkan daftar berita yang sudah atau berhasil di dapat
  final _selectedCategory = 'general'.obs; // untuk handle category yang sedang di pilih, atau yang akan muncul di homescreen
  final _error = ''.obs; // kalau ada kesalahan pesan error akan disimpan disini

  // Getters 
  // ini tuh kayak jendela  untuk melihat variable yang sudah di definisikan dengan ini.
  //ui bisa dengan mudah melihat data dari controller
  bool get isLoading => _isLoading.value;
  List<NewsArticles> get articles => _articles; 
  String get selectedCategory => _selectedCategory.value;
  String get error => _error.value;
  List<String> get categories => Constants.categories;



  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }

    // begitu aplikasi di buka, aplikasi langusng menampilkan berita utama dari endpoint top-headlines
  // TODO: fetching data dari endpoint

  Future<void> fetchTopHeadlines({String? category}) async {
    //blok ini dijalan kan ketika REST API berhasil komunikasi dengan client
    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await _newsServices.getTopHeadlines(
        category: category ?? _selectedCategory.value,
      );

      _articles.value = response.articles;
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to load news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      // finally akan tetap di execute setelah salah satu dari blok try atau catch sudah berhasil mendapatkan ahsil
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> refreshNews() async {
    await fetchTopHeadlines();
  }

  void selectCategory(String category) {
    if (_selectedCategory.value != category) {
      _selectedCategory.value = category;
      fetchTopHeadlines(category: category);
    }
  }

  Future<void> searchNews(String query) async {
    if (query.isEmpty) return;

    try {
      _isLoading.value = true;
      _error.value = '';

      final response = await _newsServices.searchNews(query: query);
      _articles.value = response.articles;
    } catch (e) {
      _error.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to search news: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      _isLoading.value = false;
    }
  }
}

// setter = mendefinisikan data
// getter = mendapatkan data