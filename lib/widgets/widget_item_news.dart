import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/pages/details_page.dart';

import '../models/top_head_line.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsPage(newsDetails: itemArticle)),
        );
      },
      child: SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: itemArticle.urlToImage??"",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                errorWidget: (context, url, error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_not_found.jpg',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  );
                },
                placeholder: (context, url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/img_placeholder.jpg',
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
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
                        fontSize: 18,
                      ),
                    ),
                  ),
                  itemArticle.author == null
                      ? Container()
                      : Text(
                    itemArticle.author??"",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey,
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
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: 16.0),
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: itemArticle.source!.name??""),
                        ),
                      ),
                      // Text(
                      //   overflow: TextOverflow.ellipsis,
                      //   softWrap: true,
                      //   itemArticle.source!.name??"",
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 16,
                      //   ),
                      // ),
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
