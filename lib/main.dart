import 'package:flutter/material.dart';

void main() {
  runApp(LamhaApp());
}

class LamhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  String userName = 'فجر';
  bool showEdit = false;

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xffF8F3EA),

        appBar: AppBar(
          backgroundColor: Color(0xffF8F3EA),
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'لمحة',
                style: TextStyle(
                  color: Color(0xff1D4035),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'L A M H A',
                style: TextStyle(
                  color: Color(0xff967457),
                  fontSize: 8,
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(
                Icons.notifications_none,
                color: Color(0xff1D4035),
                size: 24,
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 175,
                width: double.infinity,
                margin: EdgeInsets.only(
                  right: 16,
                  left: 16,
                  top: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  image: DecorationImage(
                    image: AssetImage('assets/images/saudi.jpg'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 52,
                        backgroundImage: AssetImage(
                          'assets/images/profile.jpg',
                        ),
                      ),

                      SizedBox(height: 12),

                      Text(
                        userName,
                        style: TextStyle(
                          color: Color(0xff1D4035),
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        'استكشف • عِش • شارك',
                        style: TextStyle(
                          color: Color(0xff967457),
                          fontSize: 13,
                        ),
                      ),

                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff967457),
                            size: 17,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'جدة، المملكة العربية السعودية',
                            style: TextStyle(
                              color: Color(0xff967457),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color(0xffF3EBDD),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Color(0xff1D4035),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '24',
                                    style: TextStyle(
                                      color: Color(0xff1D4035),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'المفضلة',
                                    style: TextStyle(
                                      color: Color(0xff967457),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color(0xffF3EBDD),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.place_outlined,
                                    color: Color(0xff1D4035),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '17',
                                    style: TextStyle(
                                      color: Color(0xff1D4035),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'زرتها',
                                    style: TextStyle(
                                      color: Color(0xff967457),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 10),

                          Expanded(
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color(0xffF3EBDD),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    color: Color(0xff1D4035),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '8',
                                    style: TextStyle(
                                      color: Color(0xff1D4035),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'تقييماتي',
                                    style: TextStyle(
                                      color: Color(0xff967457),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (showEdit == false) {
                                showEdit = true;
                                nameController.text = userName;
                              } else {
                                showEdit = false;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1D4035),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'تعديل الملف الشخصي',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      if (showEdit == true)
                        Column(
                          children: [
                            SizedBox(height: 18),

                            TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'الاسم',
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color(0xff1D4035),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),

                            SizedBox(height: 12),

                            SizedBox(
                              width: double.infinity,
                              height: 45,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (nameController.text.isNotEmpty) {
                                    setState(() {
                                      userName = nameController.text;
                                      showEdit = false;
                                    });
                                  } else {
                                    print('الاسم فارغ');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff967457),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  'حفظ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      SizedBox(height: 30),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'حسابي',
                          style: TextStyle(
                            color: Color(0xff1D4035),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 12),

                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F3EA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.bookmark_border,
                                  color: Color(0xff1D4035),
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Text('أماكني المحفوظة'),
                                ),
                                Icon(
                                  Icons.chevron_left,
                                  color: Color(0xff967457),
                                ),
                              ],
                            ),

                            Divider(height: 28),

                            Row(
                              children: [
                                Icon(
                                  Icons.history,
                                  color: Color(0xff1D4035),
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Text('الأماكن التي زرتها'),
                                ),
                                Icon(
                                  Icons.chevron_left,
                                  color: Color(0xff967457),
                                ),
                              ],
                            ),

                            Divider(height: 28),

                            Row(
                              children: [
                                Icon(
                                  Icons.notifications_none,
                                  color: Color(0xff1D4035),
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Text('الإشعارات'),
                                ),
                                Icon(
                                  Icons.chevron_left,
                                  color: Color(0xff967457),
                                ),
                              ],
                            ),

                            Divider(height: 28),

                            Row(
                              children: [
                                Icon(
                                  Icons.settings_outlined,
                                  color: Color(0xff1D4035),
                                ),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Text('الإعدادات'),
                                ),
                                Icon(
                                  Icons.chevron_left,
                                  color: Color(0xff967457),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 25),

                      Text(
                        'كل مكان يستحق لمحة',
                        style: TextStyle(
                          color: Color(0xff967457),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          height: 70,
          margin: EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 12,
          ),
          decoration: BoxDecoration(
            color: Color(0xff1D4035),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.white70,
                  ),
                  Text(
                    'الرئيسية',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.explore_outlined,
                    color: Colors.white70,
                  ),
                  Text(
                    'استكشف',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.white70,
                  ),
                  Text(
                    'المحفوظة',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.white,
                  ),
                  Text(
                    'حسابي',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}