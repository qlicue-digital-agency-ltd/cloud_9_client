import 'package:cloud_9_client/models/post.dart';
import 'package:flutter/material.dart';

typedef PostCardOnTap = Function();

class PostCard extends StatelessWidget {
  final PostCardOnTap onShare;
  final PostCardOnTap onLike;
  final Post post;

  const PostCard(
      {Key key,
      @required this.onShare,
      @required this.onLike,
      @required this.post})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Stack(
      children: <Widget>[
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 400,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          post.image,
                        ),
                        fit: BoxFit.cover)),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  post.body,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  maxLines: 3,
                ),
              ),
              Spacer(),
              Row(children: [
                IconButton(
                  onPressed: onLike,
                  icon: Icon(Icons.favorite),
                ),
                IconButton(
                  onPressed: onShare,
                  icon: Icon(Icons.share),
                ),
                Spacer(),
              ])
            ]),
          ),
        ),
      ],
    ));
  }
}
