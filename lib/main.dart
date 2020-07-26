import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
  static String googleSearchBorderColor = "#dfe1e5";
  static String googleCancelColor = '#80868b';

  static String googleWhite = "#fff"; // AKA white

  static String googleSearchFont = 'Arial';

  bool emptySearchBox = true;
  // bool searchFocused = false; // Used for a focused search bar

  static String firestoreURL =
      "https://firebasestorage.googleapis.com/v0/b/searchme-1.appspot.com/o/";

  static Widget magIcon = Image.network(
    firestoreURL + "mag_icon.png?alt=media",
    width: 20,
    height: 20,
    color: Hexcolor(googleMagifyingGlassColor),
  );

  static Widget cancelIcon = Image.network(
    firestoreURL + "cancel_icon.png?alt=media",
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
    print(name);
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
    double contentWidth = width * .7;
    double searchbarWidth = 690.0 - 98; // width of search bar minus icons
    double searchBarHeight =
        50; // It is actually 46 pixels on google search apge

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 20,
          ),
          Container(
            height: searchBarHeight, //Actually 46 on Googles Search page
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
          ),
        ],
      ),
    );
  }
}
