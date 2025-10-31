import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartpress_app/controllers/news_controller.dart';
import 'package:smartpress_app/home/components/empty_state.dart';
import 'package:smartpress_app/home/components/error_state.dart';
import 'package:smartpress_app/routes/app_pages.dart';
import 'package:smartpress_app/widgets/category_chip.dart';
import 'package:smartpress_app/widgets/loading_shimmer.dart';
import 'package:smartpress_app/widgets/news_card.dart';

class HomeScreen extends GetView<NewsController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Image.asset(
            'asset/image/logo-news.png',
            height: 45,
          ),
        ),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () => showSearchDialog(context),
        //   ),
        // ],
      ),

      // body
      body: Column(
        children: [
          // search bar di bawah appbar
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  controller.searchNews(value);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search news...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic_none),
                  onPressed: () => showSearchDialog(context),
                ),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.2),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // kategori
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                return Obx(() => CategoryChip(
                      label: category,
                      isSelected: controller.selectedCategory == category,
                      onTap: () => controller.selectCategory(category),
                    ));
              },
            ),
          ),

          // list berita
          Expanded(
            child: Obx(() {
              if (controller.isLoading) return LoadingShimmer();
              if (controller.articles.isEmpty) return EmptyStateWidget();
              if (controller.error.isNotEmpty) return ErrorStateWidget(onRetry: controller.refreshNews);

              return RefreshIndicator(
                onRefresh: controller.refreshNews,
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: controller.articles.length,
                  itemBuilder: (context, index) {
                    final article = controller.articles[index];
                    return NewsCard(
                      article: article,
                      onTap: () => Get.toNamed(Routes.NEWS_DETAIL, arguments: article),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  void showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search News'),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Please type a news...',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                controller.searchNews(value);
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (searchController.text.isNotEmpty) {
                  controller.searchNews(searchController.text);
                  Navigator.pop(context);
                }
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
