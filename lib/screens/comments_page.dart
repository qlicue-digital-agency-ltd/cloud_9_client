import 'package:cloud_9_client/models/post.dart';
import 'package:cloud_9_client/provider/auth_provider.dart';
import 'package:cloud_9_client/provider/post_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  final Post post;

  CommentsPage({Key key, @required this.post}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final FocusNode _bodyFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    final _postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              widget.post.image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    widget.post.body,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Comments:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          )
        ])),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage('profile/avatar/' +
                                widget.post.comments[index].user.profile
                                    .toString()),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: widget.post.comments[index].user.profile
                                      .fullname,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: '\t' +
                                          widget.post.comments[index].body,
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                    ),
                                    TextSpan(
                                      text: '\n\n' +
                                          widget.post.comments[index].time,
                                      style: TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                    ),
                                    TextSpan(
                                        text: '\t',
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 18),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('object');
                                          })
                                  ]),
                            ),
                          )
                        ]),
                  ],
                ),
              );
            },
            childCount: widget.post.comments.length,
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
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
                  tooltip: 'Send',
                  icon: Icon(
                    Icons.send,
                    color: Colors.green,
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
          ),
        ),
      ),
    );
  }
}
