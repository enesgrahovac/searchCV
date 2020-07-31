import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'search_controls_bar.dart';
import 'global_vars.dart';
import 'search_results_bar.dart';
import 'profile_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final firestoreInstance = Firestore.instance;
  static String googleRed = "#EA4335";
  static String googleGreen = "#34A853";
  static String googleBlue = "#4285F4";
  static String googleYellow = "#FBBC05";
  final List<String> googleColorPattern = [
    googleBlue,
    googleRed,
    googleYellow,
    googleBlue,
    googleGreen,
    googleRed
  ];
  static String googleMagifyingGlassColor = "#9aa0a6";

  static String googleCancelColor = '#80868b';

  static String googleWhite = "#fff"; // AKA white

  bool emptySearchBox = true;
  // bool searchFocused = false; // Used for a focused search bar

  static Widget magIcon = Image.network(
    // firestoreURL + "mag_icon.png?alt=media",
    firestoreURL + "magnify_special_handle.svg?alt=media",
    width: 20,
    height: 20,
    color: Hexcolor(googleMagifyingGlassColor),
  );

  static Widget cancelIcon = Image.network(
    // firestoreURL + "cancel_icon.png?alt=media",
    firestoreURL + "unselected_x.svg?alt=media",
    width: 20,
    height: 20,
    color: Hexcolor(googleCancelColor),
  );

  final searchInputController = TextEditingController();

  List<TextSpan> _googleizeName(name) {
    List<TextSpan> inputLetters = [];
    int patternIndex = 0;
    for (var i = 0; i < name.length; i++) {
      String letter = name[i];
      TextSpan letterStyle;
      if (letter != " ") {
        var stringColorInPattern = googleColorPattern[patternIndex % 6];
        letterStyle = TextSpan(
          text: letter,
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontFamily: 'ProductSans',
            color: Hexcolor(stringColorInPattern),
          ),
        );
        patternIndex += 1;
      } else {
        letterStyle = TextSpan(
          text: letter,
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontFamily: 'ProductSans',
          ),
        );
      }
      inputLetters.add(letterStyle);
    }
    return inputLetters;
  }

  static RichText googleName;

  void createGoogleLetters(name, {automated: false}) {
    if (name == "") {
      emptySearchBox = true;
      searchInputController.clear();
      FocusScope.of(context).unfocus();
      // searchFocused = false; // Used for a focused search bar

      return;
    }
    setState(() {
      if (automated == false) {
        emptySearchBox = false;
      }
      // return googleName;
    });
  }

  getUserData(CollectionReference user) async {
    var res = user.document('egrahovac');

    res.get().then(
          (data) => {print(data['name'])},
        );
  }

  getPosts() {
    firestoreInstance.collection('posts').getDocuments().then((querySnapshot) {
      querySnapshot.documents.forEach((result) {
        print(result.data);
      });
    });
  }

  // Initializer
  @override
  void initState() {
    googleName = RichText(
      // textAlign: TextAlign.end,
      text: TextSpan(
        style: TextStyle(
          fontSize: 90,
        ),
        children: _googleizeName("Enes\nGrahovac"),
      ),
    );
    emptySearchBox = true;
    var userData = firestoreInstance.collection('users');
    // firestoreInstance.collection('users').document("egrahovac").get();
    // firestoreInstance.collection('users').getDocuments().then((querySnapshot) {
    //   querySnapshot.documents.forEach((result) {
    //     print(result.data);
    //   });
    // });
    getUserData(userData);
    getPosts();
    // .then((data) => {
    //   printData(data)});
    // print(userData);

    // searchFocused = false; // Used for a focused search bar
    super.initState();
  }

  void focusSearch() {
    setState(() {
      // searchFocused = true;  // Used for a focused search bar
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // double contentWidth = width * contentWidthFactor;
    double searchbarWidth = 690.0 - 98; // width of search bar minus icons
    double searchBarHeight =
        50; // It is actually 46 pixels on google search apge
    double searchBarPadding = 20;

    Container searchBar = Container(
      height: searchBarHeight +
          2 * searchBarPadding, //Actually 46 on Googles Search page
      padding: EdgeInsets.fromLTRB(0, searchBarPadding, 0, searchBarPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: googleName,
            ),
          ),
          Container(
            width: 690,
            height: searchBarHeight,
            // foregroundDecoration: BoxDecoration(
            // color: Colors.white,
            // ),
            // Search Bar Searchbar
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(searchBarHeight / 2),
              border: Border.all(
                color: Hexcolor(googleSearchBorderColor),
                width: 1,
              ),
              color: Hexcolor(googleWhite),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: magIcon,
                  padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  // color: Colors.red,
                ),
                Container(
                  width: searchbarWidth,
                  child: TextField(
                    onTap: () {
                      focusSearch();
                      // print(FocusScope.of(context).isFirstFocus);
                    },
                    controller: searchInputController,
                    cursorColor: Colors.black,
                    cursorWidth: 1,
                    enableSuggestions: false,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: googleSearchFont,
                    ),
                    onChanged: (text) {
                      createGoogleLetters(text);
                      // Search for tags or projects
                    },
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  child: (emptySearchBox) // cancelIcon
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            createGoogleLetters("");
                            // Empty for now
                          },
                          child: Container(
                              child: cancelIcon,
                              padding: EdgeInsets.fromLTRB(14, 0, 0, 0)),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Widget searchControlBar = SearchControlBar();

    Widget searchResultsBar = SearchResultsBar();

    Widget profileBox = ProfileBox();

    Widget contentBuild = Column(
      children: [
        Expanded(
          child: Container(
            width: contentWidth,
            // color: Colors.red,
          ),
        ),
      ],
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          searchBar,
          searchControlBar,
          searchResultsBar,
          // SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          // child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height -
                    topicToolbar -
                    2 * searchBarPadding -
                    searchBarHeight -
                    resultBar,
                child: contentBuild,
              ),
              profileBox,
            ],
            // ),
          ),
        ],
      ),
    );
  }
}
