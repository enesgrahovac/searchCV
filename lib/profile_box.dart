import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'global_vars.dart';
import 'dart:html' as html;

class ProfileBox extends StatefulWidget {
  ProfileBox({
    Key key,
  }) : super(key: key);

  @override
  _ProfileBoxState createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  Image selfieFiller = Image.network(
    firestoreURL + "unselected_profile.svg?alt=media",
  );

  Container _createImagePreviews() {
    Container _getImage(width, height) {
      print(width);
      print(height);
      return Container(
        width: width,
        height: (height > 0) ? height : null,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            border: Border.all(
              color: Color.fromRGBO(223, 225, 229, 1),
              width: 1,
            ),
            image:
                DecorationImage(image: selfieFiller.image, fit: BoxFit.cover)),
      );
    }

    return Container(
      height: 111,
      width: profileBoxWidth,
      // color: Colors.yellow,
      child: Row(children: [
        _getImage(profileBoxWidth / 2, 0),
        Column(
          children: [
            Row(children: [
              _getImage(profileBoxWidth / 4 + 17, 111 / 2),
              // color: Colors.green,
              _getImage(profileBoxWidth / 4 - 23, 111 / 2),
            ]),
            Row(children: [
              _getImage(profileBoxWidth / 4 - 23, 111 / 2),
              _getImage(profileBoxWidth / 4 + 17, 111 / 2),
            ]),
          ],
        )
      ]),
    );
  }

  Container _nameAndTitle() {
    return Container(
      height: 90,
      width: profileBoxWidth,
      padding: EdgeInsets.fromLTRB(15, 12, 15, 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Color.fromRGBO(223, 225, 229, 1),
            width: 1,
          ),
          bottom: BorderSide(
            color: Color.fromRGBO(223, 225, 229, 1),
            width: 1,
          ),
        ),
      ),
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // Name
            "Enes Grahovac",
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(222, 0, 0, 0),
              fontFamily: "Roboto",
            ),
          ),
          Container(
            // Title
            child: Text(
              "Engineer",
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 14,
                color: Color.fromRGBO(112, 117, 112, 1),
              ),
            ),
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
          ),
        ],
      ),
    );
  }

  Container _shortDescription() {
    return Container(
      height: 90,
      width: profileBoxWidth,
      padding: EdgeInsets.fromLTRB(15, 13, 15, 13),
      child:Text("WORDSF DJFLSDJFLJKSDFLKJSDL JSDLF JDSL FJ K adfkjasd lfjksadf kjasd fjasd lfkjsda jflsadkjflasdjkf l ajs;lj fs", style: TextStyle(color:Color.fromRGBO(34, 34, 34, 1))));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // double contentWidth = width * contentWidthFactor;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: profileBoxWidth,
            height: 600,
            // color: Hexcolor(googleWhite),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Color.fromRGBO(223, 225, 229, 1),
                width: 1,
              ),
              color: Hexcolor(googleWhite),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _createImagePreviews(),
                _nameAndTitle(),
                Container(
                  height: 250,
                  width: profileBoxWidth,
                  // color: Colors.blue,
                  child: Column(
                    children: [
                      _shortDescription(),
                      Text("BIRTHDAY"),
                      Text("HEIGHT"),
                      Text("EDUCATION"),
                    ],
                  ),
                ),
                Container(
                  height: 91,
                  child: Text("PROFILES"),
                ),
              ],
            )),
        Container(
          width: width - contentWidth - profileBoxWidth,
          // color: Colors.blue,
        ),
      ],
    );
  }
}
