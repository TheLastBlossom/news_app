import 'package:flutter/material.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/new_list.dart';
import 'package:provider/provider.dart';

import '../models/news_models.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    final newService = Provider.of<NewsService>(context);
    return Scaffold(
        // body: NewList(news: newService.headLines,)
        body: (newService.headLines.isEmpty)
            ? Center(
                child: CircularProgressIndicator(color: myTheme.hintColor),
              )
            : NewList(
                news: newService.headLines,
              ));
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
