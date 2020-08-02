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
    print("DATA IN CONTENT PAGE");
    print(data);
    return Row(
      children: [
        Container(
          width: 600,
          height: 97,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
          child: Column(
            children: [
              Text(data['description']),
              // Text(timeString),
            ],
          ),
        ),
        // Expanded(
        //   child: Column(
        //     children: [
        //       AutoSizeText(
        //         data["company_name"],
        //         style: TextStyle(fontSize: 12.0),
        //         maxLines: 1,
        //       ),
        //       // Text(data["company_name"]),
        //     ],
        //   ),
        // ),
      ],
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
