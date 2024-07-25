import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:tinder_clone/data/account_json.dart';
import 'package:tinder_clone/profile_info_big_card.dart';
import 'package:tinder_clone/theme/colors.dart';
import 'edit_profile_page.dart'; 

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    
  }

  void _updateProfile() async {
    
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );

    if (updated == true) {
      
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.withOpacity(0.2),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ShaderMask(
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.purple,
                      Colors.pink,
                      Colors.deepPurple,
                    ],
                    stops: [0.0, 0.33, 0.66, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds);
                },
                child: Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, 
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 400,
                    alignment: Alignment.center,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Image.asset(
                        'assets/images/girls/Kate.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      color: Colors.deepPurple.withOpacity(0.6),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 100),
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(account_json[0]['img'] ?? ''),
                        ),
                        SizedBox(height: 15),
                        Text(
                          '${account_json[0]['name'] ?? ''}, ${account_json[0]['age'] ?? ''}',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: _updateProfile,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                            child: Text(
                              'Edit Profile',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Container(
                          padding: const EdgeInsets.only(top: 50),
                          color: Colors.white,
                          child: Table(
                            children: [
                              TableRow(
                                children: [
                                  ProfileInfoBigCard(
                                    firstText: "13",
                                    secondText: "New Matches",
                                    icon: Icon(
                                      Icons.star,
                                      size: 32,
                                      color: deepPurple,
                                    ),
                                  ),
                                  ProfileInfoBigCard(
                                    firstText: "5",
                                    secondText: "Unmatched Me",
                                    icon: Image.asset(
                                      "assets/images/icons/sad_smiley.png",
                                      width: 32,
                                      color: deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  ProfileInfoBigCard(
                                    firstText: "264",
                                    secondText: "All Matches",
                                    icon: Image.asset(
                                      "assets/images/icons/checklist.png",
                                      width: 32,
                                      color: deepPurple,
                                    ),
                                  ),
                                  ProfileInfoBigCard(
                                    firstText: "42",
                                    secondText: "Rematches",
                                    icon: Icon(
                                      Icons.refresh,
                                      size: 32,
                                      color: deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  ProfileInfoBigCard(
                                    firstText: "1,013",
                                    secondText: "Profile Visitors",
                                    icon: Icon(
                                      Icons.remove_red_eye,
                                      size: 32,
                                      color: deepPurple,
                                    ),
                                  ),
                                  ProfileInfoBigCard(
                                    firstText: "50",
                                    secondText: "Super Likes",
                                    icon: Icon(
                                      Icons.favorite,
                                      size: 32,
                                      color: deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
      ),
    );
  }
}
