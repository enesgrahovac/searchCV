import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'global_vars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShortPostContent extends StatefulWidget {
  const ShortPostContent({
    Key key,
  }) : super(key: key);

  @override
  _ShortPostContentState createState() => _ShortPostContentState();
}

class _ShortPostContentState extends State<ShortPostContent> {
  final firestoreInstance = Firestore.instance;

  Widget _buildCard(doc) {
    var data = doc.data;
    DateTime today = DateTime.now();
    // Timestamp today = Timestamp.now();

    DateTime timePosted = data['date'].toDate();
    Duration timeDifference = timePosted.difference(today);
    String timeDifferenceDisplay;
    if (timeDifference.inDays < -1) {
      timeDifferenceDisplay = "${-1 * timeDifference.inDays} days ago - ";
    } else if (timeDifference.inDays == -1) {
      timeDifferenceDisplay = "1 day ago - ";
    } else {
      timeDifferenceDisplay = "today - ";
    }
    var tags = data['tags'];
    List<Widget> tagList = [];
    if (tags != null) {
      print(tags);
      tags.forEach((element) => {tagList.add(Text(element))});
      print(tagList);
    }
    return Container(
      width: 600,
      // height: 97, // Should be 97 as on the google site
      // height: 1200,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (data["title"] != null)
              ? Text(data["title"],
                  // data['project'],
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Color.fromRGBO(23, 13, 171, 1),
                      fontSize: 20))
              : Container(),

          // For project path
          (data["projectPath"] != null)
              ? Container(
                  padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text(data['projectPath'],
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(0, 102, 33, 1),
                          fontSize: 16)))
              : Container(),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontFamily: 'Roboto', fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: timeDifferenceDisplay,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(112, 117, 122, 1),
                      fontFamily: "Roboto",
                    ),
                  ),
                  TextSpan(
                    text: data['description'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromRGBO(77, 81, 86, 1),
                      fontFamily: "Roboto",
                    ),
                  ),
                ],
              ),
            ),
          ),
          (tags != null) ? Row(children: tagList) : Container(), // Where Tags are displayed
          // Text(timeString),
        ],
      ),
    );
  }

  Widget contentList;

  // Initializer
  @override
  void initState() {
    contentList = ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: firestoreInstance
              .collection("posts")
              .orderBy("date", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: snapshot.data.documents
                      .map<Widget>((doc) => _buildCard(doc))
                      .toList());
            } else {
              return SizedBox();
            }
          },
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        // Expanded(
        //   child:
        Container(
          width: contentWidth,
          // color: Colors.red,
          // child: Container(
          // width: 652,
          height: height -
              resultBar -
              topicToolbar -
              searchBarHeight -
              2 * searchBarPadding,
          child: Container(
            // color: Colors.grey,
            padding: EdgeInsets.fromLTRB(180, 0, 0, 0),
            // height: 100,
            child: contentList,
          ),
        ),
        // ),
        // ),
      ],
    );
  }
}
