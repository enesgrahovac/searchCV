import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'global_vars.dart';
import 'dart:html' as html;
import 'dart:js' as js;

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

  Image selfie1 = Image.network(
    firestoreURL + "selfies%2Fpic1.jpg?alt=media",
  );

  Image selfie2 = Image.network(
    firestoreURL + "selfies%2Fpic2.JPG?alt=media",
  );

  Image selfie3 = Image.network(
    firestoreURL + "selfies%2Fpic3.jpg?alt=media",
  );

  Image selfie4 = Image.network(
    firestoreURL + "selfies%2Fpic4.JPG?alt=media",
  );

  Image selfie5 = Image.network(
    firestoreURL + "selfies%2Fpic5.jpg?alt=media",
  );

  Image twitterLogo = Image.network(
    firestoreURL + 'twitter.svg?alt=media',
    width: 32,
    height: 32,
  );
  Image linkedInLogo = Image.network(
    firestoreURL + 'linkedin.svg?alt=media',
    width: 32,
    height: 32,
  );
  Image githubLogo = Image.network(
    firestoreURL + 'github-image.svg?alt=media',
    width: 32,
    height: 32,
  );

  Map logoMap;
  Map linkMap;

  Container _createImagePreviews() {
    Container _getImage(width, height, imageselected) {
      return Container(
        width: width,
        height: (height > 0) ? height : null,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Color.fromRGBO(223, 225, 229, 1),
              width: 1,
            ),
            image:
                DecorationImage(image: imageselected.image, fit: BoxFit.cover,)),
      );
    }

    return Container(
      height: 111,
      width: profileBoxWidth,
      // color: Colors.yellow,
      child: Row(children: [
        _getImage(profileBoxWidth / 2, 0, selfie1),
        Column(
          children: [
            Row(children: [
              _getImage(profileBoxWidth / 4 + 17, 111 / 2, selfie2),
              // color: Colors.green,
              _getImage(profileBoxWidth / 4 - 19, 111 / 2, selfie3),
            ]),
            Row(children: [
              _getImage(profileBoxWidth / 4 - 19, 111 / 2, selfie4),
              _getImage(profileBoxWidth / 4 + 17, 111 / 2, selfie5),
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

  Widget _shortDescription() {
    return
        // Expanded(
        //   child:
        Container(
      // height: 90,
      width: profileBoxWidth,
      padding: EdgeInsets.fromLTRB(15, 13, 15, 13),
      child: Text(
        "Enes Grahovac, is an applied physics student at the University of Florida. He created this resume page to allow recruiters to search his resume on a live-updated platform. Type in anything in the search bar from \"Python,\" \"3D printing\" or even \"Cats\"!! Inspired by Google Search",
        style: TextStyle(
            color: Color.fromRGBO(34, 34, 34, 1),
            fontSize: 14,
            fontFamily: "Roboto"),
      ),
      // ),
    );
  }

  Widget _buildTextInformation(title, words) {
    return
        // Expanded(
        //   child:
        Container(
      width: profileBoxWidth,
      padding: EdgeInsets.fromLTRB(15, 7, 15, 0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
          ),
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
            TextSpan(
              text: words,
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  Widget _createOnlineProfileDisplay() {
    _makeProfileIcon(profile) {
      return GestureDetector(
        onTap: (){js.context.callMethod("open", [linkMap[profile]]);},
        child: Container(
          width: 72,
          height: 55,
          padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                // padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: logoMap[profile],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Text(profile),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.fromLTRB(15, 24, 15, 16),
      width: profileBoxWidth,
      child: Column(
        children: [
          Container(
            width: profileBoxWidth,
            child: Text(
              "Profiles",
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Roboto',
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              children: [
                _makeProfileIcon("LinkedIn"),
                _makeProfileIcon("Twitter"),
                _makeProfileIcon("GitHub"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Did Change Dependencies
  @override
  void didChangeDependencies() {
    // Initialization
    precacheImage(linkedInLogo.image, context);
    precacheImage(githubLogo.image, context);
    precacheImage(twitterLogo.image, context);
    precacheImage(selfie1.image, context);
    precacheImage(selfie2.image, context);
    precacheImage(selfie3.image, context);
    precacheImage(selfie4.image, context);
    precacheImage(selfie5.image, context);
    logoMap = {
      "LinkedIn": linkedInLogo,
      "GitHub": githubLogo,
      "Twitter": twitterLogo
    };
    linkMap = {
      "LinkedIn": 'https://www.linkedin.com/in/enes-grahovac-105/',
      "GitHub": 'https://github.com/enesgrahovac',
      "Twitter": 'https://twitter.com/EnesGrahovac'
    }; //
    super.didChangeDependencies();
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color.fromRGBO(223, 225, 229, 1),
              width: 1,
            ),
            color: Hexcolor(googleWhite),
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _createImagePreviews(),
              _nameAndTitle(),
              _shortDescription(),
              _buildTextInformation('Born: ',
                  "January, 1998 (age 22 years), Paterson, New Jersey"), // May 20, 1992 (age 28 years), Zürich, Switzerland
              _buildTextInformation('Height: ', '6\'2"'),
              _buildTextInformation('Education: ',
                  'University of Florida (2019–currently), Florida Institute of Technology (2016–2017), Suncoast Community High School'),
              _createOnlineProfileDisplay(),
            ],
          ),
        ),
        Container(
          width: width - contentWidth - profileBoxWidth,
          // color: Colors.blue,
        ),
      ],
    );
  }
}
