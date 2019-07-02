import 'package:flutter_web/material.dart';
import 'package:kakaton/models/comment.dart';
import 'package:intl/intl.dart';

class CommentsList extends StatelessWidget {
  CommentsList(this.comments);
  
  final List<Comment> comments;
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 350,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Card(
                  child: InkWell(
                    child: Container(
                      width: 100,
                      height: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                                "Date: ${DateFormat('yyyy-MM-dd kk:mm').format(comments[index].dateTime)}"),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text(
                                "Email: ${comments[index].authorEmail}"),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 5.0, bottom: 10.0),
                            child: Text(
                                "${comments[index].description}"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}