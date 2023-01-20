import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'item_news.dart';

class WidgetItemNews extends StatelessWidget {
  final Articles itemArticle;
  final String strPublishedAt;

  WidgetItemNews({
    required this.itemArticle,
    required this.strPublishedAt,
  });

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context);
    return GestureDetector(
      onTap: () async {
        // if (await canLaunch(itemArticle.url)) {
        //   await launch(itemArticle.url);
        // } else {
        //   Scaffold.of(context).showSnackBar(SnackBar(
        //     content: Text('Couldn\'t open detail news'),
        //   ));
        // }
      },
      child: SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: itemArticle.urlToImage??"",
                fit: BoxFit.cover,
                width: 200,
                height: 200,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_placeholder.jpg',
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      itemArticle.title??"",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 36,
                      ),
                    ),
                  ),
                  itemArticle.author == null
                      ? Container()
                      : Text(
                    itemArticle.author??"",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 28,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        strPublishedAt,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        itemArticle.source!.name??"",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
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
}
