import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_flutter/models/top_head_line.dart';

import '../db/db_helper.dart';

class DetailsPage extends StatefulWidget {

  final Articles? newsDetails;


  DetailsPage({required this.newsDetails});

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  bool isFollowing = false;
  bool isBookmark = false;
  bool isDarkTheme = false;
  String title = "";
  @override
  void initState() {
    super.initState();
    init();
    title = widget.newsDetails!.title??"";
    _getItem(title);
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }
  void _getItem(String title) async {
    final data = await SQLHelper.getItem(title);
    //print(data);
    if(data.length > 0){
      setState(() {
        isBookmark = true;
      });
    }else{
      setState(() {
        isBookmark = false;
      });
    }
  }
  Future<void> _addItem() async {

    await SQLHelper.createItem(
        widget.newsDetails!.source!.name??"",
        widget.newsDetails!.author??"",
        widget.newsDetails!.title??"",
        widget.newsDetails!.description??"",
        widget.newsDetails!.url??"",
        widget.newsDetails!.urlToImage??"",
        widget.newsDetails!.publishedAt??"",
        widget.newsDetails!.content??""
       );

    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text('Bookmark has been added.'),
    // ));
    setState(() {
      isBookmark = true;
    });
  }

  void _deleteItem(String title) async {
    await SQLHelper.deleteItem(title);
    setState(() {
      isBookmark = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                color: isDarkTheme ? null : Color(0xFFEFF5F5),
              ),
              SafeArea(
                child: Container(
                  color: isDarkTheme ? null : Color(0xFFEFF5F5),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Platform.isIOS
                                  ? Icons.arrow_back_ios
                                  : Icons.arrow_back,
                            ),
                          ),
                          SizedBox(width: 18),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("Detail", style: TextStyle(fontSize: 20),)
                                  ),
                                  IconButton(onPressed: ()=> isBookmark?_deleteItem(title):_addItem(), icon: isBookmark? Icon(Icons.bookmark):Icon(Icons.bookmark_outline)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${widget.newsDetails!.title}', style: TextStyle(fontSize: 24, fontWeight:FontWeight.w500 )),
                                // Text('${widget.newsDetails!.title}', style: TextStyle(fontSize: 20)),
                                SizedBox(
                                  child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${widget.newsDetails!.title}',
                                      //overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    widget.newsDetails!.author == null
                                        ? Container()
                                        : Text(
                                      '${widget.newsDetails!.author}',
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
                                          '${widget.newsDetails!.publishedAt}',
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
                                                text: '${widget.newsDetails!.source!.name}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ),

                                SizedBox(height: 16,),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.newsDetails!.urlToImage??"",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                    errorWidget: (context, url, error) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          'assets/images/img_not_found.jpg',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
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
                                          width: 100,
                                          height: 200,
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(height: 16,),
                                // ListTile(
                                //   contentPadding: EdgeInsets.all(0),
                                //   title: Text('by Jones Hawkins', style: boldTextStyle()),
                                //   subtitle: Text('12 jan 2021', style: secondaryTextStyle()),
                                //   leading: CircleAvatar(backgroundImage: AssetImage(NBProfileImage)),
                                //   trailing: AppButton(
                                //     elevation: 0,
                                //     text: isFollowing ? 'Following' : 'Follow',
                                //     onTap: () {
                                //       setState(
                                //             () {
                                //           isFollowing = !isFollowing;
                                //         },
                                //       );
                                //     },
                                //     color: isFollowing ? grey.withOpacity(0.2) : black,
                                //     textColor: isFollowing ? grey : white,
                                //   ).cornerRadiusWithClipRRect(30),
                                // ),
                                // SizedBox(height: 16,)
                                Text('${widget.newsDetails!.content}', style:TextStyle(fontSize: 16), textAlign: TextAlign.justify),
                                SizedBox(height: 16,)

                              ],
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
