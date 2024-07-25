import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder_clone/pages/account_page.dart';
import 'package:tinder_clone/pages/chat_page.dart';
import 'package:tinder_clone/pages/explore_page.dart';
import 'package:tinder_clone/pages/likes_page.dart';
import 'package:tinder_clone/pages/top_picks_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        ExplorePage(),
        LikesPage(),
        ChatPage(),
        AccountPage(),
        TopPicksPage(),
      ],
    );
  }

  void _handleLogoTap() {
    setState(() {
      pageIndex = 0;
    });
  }

  AppBar getAppBar() {
    List<String> bottomItems = [
      "assets/images/icons/explore_icon.svg",
      "assets/images/icons/likes_icon.svg",
      "assets/images/icons/chat_icon.svg",
      "assets/images/icons/account_icon.svg",
      "assets/images/icons/likes_icon.svg",
    ];

    Map<String, Map<String, double>> activeBottomItems = {
      "assets/images/icons/explore_active_icon.svg": {"size": 45.0, "icon_size": 20.0},
      "assets/images/icons/likes_active_icon.svg": {"size": 45.0, "icon_size": 32.0},
      "assets/images/icons/chat_active_icon.svg": {"size": 45.0, "icon_size": 20.0},
      "assets/images/icons/account_active_icon.svg": {"size": 45.0, "icon_size": 20.0},
    };

    return AppBar(
      backgroundColor: Colors.white, 
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 130.0, 
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if (pageIndex != 0) {
                  _handleLogoTap();
                }
              },
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple,
                      Colors.pink,
                      Colors.deepPurple,
                    ],
                    stops: [0.0, 0.3, 0.6, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                child: Text(
                  'SoulSync',
                  style: TextStyle(
                    fontSize: 40, 
                    fontWeight: FontWeight.w900,
                    fontFamily: 'GreatVibes-Regular',
                    color: Colors.white, 
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: SvgPicture.asset(
                    pageIndex == 0
                        ? activeBottomItems.keys.toList()[0]
                        : bottomItems[0],
                    width: activeBottomItems.values.toList()[0]['icon_size'],
                    height: activeBottomItems.values.toList()[0]['icon_size'],
                    color: pageIndex == 0 ? Colors.purple : Colors.grey, 
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pageIndex = 1;
                    });
                  },
                  icon: SvgPicture.asset(
                    pageIndex == 1
                        ? activeBottomItems.keys.toList()[1]
                        : bottomItems[1],
                    width: activeBottomItems.values.toList()[1]['icon_size'],
                    height: activeBottomItems.values.toList()[1]['icon_size'],
                    color: pageIndex == 1 ? Colors.purple : Colors.grey, 
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pageIndex = 2;
                    });
                  },
                  icon: SvgPicture.asset(
                    pageIndex == 2
                        ? activeBottomItems.keys.toList()[2]
                        : bottomItems[2],
                    width: activeBottomItems.values.toList()[2]['icon_size'],
                    height: activeBottomItems.values.toList()[2]['icon_size'],
                    color: pageIndex == 2 ? Colors.purple : Colors.grey, 
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      pageIndex = 3;
                    });
                  },
                  icon: SvgPicture.asset(
                    pageIndex == 3
                        ? activeBottomItems.keys.toList()[3]
                        : bottomItems[3],
                    width: activeBottomItems.values.toList()[3]['icon_size'],
                    height: activeBottomItems.values.toList()[3]['icon_size'],
                    color: pageIndex == 3 ? Colors.purple : Colors.grey,
                    
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
