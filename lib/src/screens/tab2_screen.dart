import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/widgets/new_list.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const _ListCategories(),
            Expanded(
                child: NewList(news: newsService.getSelectedCategoryArticles))
          ],
        ),
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {
  const _ListCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final name = categories[index].name;
          return SizedBox(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  _CategoryButton(category: categories[index]),
                  const SizedBox(
                    height: 5,
                  ),
                  Text('${name[0].toUpperCase()}${name.substring(1)}'),
                ])),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final CategoryModel category;
  const _CategoryButton({
    super.key,
    required this.category,
  });
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context, listen: false);
    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == category.name)
              ? Colors.red
              : Colors.black54,
        ),
      ),
    );
  }
}
