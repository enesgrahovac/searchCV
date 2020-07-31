import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'global_vars.dart';
import 'dart:html' as html;

class SearchResultsBar extends StatelessWidget {
  SearchResultsBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: resultBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(

              padding: EdgeInsets.fromLTRB(180, 0, 0, 0),
              child: Text(
                "About 1,550,000,000 results (0.51 seconds)",
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(112, 117, 122, 1),
                  fontFamily: googleSearchFont,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
