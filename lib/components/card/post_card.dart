import 'package:cloud_9_client/api/api.dart';
import 'package:cloud_9_client/models/post.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/post_provider.dart';

import 'package:cloud_9_client/screens/comments_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

typedef PostCardOnTap = Function();

class PostCard extends StatefulWidget {
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
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  final FocusNode _bodyFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
        final _postProvider = Provider.of<PostProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.post.user.profile.avatar),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(widget.post.user.profile.fullname)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            widget.post.image != null
                ? Image.network( widget.post.image,
                    fit: BoxFit.cover,
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.post.body,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
            FlatButton(onPressed: (){
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentsPage(
                                          post: widget.post,
                                        )));
            }, child: Text('More...')),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                InkWell(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Icon(
                        Icons.chat,
                        color: widget.post.comments.length > 0
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                    onTap: () => widget.post.comments.length > 0
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentsPage(
                                      post: widget.post,
                                    )))
                        : null),
                SizedBox(width: 10),
                InkWell(
                    child: Icon(
                      Icons.share,
                      color: Colors.blue,
                    ),
                    onTap: () {
                     // Share.share('download our app on https://www.e-kilimo.co.tz/', subject: 'E-Kilimo jifunze kuhusu'+  widget.post.title);
                    })
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: widget.post.comments.length > 0
                      ? InkWell(
                          child: Text(
                            'View all ' +
                                widget.post.comments.length.toString() +
                                ' coments',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                color: Colors.black54),
                          ),
                          onTap: () {
                            print('comments');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommentsPage(
                                          post: widget.post,
                                        )));
                          },
                        )
                      : Container(),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            Row(
              children: <Widget>[
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      focusNode: _bodyFocusNode,
                      controller: _bodyController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please add text';
                        } else
                          return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Add a comment'),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _postProvider
                            .createComment(
                                body: _bodyController.text,
                                userId: _authProvider.authenticatedUser.id,
                                postId: widget.post.id)
                            .then((value) {
                          if (!value) {
                            _bodyController.clear();
                          }
                        });
                      }
                    })
              ],
            )
          ]),
        ),
      ),
    );
  }
}
