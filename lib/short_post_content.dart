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
    return Container(
      width: 600,
      height: 97,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400
              ),
              children: [
                TextSpan(
                  text: '1 day ago - ',
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
                )
              ],
            ),
          ),

          Text(data['tags'][0])
          // Text(timeString),
        ],
      ),
    );
  }

  Widget contentList;

  // Initializer
  @override
  void initState() {
    contentList = Container(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: firestoreInstance.collection("posts").snapshots(),
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
          // Container(
          //   child:
          // new Stack(
          //   children: [
          // Positioned(
          // child
        ],
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(
        //   child:
        Container(
          width: contentWidth,
          // color: Colors.red,
          // child: Container(
          // width: 652,
          height: 500,
          child: Container(
            // color: Colors.grey,
            padding: EdgeInsets.fromLTRB(180, 0, 0, 0),
            height: 500,
            child: contentList,
          ),
        ),
        // ),
        // ),
      ],
    );
  }
}
