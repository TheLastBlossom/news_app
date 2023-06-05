import 'package:flutter/material.dart';
import 'package:news_app/src/screens/screens.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return NewsService();
        },)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        theme: myTheme,
        home: const TabsPage(),
      ),
    );
  }
}