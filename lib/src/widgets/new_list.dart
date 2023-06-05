import 'package:flutter/material.dart';
import 'package:news_app/src/theme/theme.dart';

import '../models/news_models.dart';

class NewList extends StatelessWidget {
  final List<Article> news;
  const NewList({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return _New(
          news: news[index],
          index: index,
        );
      },
      itemCount: news.length,
    );
  }
}

class _New extends StatelessWidget {
  final Article news;
  final int index;
  const _New({
    super.key,
    required this.news,
    required this.index,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Head(index: index, news: news),
        _Title(news: news),
        _Cover(news: news),
        _Description(news: news),
        const _BotonCard(),
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }
}

class _BotonCard extends StatelessWidget {
  const _BotonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.hintColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.star_border),
          ),
          const SizedBox(width: 10,),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    super.key,
    required this.news,
  });

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(news.description),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({
    super.key,
    required this.news,
  });

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        child: Container(
          child: (news.urlToImage.isEmpty)
              ? const Image(image: AssetImage('assets/img/no-image.png'))
              : FadeInImage(
                  image: NetworkImage(news.urlToImage),
                  placeholder: const AssetImage('assets/img/giphy.gif'),
                ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    super.key,
    required this.news,
  });

  final Article news;

  @override
  Widget build(BuildContext context) {
    return Text(
      news.title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class _Head extends StatelessWidget {
  const _Head({
    super.key,
    required this.index,
    required this.news,
  });

  final int index;
  final Article news;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}',
            style: TextStyle(color: myTheme.hintColor),
          ),
          Text('${news.source.name}')
        ],
      ),
    );
  }
}
