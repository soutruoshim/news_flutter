import 'package:flutter/material.dart';
import 'package:news_flutter/logics/news_logic.dart';
import 'package:provider/provider.dart';
import '../contants/category_list_constant.dart';
import '../models/category.dart';
import '../models/top_head_line.dart';
import '../widgets/widget_item_news.dart';
import 'search_page.dart';
import 'package:intl/intl.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool isDarkMode = false;
  var indexCategorySelected = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: isDarkMode ? null : Color(0xFFEFF5F5),
        ),
        SafeArea(
          child: Container(
            width: double.infinity,
            color: isDarkMode ? null : Color(0xFFEFF5F5),
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _header(context),
                WidgetDateToday(),
                SizedBox(height: 24),
                WidgetCategoryNews(
                    listCategories: listCategories,
                    indexDefaultSelected: indexCategorySelected),
                SizedBox(height: 24),
                Expanded(
                  child: _buildWidgetContentNewsAndroid(context)
                ),
              ],
            ),
          ),
        ),
      ],
    )));
  }
}

Widget _header(BuildContext context){
  return  Padding(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Enterprise News',
            style: TextStyle(
              fontSize: 28,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SearchPage()),
            );
          },
          child: Hero(
            tag: 'iconSearch',
            child: Icon(
              Icons.search,
              size: 36,
            ),
          ),
        ),
      ],
    ),
  );
}
class WidgetCategoryNews extends StatefulWidget {
  final List<CategoryNewsModel> listCategories;
  final int indexDefaultSelected;

  WidgetCategoryNews({
    required this.listCategories,
    required this.indexDefaultSelected,
  });

  @override
  _WidgetCategoryNewsState createState() => _WidgetCategoryNewsState();
}

class _WidgetCategoryNewsState extends State<WidgetCategoryNews> {
  int indexCategorySelected=0;

  @override
  void initState() {
    indexCategorySelected = widget.indexDefaultSelected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var itemCategory = widget.listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 6,
              right: index == widget.listCategories.length - 1 ? 0 : 6,
            ),
            child: GestureDetector(
              onTap: () {
                if (indexCategorySelected == index) {
                  return;
                }
                setState(() => indexCategorySelected = index);
                // var topHeadlinesNewsBloc = BlocProvider.of<TopHeadlinesNewsBloc>(context);
                // topHeadlinesNewsBloc.add(
                //   ChangeCategoryTopHeadlinesNewsEvent(indexCategorySelected: index),
                // );
              },
              child: Container(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: itemCategory.title.toLowerCase() == 'all' ? 48 : 32,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(indexCategorySelected == index ? 0.2 : 0.6),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                    border: indexCategorySelected == index
                        ? Border.all(
                      color: Colors.white,
                      width: 2.0,
                    )
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      itemCategory.title,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  color: itemCategory.title!.toLowerCase() == 'all' ? Color(0xFFBBCDDC) : null,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                  image: itemCategory.title!.toLowerCase() == 'all'
                      ? null
                      : DecorationImage(
                    image: AssetImage(
                      itemCategory.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: widget.listCategories.length,
      ),
    );
  }
}

Widget _buildWidgetContentNewsAndroid(BuildContext context) {

     String? error = context.watch<NewsLogic>().error;
     if(error != null){
       debugPrint("Error: $error");
       return Center(child: Text("Something went wrong"),);
     }

     TopHeadlineNews? data = context.watch<NewsLogic>().topHeadlineNews;
     if(data == null){
       return SizedBox();
     }

     return Stack(
        children: <Widget>[
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              var itemArticle = data.articles![index];
              var dateTimePublishedAt = DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(itemArticle.publishedAt??"", true);
              var strPublishedAt = DateFormat('MMM dd, yyyy HH:mm').format(dateTimePublishedAt);
              if (index == 0) {
                return _buildWidgetItemLatestNews(itemArticle, strPublishedAt);
              } else {
                return _buildWidgetItemNews(index, itemArticle, strPublishedAt);
              }
            },
            itemCount: data.articles!.length,
          )
        ],
     );
}

Widget _buildWidgetItemNews(
    int index,
    Articles itemArticle,
    String strPublishedAt,
    ) {
  return Padding(
    padding: EdgeInsets.only(
      top: index == 1 ? 32 : 16,
      bottom: 16,
    ),
    child: WidgetItemNews(
      itemArticle: itemArticle,
      strPublishedAt: strPublishedAt,
    ),
  );
}

Widget _buildWidgetItemLatestNews(
    Articles itemArticle,
    String strPublishedAt,
    ) {
  return GestureDetector(
    // onTap: () async {
    //   if (await canLaunch(itemArticle.url)) {
    //     await launch(itemArticle.url);
    //   } else {
    //     Scaffold.of(context).showSnackBar(SnackBar(
    //       content: Text('Couldn\'t open detail news'),
    //     ));
    //   }
    // },
    child: Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(
            itemArticle.urlToImage??"",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black,
                  Colors.black.withOpacity(0.0),
                ],
                stops: [
                  0.0,
                  1.0,
                ],
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(48),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  child: Text(
                    'Latest News',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  itemArticle.title??"",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      strPublishedAt,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      ' | ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      itemArticle.source!.name??"",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
class WidgetDateToday extends StatefulWidget {
  @override
  _WidgetDateTodayState createState() => _WidgetDateTodayState();
}

class _WidgetDateTodayState extends State<WidgetDateToday> {
  String strToday = "";

  @override
  void initState() {
    strToday = DateFormat('EEEE, MMM dd, yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        strToday,
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
      ),
    );
  }
}

