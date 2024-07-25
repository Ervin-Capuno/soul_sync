import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder_clone/pages/top_picks_page.dart'; 

class IconOverlayPage extends StatefulWidget {
  @override
  _IconOverlayPageState createState() => _IconOverlayPageState();
}

class _IconOverlayPageState extends State<IconOverlayPage> {
  bool showBigHeart = false;
  bool showBigClose = false;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _showBigIcon(String iconType) {
    setState(() {
      if (iconType == 'heart') {
        showBigHeart = true;
        showBigClose = false;
      } else if (iconType == 'close') {
        showBigHeart = false;
        showBigClose = true;
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showBigHeart = false;
        showBigClose = false;
      });
    });
  }

  void _resetPage() {
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    const List item_icons = [
      {"icon": "assets/images/icons/refresh_icon.svg", "size": 45.0, "icon_size": 20.0},
      {"icon": "assets/images/icons/close_icon.svg", "size": 58.0, "icon_size": 25.0},
      {"icon": "assets/images/icons/like_icon.svg", "size": 57.0, "icon_size": 27.0},
      {"icon": "assets/images/icons/star_icon.svg", "size": 45.0, "icon_size": 25.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Icon Overlay'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            children: [
              Container(
                color: Colors.red,
                child: Center(child: Text('Page 1')),
              ),
              Container(
                color: Colors.green,
                child: Center(child: Text('Page 2')),
              ),
              Container(
                color: Colors.blue,
                child: Center(child: Text('Page 3')),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: item_icons.map((iconData) {
              return IconButton(
                icon: SvgPicture.asset(
                  iconData["icon"],
                  width: iconData["icon_size"],
                  height: iconData["icon_size"],
                ),
                iconSize: iconData["size"],
                onPressed: () {
                  if (iconData["icon"] == "assets/images/icons/like_icon.svg") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TopPicksPage()),
                    );
                  } else if (iconData["icon"] == "assets/images/icons/close_icon.svg") {
                    _showBigIcon('close');
                  } else if (iconData["icon"] == "assets/images/icons/refresh_icon.svg") {
                    _resetPage();
                  }
                },
              );
            }).toList(),
          ),
          if (showBigHeart)
            Positioned(
              top: 1000,
              child: Image.asset(
                'assets/images/icons/heart_large.png',
                width: 700,
                height: 900,
              ),
            ),
          if (showBigClose)
            Positioned(
              top: 1000,
              child: Image.asset(
                'assets/images/icons/close_large.png',
                width: 350,
                height: 500,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: IconOverlayPage(),
  ));
}
