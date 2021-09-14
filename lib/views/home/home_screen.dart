import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/core/models/article.dart';
import 'package:news_app/views/_widgets/article_card.dart';
import 'package:news_app/views/_widgets/article_list_tile.dart';
import 'package:news_app/views/_widgets/listenable_builder.dart';
import 'package:news_app/views/home/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeState homeState = HomeState();

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_tryLoadMore);
    homeState.loadHeadline().then((_) => homeState.loadLatestNews());
  }

  @override
  void dispose() {
    homeState.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _tryLoadMore() {
    if (!scrollController.hasClients) {
      return;
    }
    if (scrollController.offset >= scrollController.position.maxScrollExtent - 80 &&
        scrollController.position.userScrollDirection == ScrollDirection.reverse &&
        !homeState.isBusy) {
      homeState.loadLatestNews(more: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: ListenableBuilder<HomeState>(
        listenable: homeState,
        builder: (BuildContext context, HomeState state) {
          if (state.isBusy && state.headlines.isEmpty) {
            return const Center(child: CupertinoActivityIndicator());
          }
          return _HomeScreenListView(
            scrollController: scrollController,
            onRefresh: state.loadLatestNews,
            headlines: state.headlines,
            latestNews: state.latestNews,
            isLoading: state.isBusy,
          );
        },
      ),
    );
  }
}

class _HomeScreenListView extends StatelessWidget {
  const _HomeScreenListView({
    Key? key,
    required this.scrollController,
    required this.onRefresh,
    required this.headlines,
    required this.latestNews,
    required this.isLoading,
  }) : super(key: key);

  final ScrollController scrollController;
  final List<Article> headlines;
  final List<Article> latestNews;
  final Future<void> Function() onRefresh;
  final bool isLoading;

  Article get bigHeadline => headlines.first;

  List<Article> get smallHeadlines {
    final List<Article> articles = <Article>[];

    for (int i = 1; i < headlines.length; i++) {
      articles.add(headlines[i]);
    }
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      controller: scrollController,
      slivers: <Widget>[
        CupertinoSliverRefreshControl(
          onRefresh: onRefresh,
        ),
        if (headlines.isNotEmpty)
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ArticleCard(article: bigHeadline),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        if (headlines.isNotEmpty)
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: smallHeadlines.map<Widget>((Article h) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: ArticleCard(article: h),
                );
              }).toList(growable: false),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 5)),
        if (latestNews.isNotEmpty)
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ArticleListTile(article: latestNews[index]);
              },
              childCount: latestNews.length,

            ),
            itemExtent: 200,
          ),
        if (isLoading)
          const SliverToBoxAdapter(
            child: Center(child: CupertinoActivityIndicator()),
          ),
      ],
    );
  }
}
