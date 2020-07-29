import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'global_vars.dart' as globals;

class SearchControlBar extends StatefulWidget {
  SearchControlBar({
    Key key,
  }) : super(key: key);

  @override
  _SearchControlBarState createState() => _SearchControlBarState();
}

class _SearchControlBarState extends State<SearchControlBar> {
  double topicToolabr = globals.topicToolbar;

  double searchControlBarWidth = globals.searchControlBarWidth;

  String googleWhite = globals.googleWhite;

  String firestoreURL = globals.firestoreURL;

  List icons = ["All", "Images", "News", "Books", "Videos", "More"];

  Map imagePaths = globals.imageNames;

  Map<String, Image> cacheImages = {};

  List<Widget> allIcons = [];

  _createIcon(iconName, selected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          allIcons = _buildBar(iconName);
        });
      },
      child: Container(
        decoration: (selected)?BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Hexcolor("#1a73e8"),
              width: 3,
            ),
          ),
          color: Hexcolor(googleWhite),
        ):null,
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
            Text(iconName),
          ],
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

  // Initializer
  // @override
  // void initState() {

  //   for (var i = 0; i < icons.length; i++) {
  //     String iconName = icons[i];
  //     Image image = Image.network(
  //       firestoreURL + imagePaths[iconName],
  //       width: 24,
  //       height: 24,
  //     );
  //     Image unselectedImage = Image.network(
  //       firestoreURL + imagePaths["unselected_" + iconName],
  //       width: 24,
  //       height: 24,
  //     );
  //     // cacheImages.update(iconName, (value) => image);
  //     cacheImages[iconName] = image;
  //     cacheImages["unselected_" + iconName] = unselectedImage;
  //     print("All good");
  //     precacheImage(image.image,context);
  //     precacheImage(unselectedImage.image,context);
  //     print("works");

  //   }
  //   allIcons = _buildBar("All");

  //   // searchFocused = false; // Used for a focused search bar
  //   super.initState();
  // }

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
      height: topicToolabr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: allIcons,
      ),
    );
  }
}
