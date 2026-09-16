import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../details/place_details_page.dart';
import '../favorites/favorites_page.dart';
import '../bookings/bookings_page.dart';
import '../account/account_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'فجر';
  String gender = 'female';

  int selectedCategory = 0;
  int selectedBottomIndex = 0;

  final TextEditingController searchController = TextEditingController();

  final List<String> categories = [
    'الكل',
    'مطاعم',
    'مقاهي',
    'فعاليات',
    'طبيعة',
    'معالم',
  ];

  List<Map<String, dynamic>> get filteredPlaces {
    final String searchText = searchController.text.trim().toLowerCase();

    final List<Map<String, dynamic>> places = [
      {
        'image': 'assets/images/jeddah.jpg',
        'name': 'واجهة جدة البحرية',
        'city': 'جدة',
        'category': 'واجهة بحرية',
        'filterCategory': 'معالم',
        'rating': '4.7',
        'crowd': 'خفيفة',
        'crowdColor': const Color(0xFF3E4F3D),
      },
      {
        'image': 'assets/images/riyadh.jpg',
        'name': 'بوليفارد سيتي',
        'city': 'الرياض',
        'category': 'ترفيه',
        'filterCategory': 'فعاليات',
        'rating': '4.8',
        'crowd': 'متوسطة',
        'crowdColor': Colors.orange,
      },
      {
        'image': 'assets/images/abha.jpg',
        'name': 'السودة',
        'city': 'أبها',
        'category': 'طبيعة',
        'filterCategory': 'طبيعة',
        'rating': '4.9',
        'crowd': 'هادئة',
        'crowdColor': const Color(0xFF3E4F3D),
      },
    ];

    return places.where((place) {
      final bool matchesCategory = selectedCategory == 0 ||
          place['filterCategory'] == categories[selectedCategory];

      final String name = place['name'].toString().toLowerCase();
      final String city = place['city'].toString().toLowerCase();
      final String category = place['category'].toString().toLowerCase();

      final bool matchesSearch = searchText.isEmpty ||
          name.contains(searchText) ||
          city.contains(searchText) ||
          category.contains(searchText);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  String get welcomeMessage {
    if (gender == 'female') {
      return 'يا هلا يا $userName، نورتينا';
    } else {
      return 'يا هلا يا $userName، نورتنا';
    }
  }

  void openPlace({
    required String name,
    required String category,
    required String rating,
    required String distance,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsPage(
          name: name,
          category: category,
          rating: rating,
          distance: distance,
        ),
      ),
    );
  }

  Future<void> openGoogleMaps() async {
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=places+near+me',
    );

    if (!await launchUrl(
      googleMapsUrl,
      mode: LaunchMode.externalApplication,
    )) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تعذر فتح خرائط Google',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  void openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FavoritesPage(),
      ),
    );
  }

  void openBookings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BookingsPage(),
      ),
    );
  }

  void openAccount() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AccountPage(),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 380;
    final double pagePadding = isSmallScreen ? 14 : 20;
    final double placeCardWidth = isSmallScreen ? 220 : 245;

    const Color background = Color(0xFFFCFAF8);
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);
    const Color parkingBlue = Color(0xFF607D8B);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // TOP IMAGE
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 320,
                            child: Image.asset(
                              'assets/images/ad1.jpg',
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),

                          Container(
                            width: double.infinity,
                            height: 320,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.20),
                                  Colors.black.withOpacity(0.04),
                                  Colors.black.withOpacity(0.45),
                                ],
                              ),
                            ),
                          ),

                          // LOGO + ICONS
                          Positioned(
                            top: 20,
                            right: 20,
                            left: 20,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/palm_logo.png',
                                  width: 30,
                                  height: 36,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 7),
                                const Text(
                                  'لمحة',
                                  style: TextStyle(
                                    fontFamily: 'Rakkas',
                                    fontSize: 33,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),

                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.92),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Stack(
                                    children: [
                                      const Center(
                                        child: Icon(
                                          Icons.notifications_none_rounded,
                                          color: darkBrown,
                                          size: 23,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 9,
                                        child: Container(
                                          width: 7,
                                          height: 7,
                                          decoration: const BoxDecoration(
                                            color: burgundy,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 8),

                                GestureDetector(
                                  onTap: openAccount,
                                  child: Container(
                                    width: 42,
                                    height: 42,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.92),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.person_outline_rounded,
                                      color: darkBrown,
                                      size: 23,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // WELCOME
                          Positioned(
                            right: 22,
                            left: 22,
                            bottom: 62,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  welcomeMessage,
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'اعرف الزحمة والمواقف والتفاصيل قبل ما تطلع',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // MAIN CONTENT
                      Transform.translate(
                        offset: const Offset(0, -42),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(
                            pagePadding,
                            30,
                            pagePadding,
                            32,
                          ),
                          decoration: const BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(52),
                              topRight: Radius.circular(52),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SEARCH
                              Container(
                                height: 58,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFFEDE5DF),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 14,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: searchController,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  style: const TextStyle(
                                    color: darkBrown,
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'وين ناوي تروح؟',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF9A8D84),
                                      fontSize: 14,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      color: darkBrown,
                                      size: 24,
                                    ),
                                    suffixIcon: searchController.text.isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              searchController.clear();
                                              setState(() {});
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: cream,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  color: burgundy,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: cream,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Icon(
                                                Icons.tune_rounded,
                                                color: burgundy,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                    border: InputBorder.none,
                                    contentPadding:
                                        const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              // CATEGORIES
                              const Text(
                                'وش تدور عليه؟',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: darkBrown,
                                ),
                              ),

                              const SizedBox(height: 12),

                              SizedBox(
                                height: 43,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(width: 8);
                                  },
                                  itemBuilder: (context, index) {
                                    final bool isSelected =
                                        selectedCategory == index;

                                    IconData icon;

                                    switch (index) {
                                      case 1:
                                        icon = Icons.restaurant_outlined;
                                        break;
                                      case 2:
                                        icon = Icons.local_cafe_outlined;
                                        break;
                                      case 3:
                                        icon =
                                            Icons.local_activity_outlined;
                                        break;
                                      case 4:
                                        icon = Icons.park_outlined;
                                        break;
                                      case 5:
                                        icon =
                                            Icons.account_balance_outlined;
                                        break;
                                      default:
                                        icon = Icons.apps_rounded;
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedCategory = index;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 180),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected ? burgundy : cream,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border: Border.all(
                                            color: isSelected
                                                ? burgundy
                                                : const Color(0xFFE9DFD8),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              icon,
                                              size: 17,
                                              color: isSelected
                                                  ? Colors.white
                                                  : darkBrown,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              categories[index],
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: isSelected
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                                color: isSelected
                                                    ? Colors.white
                                                    : darkBrown,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 30),

                              // KNOW BEFORE YOU GO
                              const Text(
                                'اعرف قبل ما تروح',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: darkBrown,
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                'أهم التفاصيل اللي تحتاجها قبل ما تطلع',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: softBrown,
                                ),
                              ),

                              const SizedBox(height: 14),

                              Row(
                                children: [
                                  Expanded(
                                    child: _InfoCard(
                                      icon: Icons.people_outline_rounded,
                                      title: 'الزحمة',
                                      subtitle: 'اعرف المستوى',
                                      color: burgundy,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _InfoCard(
                                      icon: Icons.local_parking_rounded,
                                      title: 'المواقف',
                                      subtitle: 'تحقق من توفرها',
                                      color: parkingBlue,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _InfoCard(
                                      icon: Icons.access_time_rounded,
                                      title: 'الأوقات',
                                      subtitle: 'مفتوح أو مغلق',
                                      color: darkBrown,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 32),

                              // PLACES TITLE
                              Row(
                                children: [
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'أماكن تستحق لمحة',
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: darkBrown,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'من مدن مختلفة حول المملكة',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: softBrown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedCategory = 0;
                                        searchController.clear();
                                      });
                                    },
                                    child: const Text(
                                      'عرض الكل',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: burgundy,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // FILTERED PLACES
                              if (filteredPlaces.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                    border: Border.all(
                                      color: const Color(0xFFEDE5DF),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 58,
                                        height: 58,
                                        decoration: const BoxDecoration(
                                          color: cream,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.search_off_rounded,
                                          color: burgundy,
                                          size: 28,
                                        ),
                                      ),
                                      const SizedBox(height: 13),
                                      const Text(
                                        'ما لقينا أماكن هنا حاليًا',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: darkBrown,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'جرّب تبحث باسم ثاني أو اختر تصنيف مختلف',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: softBrown,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                SizedBox(
                                  height: 272,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: filteredPlaces.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(width: 14);
                                    },
                                    itemBuilder: (context, index) {
                                      final place = filteredPlaces[index];

                                      return _PlaceCard(
                                        image: place['image'],
                                        name: place['name'],
                                        city: place['city'],
                                        category: place['category'],
                                        rating: place['rating'],
                                        isOpen: true,
                                        parking: true,
                                        crowd: place['crowd'],
                                        crowdColor: place['crowdColor'],
                                        cardWidth: placeCardWidth,
                                        onTap: () {
                                          openPlace(
                                            name: place['name'],
                                            category: place['category'],
                                            rating: place['rating'],
                                            distance: place['city'],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),

                              const SizedBox(height: 30),

                              // MAP TITLE
                              Row(
                                children: [
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'شوف الأماكن حولك',
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            color: darkBrown,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'افتح الخريطة وشوف الأماكن القريبة',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: softBrown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: openGoogleMaps,
                                    icon: const Icon(
                                      Icons.open_in_new_rounded,
                                      size: 15,
                                      color: burgundy,
                                    ),
                                    label: const Text(
                                      'فتح الخريطة',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: burgundy,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),

                              // MAP PREVIEW
                              GestureDetector(
                                onTap: openGoogleMaps,
                                child: Container(
                                  height: 175,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0EBE4),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: const Color(0xFFE8DED7),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: Container(
                                            color: const Color(0xFFF0EBE4),
                                          ),
                                        ),

                                        Positioned(
                                          top: 40,
                                          left: -30,
                                          right: -30,
                                          child: Transform.rotate(
                                            angle: -0.12,
                                            child: Container(
                                              height: 8,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          top: 105,
                                          left: -30,
                                          right: -30,
                                          child: Transform.rotate(
                                            angle: 0.10,
                                            child: Container(
                                              height: 7,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          left: 105,
                                          top: -35,
                                          bottom: -35,
                                          child: Transform.rotate(
                                            angle: 0.18,
                                            child: Container(
                                              width: 7,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),

                                        const Positioned(
                                          top: 35,
                                          right: 70,
                                          child: _MapPin(
                                            icon: Icons.restaurant,
                                            color: burgundy,
                                          ),
                                        ),

                                        const Positioned(
                                          top: 95,
                                          left: 65,
                                          child: _MapPin(
                                            icon: Icons.local_cafe,
                                            color: darkBrown,
                                          ),
                                        ),

                                        const Positioned(
                                          bottom: 22,
                                          right: 120,
                                          child: _MapPin(
                                            icon: Icons.local_parking,
                                            color: parkingBlue,
                                          ),
                                        ),

                                        Positioned(
                                          bottom: 12,
                                          right: 12,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 11,
                                              vertical: 7,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.94),
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                            ),
                                            child: const Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: burgundy,
                                                  size: 17,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'حول موقعك',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color: darkBrown,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),

                              // TAKE A GLIMPSE
                              const Text(
                                'خذ لك لمحة',
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                  color: darkBrown,
                                ),
                              ),

                              const SizedBox(height: 5),

                              const Text(
                                'شوف وضع المكان قبل ما تروح',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: softBrown,
                                ),
                              ),

                              const SizedBox(height: 14),

                              Container(
                                width: double.infinity,
                                height: 190,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.08),
                                      blurRadius: 14,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Image.asset(
                                        'assets/images/jeddah.jpg',
                                        fit: BoxFit.cover,
                                      ),

                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.12),
                                              Colors.black.withOpacity(0.72),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        top: 14,
                                        left: 14,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.92),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye_outlined,
                                                size: 15,
                                                color: burgundy,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                'لمحة',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: burgundy,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      const Positioned(
                                        right: 16,
                                        left: 16,
                                        bottom: 15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'واجهة جدة البحرية',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 9),
                                            Wrap(
                                              spacing: 7,
                                              runSpacing: 6,
                                              children: [
                                                _GlimpseTag(
                                                  icon: Icons
                                                      .people_outline_rounded,
                                                  text: 'الزحمة خفيفة',
                                                ),
                                                _GlimpseTag(
                                                  icon: Icons
                                                      .local_parking_rounded,
                                                  text: 'المواقف متوفرة',
                                                ),
                                                _GlimpseTag(
                                                  icon: Icons
                                                      .access_time_rounded,
                                                  text: 'مفتوح الآن',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // BOTTOM NAVIGATION
              Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 18,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _BottomItem(
                      icon: Icons.home_rounded,
                      title: 'الرئيسية',
                      selected: selectedBottomIndex == 0,
                      onTap: () {
                        setState(() {
                          selectedBottomIndex = 0;
                        });
                      },
                    ),

                    _BottomItem(
                      icon: Icons.map_outlined,
                      title: 'الخريطة',
                      selected: selectedBottomIndex == 1,
                      onTap: () {
                        setState(() {
                          selectedBottomIndex = 1;
                        });

                        openGoogleMaps();
                      },
                    ),

                    _BottomItem(
                      icon: Icons.favorite_border_rounded,
                      title: 'المفضلة',
                      selected: selectedBottomIndex == 2,
                      onTap: () {
                        setState(() {
                          selectedBottomIndex = 2;
                        });

                        openFavorites();
                      },
                    ),

                    _BottomItem(
                      icon: Icons.calendar_month_outlined,
                      title: 'حجوزاتي',
                      selected: selectedBottomIndex == 3,
                      onTap: () {
                        setState(() {
                          selectedBottomIndex = 3;
                        });

                        openBookings();
                      },
                    ),

                    _BottomItem(
                      icon: Icons.person_outline_rounded,
                      title: 'حسابي',
                      selected: selectedBottomIndex == 4,
                      onTap: () {
                        setState(() {
                          selectedBottomIndex = 4;
                        });

                        openAccount();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// INFO CARD
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return Container(
      height: 112,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFEDE5DF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: color,
              size: 19,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              color: softBrown,
            ),
          ),
        ],
      ),
    );
  }
}

// MAP PIN
class _MapPin extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _MapPin({
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 19,
      ),
    );
  }
}

// PLACE CARD
class _PlaceCard extends StatelessWidget {
  final String image;
  final String name;
  final String city;
  final String category;
  final String rating;
  final bool isOpen;
  final bool parking;
  final String crowd;
  final Color crowdColor;
  final double cardWidth;
  final VoidCallback onTap;

  const _PlaceCard({
    required this.image,
    required this.name,
    required this.city,
    required this.category,
    required this.rating,
    required this.isOpen,
    required this.parking,
    required this.crowd,
    required this.crowdColor,
    required this.cardWidth,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);
    const Color burgundy = Color(0xFF6D2536);
    const Color green = Color(0xFF3E4F3D);
    const Color parkingBlue = Color(0xFF607D8B);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: const Color(0xFFF0E8E2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.045),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(23),
                  ),
                  child: Image.asset(
                    image,
                    width: cardWidth,
                    height: 125,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.92),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: burgundy,
                      size: 21,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 9,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Colors.amber,
                          size: 16,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          rating,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(13, 9, 13, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Row(
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: softBrown,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Container(
                        width: 3,
                        height: 3,
                        decoration: const BoxDecoration(
                          color: softBrown,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 7),
                      const Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: burgundy,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        city,
                        style: const TextStyle(
                          fontSize: 12,
                          color: softBrown,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: [
                      _StatusTag(
                        text: isOpen ? 'مفتوح' : 'مغلق',
                        icon: Icons.access_time,
                        color: isOpen ? green : Colors.red,
                      ),
                      _StatusTag(
                        text: parking ? 'مواقف' : 'بدون مواقف',
                        icon: Icons.local_parking,
                        color: parking ? parkingBlue : Colors.red,
                      ),
                      _StatusTag(
                        text: crowd,
                        icon: Icons.people_outline,
                        color: crowdColor,
                      ),
                    ],
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

// STATUS TAG
class _StatusTag extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const _StatusTag({
    required this.text,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: color,
          ),
          const SizedBox(width: 3),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// GLIMPSE TAG
class _GlimpseTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _GlimpseTag({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.90),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: const Color(0xFF6D2536),
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF49372E),
            ),
          ),
        ],
      ),
    );
  }
}

// BOTTOM ITEM
class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _BottomItem({
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color burgundy = Color(0xFF6D2536);
    const Color softBrown = Color(0xFF9B887C);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: selected ? burgundy : softBrown,
            ),
            const SizedBox(height: 3),
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    selected ? FontWeight.bold : FontWeight.normal,
                color: selected ? burgundy : softBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}