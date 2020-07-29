import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'global_vars.dart';
import 'dart:html' as html;

class SearchControlBar extends StatefulWidget {
  SearchControlBar({
    Key key,
  }) : super(key: key);

  @override
  _SearchControlBarState createState() => _SearchControlBarState();
}

class _SearchControlBarState extends State<SearchControlBar> {

  List icons = ["All", "Images", "News", "Books", "Videos", "More"];

  Map imagePaths = imageNames;

  Map<String, Image> cacheImages = {};

  List<Widget> allIcons = [];

  _createIcon(iconName, selected) {
    bool isHovered = false;
    Color textColor = (selected)
        ? Color.fromRGBO(26, 115, 232, 1)
        : Color.fromRGBO(95, 99, 104, 1);
    return MouseRegion(
      onHover: (event) {
        // setState(() {
          // print(event);
          textColor = Color.fromRGBO(26, 115, 232, 1);
        // }); 
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            allIcons = _buildBar(iconName);
          });
        },
        child: Container(
          decoration: (selected)
              ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Hexcolor("#1a73e8"),
                      width: 3,
                    ),
                  ),
                  color: Hexcolor(googleWhite),
                )
              : null,
          // color:"#1a73e8",
          padding: EdgeInsets.fromLTRB(10, 16, 12, 16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: (selected)
                    ? cacheImages[iconName]
                    : cacheImages["unselected_" + iconName],
              ),
              Text(
                iconName,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBar(selectedIcon) {
    print(selectedIcon);
    return [
      Container(
          width: searchControlBarWidth, //1363
          color: Hexcolor(
            googleWhite,
          ),
          child: Row(
            children: [
              Container(
                width: 169,
                // color: Colors.black,
              ),
              _createIcon("All", selectedIcon == "All"),
              _createIcon("Images", selectedIcon == "Images"),
              _createIcon("News", selectedIcon == "News"),
              _createIcon("Books", selectedIcon == "Books"),
              _createIcon("Videos", selectedIcon == "Videos"),
              _createIcon("More", selectedIcon == "More")
            ],
          )),
      Expanded(
        child: Container(
            // color: Colors.yellow,
            ),
      ),
    ];
  }

  /// Did Change Dependencies
  @override
  void didChangeDependencies() {
    // Initialization
    for (var i = 0; i < icons.length; i++) {
      String iconName = icons[i];
      Image image = Image.network(
        firestoreURL + imagePaths[iconName],
        width: 24,
        height: 24,
      );
      Image unselectedImage = Image.network(
        firestoreURL + imagePaths["unselected_" + iconName],
        width: 24,
        height: 24,
      );
      // cacheImages.update(iconName, (value) => image);
      cacheImages[iconName] = image;
      cacheImages["unselected_" + iconName] = unselectedImage;

      precacheImage(image.image, context);
      precacheImage(unselectedImage.image, context);
    }
    print("DONE");
    allIcons = _buildBar("All");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: topicToolbar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: allIcons,
      ),
    );
  }
}
