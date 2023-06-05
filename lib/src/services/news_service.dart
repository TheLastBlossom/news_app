import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService with ChangeNotifier {
  final _URL_NEWS = 'https://newsapi.org/v2';
  final _APIKEY = '924368fdb2ea474c9435b57da79d3cc6';
  final _COUNTRY = 'mx';
  String _selectedCategory = 'business';
  List<Article> headLines = [];
  List<CategoryModel> categories = [
    CategoryModel(FontAwesomeIcons.building, 'business'),
    CategoryModel(FontAwesomeIcons.tv, 'entertainment'),
    CategoryModel(FontAwesomeIcons.addressCard, 'general'),
    CategoryModel(FontAwesomeIcons.headSideVirus, 'health'),
    CategoryModel(FontAwesomeIcons.vials, 'science'),
    CategoryModel(FontAwesomeIcons.volleyball, 'sports'),
    CategoryModel(FontAwesomeIcons.memory, 'technology'),
  ];
  Map<String, List<Article>> categoryArticles = {};
  NewsService() {
    getTopHeadLines();
    for (var element in categories) {
      categoryArticles[element.name] = [];
    }
    getArticlesByCategory(_selectedCategory);
  }
  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    getArticlesByCategory(value);
    notifyListeners();
  }

  List<Article> get getSelectedCategoryArticles =>
      categoryArticles[selectedCategory]!;
  getTopHeadLines() async {
    final url =
        Uri.parse('$_URL_NEWS/top-headlines?country=$_COUNTRY&apiKey=$_APIKEY');
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(jsonDecode(resp.body));
    headLines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (categoryArticles[category]!.isNotEmpty ) {
      return categoryArticles[category];
    }
    final url = Uri.parse(
        '$_URL_NEWS/top-headlines?country=$_COUNTRY&apiKey=$_APIKEY&category=$category');
    final resp = await http.get(url);
    final newsResponse = NewsResponse.fromJson(jsonDecode(resp.body));
    categoryArticles[category]?.addAll(newsResponse.articles);
    notifyListeners();
  }
}
