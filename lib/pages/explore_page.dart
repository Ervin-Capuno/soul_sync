import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tinder_clone/data/explore_json.dart';
import 'package:tinder_clone/theme/colors.dart';
import 'package:tinder_clone/pages/top_picks_page.dart';

const List item_icons = [
  {"icon": "assets/images/icons/refresh_icon.svg", "size": 45.0, "icon_size": 20.0},
  {"icon": "assets/images/icons/close_icon.svg", "size": 58.0, "icon_size": 25.0},
  {"icon": "assets/images/icons/like_icon.svg", "size": 57.0, "icon_size": 27.0},
  {"icon": "assets/images/icons/star_icon.svg", "size": 45.0, "icon_size": 25.0},
];

class ExplorePage extends StatefulWidget {
  final VoidCallback? onLogoTap;

  ExplorePage({Key? key, this.onLogoTap}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late List<Map<String, dynamic>> itemsTemp;
  late int itemLength;
  late List<bool> isExpandedList;
  bool showBigHeart = false;
  bool showBigClose = false;
  late PageController _pageController; 

  @override
  void initState() {
    super.initState();
    itemsTemp = List<Map<String, dynamic>>.from(explore_json);
    itemLength = explore_json.length;
    isExpandedList = List.generate(itemLength, (index) => false);
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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 120),
            child: Container(
              height: size.height,
              child: PageView.builder(
                controller: _pageController,
                itemCount: itemLength,
                itemBuilder: (context, index) => _buildCard(index, size),
              ),
            ),
          ),
          if (showBigHeart)
            Center(
              child: Image.asset(
                'assets/images/icons/heart_large.png',
                width: 150,
                height: 150,
              ),
            ),
          if (showBigClose)
            Center(
              child: Image.asset(
                'assets/images/icons/close_large.png',
                width: 150,
                height: 150,
              ),
            ),
        ],
      ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildCard(int index, Size size) {
    return GestureDetector(
      onTap: () {
        if (isExpandedList[index]) {
          setState(() {
            isExpandedList[index] = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(itemsTemp[index]['img'] ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      black.withOpacity(0.25),
                      black.withOpacity(0),
                    ],
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.72,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      itemsTemp[index]['name'] ?? '',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      itemsTemp[index]['age']?.toString() ?? '',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: green,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Recently Active",
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: List.generate(
                                    itemsTemp[index]['likes']?.length ?? 0,
                                    (indexLikes) {
                                      if (indexLikes == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(color: white, width: 2),
                                              borderRadius: BorderRadius.circular(30),
                                              color: white.withOpacity(0.4),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                              child: Text(
                                                itemsTemp[index]['likes']?[indexLikes] ?? '',
                                                style: TextStyle(color: white),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: white.withOpacity(0.2),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                                            child: Text(
                                              itemsTemp[index]['likes']?[indexLikes] ?? '',
                                              style: TextStyle(color: white),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: size.width * 0.2,
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isExpandedList[index] = !isExpandedList[index];
                                    });
                                  },
                                  child: Icon(
                                    Icons.info,
                                    color: white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isExpandedList[index]) ...[
                      _buildExpandedInfo(size, index),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedInfo(Size size, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpandedList[index] = false;
        });
      },
      child: SingleChildScrollView(
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildExpansionTile("About Me", itemsTemp[index]['aboutMe']),
              _buildExpansionTile("Essentials", itemsTemp[index]['essentials']),
              _buildExpansionTile("Basics", itemsTemp[index]['basics']),
              _buildExpansionTile("Lifestyle", itemsTemp[index]['lifestyle']),
              _buildExpansionTile("Interests", itemsTemp[index]['interests']),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTile(String title, dynamic content) {
    if (content is List<String>?) {
      return ExpansionTile(
        title: Text(
          title,
          style: TextStyle(color: black, fontWeight: FontWeight.bold),
        ),
        children: content?.map((item) => ListTile(
          title: Text(
            item,
            style: TextStyle(color: black),
          ),
        )).toList() ?? [],
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return GestureDetector(
              onTap: () {
                if (item_icons[index]['icon'] == 'assets/images/icons/refresh_icon.svg') {
                  _resetPage(); 
                } else if (item_icons[index]['icon'] == 'assets/images/icons/like_icon.svg') {
                  _showBigIcon('heart');
                } else if (item_icons[index]['icon'] == 'assets/images/icons/close_icon.svg') {
                  _showBigIcon('close');
                } else if (item_icons[index]['icon'] == 'assets/images/icons/star_icon.svg') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TopPicksPage()),
                  );
                }
              },
              child: Container(
                width: item_icons[index]['size'],
                height: item_icons[index]['size'],
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    item_icons[index]['icon'],
                    width: item_icons[index]['icon_size'],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose(); 
    super.dispose();
  }
}
