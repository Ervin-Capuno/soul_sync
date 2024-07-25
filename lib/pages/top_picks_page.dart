import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:tinder_clone/data/top_picks_json.dart';
import 'package:tinder_clone/data/likes_json.dart';


class TopPicksPage extends StatefulWidget {
  @override
  _TopPicksPageState createState() => _TopPicksPageState();
}

class _TopPicksPageState extends State<TopPicksPage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: Colors.white,
      body: TopPicksBody(),
    );
  }

  AppBar getAppBar() {
    List<String> bottomItems = [
      "assets/images/icons/explore_icon.svg",
      "assets/images/icons/likes_icon.svg",
      "assets/images/icons/chat_icon.svg",
      "assets/images/icons/account_icon.svg",
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

  void _handleLogoTap() {
  }
}

class TopPicksBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.only(bottom: 90),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); 
                },
                child: Text(
                  "${likes_json.length} Likes",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
              Text(
                "${top_picks_json.length} Top Picks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Divider(thickness: 0.8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: List.generate(top_picks_json.length, (index) {
              return Container(
                width: (size.width - 15) / 2,
                height: 250,
                child: Stack(
                  children: [
                    Container(
                      width: (size.width - 15) / 2,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(top_picks_json[index]['img']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: (size.width - 15) / 2,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.25),
                            Colors.black.withOpacity(0),
                          ],
                          end: Alignment.topCenter,
                          begin: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 8),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: top_picks_json[index]['active'] ? Colors.green : Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  top_picks_json[index]['active'] ? "Recently Active" : "Offline",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
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
            }),
          ),
        ),
      ],
    );
  }
}
