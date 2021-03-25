import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_9_client/models/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'media_preview_page.dart';

class MediaPreviewListPage extends StatefulWidget {
  final List<ServiceImage> media;

  const MediaPreviewListPage({Key key, @required this.media}) : super(key: key);

  @override
  _MediaPreviewListPageState createState() => _MediaPreviewListPageState();
}

class _MediaPreviewListPageState extends State<MediaPreviewListPage> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(''),
        actions: [
          IconButton(icon: Icon(Icons.star_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: widget.media
                  .map(
                    (image) => InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => MediaPreviewPage(
                                    media: image,
                                  ))),
                      child: CachedNetworkImage(

                        imageUrl: image.url,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                         // height: double.infinity,
                        // width: MediaQuery.of(context).size.width,
                         //fit: BoxFit.fitHeight,


                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: double.maxFinite,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                autoPlay: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                    // print("${_current}");
                  });
                },
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.media
                    .asMap()
                    .map(
                      (index, image) => MapEntry(
                        index,
                        Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentPage == index
                                  ? Color.fromRGBO(0, 0, 0, 0.9)
                                  : Color.fromRGBO(0, 0, 0, 0.4)),
                          // child: Text('$_currentPage/${widget.media.length}',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    )
                    .values
                    .toList()),
          ),
        ],
      ),
    );
  }
}
/*


ListView.builder(
              itemCount: media.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MediaPreviewPage(
                                  media: media[index],
                                ))),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Hero(
                        tag: media[index].url,
                        child:  CachedNetworkImage(
                          imageUrl: media[index].url,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              Center(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(value: downloadProgress.progress),
                              )),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                          // height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
                        ),
                        // child: Image.network(media[index].url),
                      ),
                    ),
                  ))

 */

