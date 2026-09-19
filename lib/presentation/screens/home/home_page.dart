import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/auth_service.dart';
import '../../../services/place_api_service.dart';
import '../../../cubit/places_cubit.dart';
import '../../../cubit/places_state.dart';

import '../details/place_details_page.dart';
import '../favorites/favorites_page.dart';
import '../bookings/bookings_page.dart';
import '../account/account_page.dart';

import '../../widgets/app_colors.dart';
import '../../widgets/status_item.dart';
import '../../widgets/section_header.dart';
import '../../widgets/place_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = AuthService();

  String userName = '';
  String gender = 'female';
  String userCity = 'جدة';
  bool isLoadingProfile = true;

  int selectedCategory = 0;
  int selectedBottomIndex = 0;

  final searchController = TextEditingController();

  final List<String> categories = [
    'الكل',
    'مطاعم',
    'مقاهي',
    'فعاليات',
    'طبيعة',
    'معالم',
  ];

  final List<Map<String, dynamic>> places = [
    {
      'image': 'assets/images/jeddah.jpg',
      'name': 'واجهة جدة البحرية',
      'city': 'جدة',
      'category': 'واجهة بحرية',
      'filterCategory': 'معالم',
      'rating': '4.7',
      'crowd': 'خفيفة',
      'crowdColor': AppColors.green,
      'parking': true,
      'isOpen': true,
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
      'parking': true,
      'isOpen': true,
    },
    {
      'image': 'assets/images/abha.jpg',
      'name': 'السودة',
      'city': 'أبها',
      'category': 'طبيعة',
      'filterCategory': 'طبيعة',
      'rating': '4.9',
      'crowd': 'هادئة',
      'crowdColor': AppColors.green,
      'parking': true,
      'isOpen': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final profile = await auth.getProfile();

      if (!mounted) return;

      if (profile != null) {
        setState(() {
          userName = profile['name'] ?? '';
          gender = profile['gender'] ?? 'female';
          userCity = profile['city'] ?? 'جدة';
          isLoadingProfile = false;
        });

      } else {
        setState(() {
          isLoadingProfile = false;
        });
      }
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingProfile = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'تعذر تحميل بيانات الحساب: $error',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  List<Map<String, dynamic>> get filteredPlaces {
    final searchText =
        searchController.text.trim().toLowerCase();

    return places.where((place) {
      final matchesCategory =
          selectedCategory == 0 ||
          place['filterCategory'] ==
              categories[selectedCategory];

      final name =
          place['name'].toString().toLowerCase();

      final city =
          place['city'].toString().toLowerCase();

      final category =
          place['category'].toString().toLowerCase();

      final matchesSearch =
          searchText.isEmpty ||
          name.contains(searchText) ||
          city.contains(searchText) ||
          category.contains(searchText);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  String get welcomeMessage {
    if (userName.isEmpty) {
      return 'يا هلا، نورتنا';
    }

    if (gender == 'female') {
      return 'يا هلا يا $userName، نورتينا';
    }

    return 'يا هلا يا $userName، نورتنا';
  }

  String get profileImage {
    if (gender == 'male') {
      return 'assets/images/boy_profile.png';
    }

    return 'assets/images/girl_profile.png';
  }

  void openPlace(Map<String, dynamic> place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailsPage(
          name: place['name'],
          category: place['category'],
          rating: place['rating'],
          distance: place['city'],
        ),
      ),
    );
  }

  Future<void> openGoogleMaps() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=places+near+me',
    );

    if (!await launchUrl(
      url,
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
        builder: (_) => const FavoritesPage(),
      ),
    );
  }

  void openBookings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const BookingsPage(),
      ),
    );
  }

Future<void> openAccount() async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AccountPage(),
    ),
  );

  if (!mounted) return;

  await loadProfile();

  setState(() {
    selectedBottomIndex = 0;
  });
}

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth =
        MediaQuery.of(context).size.width;

    final isSmallScreen = screenWidth < 380;

    final pagePadding =
        isSmallScreen ? 14.0 : 20.0;

    final placeCardWidth =
        isSmallScreen ? 220.0 : 245.0;

    if (isLoadingProfile) {
      return const Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Center(
            child: CircularProgressIndicator(
              color: AppColors.burgundy,
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      key: ValueKey(userCity),
      create: (context) =>
          PlacesCubit(PlaceApiService())..getPlaces(userCity),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHero(),

                      Transform.translate(
                        offset: const Offset(0, -42),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(
                            pagePadding,
                            30,
                            pagePadding,
                            10,
                          ),
                          decoration:
                              const BoxDecoration(
                            color:
                                AppColors.background,
                            borderRadius:
                                BorderRadius.only(
                              topLeft:
                                  Radius.circular(52),
                              topRight:
                                  Radius.circular(52),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                            children: [
                              _buildSearch(),

                              const SizedBox(
                                height: 22,
                              ),

                              _buildCategories(),

                              const SizedBox(
                                height: 30,
                              ),

                              _buildTodayGlimpse(),

                              const SizedBox(
                                height: 32,
                              ),

                              _buildPlaces(
                                placeCardWidth,
                              ),

                              const SizedBox(
                                height: 32,
                              ),

                              _buildApiPlaces(),

                              const SizedBox(
                                height: 32,
                              ),

                              _buildNearbyMap(),

                              const SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              _buildBottomNavigation(),
            ],
          ),
        ),
      ),
    ),
  );
  }

  // HERO

  Widget _buildHero() {
    return SizedBox(
      height: 320,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/ad1.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.20),
                  Colors.black.withOpacity(0.04),
                  Colors.black.withOpacity(0.50),
                ],
              ),
            ),
          ),

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

                _topIcon(
                  icon:
                      Icons.notifications_none_rounded,
                  showDot: true,
                  onTap: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'ما عندك إشعارات جديدة',
                          textAlign:
                              TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(width: 8),

                _profileButton(),
              ],
            ),
          ),

          Positioned(
            right: 22,
            left: 22,
            bottom: 65,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                if (isLoadingProfile)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                else
                  Text(
                    welcomeMessage,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                const SizedBox(height: 5),

                const Text(
                  'خلّ عندك لمحة قبل ما تطلع',
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
    );
  }

  Widget _profileButton() {
    return GestureDetector(
      onTap: openAccount,
      child: Container(
        width: 42,
        height: 42,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: isLoadingProfile
              ? const Icon(
                  Icons.person_outline_rounded,
                  color: AppColors.darkBrown,
                  size: 23,
                )
              : Image.asset(
                  profileImage,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  Widget _topIcon({
    required IconData icon,
    required VoidCallback onTap,
    bool showDot = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                icon,
                color: AppColors.darkBrown,
                size: 23,
              ),
            ),

            if (showDot)
              const Positioned(
                top: 8,
                right: 9,
                child: CircleAvatar(
                  radius: 3.5,
                  backgroundColor:
                      AppColors.burgundy,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // SEARCH

  Widget _buildSearch() {
    return Container(
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
        onChanged: (_) => setState(() {}),
        style: const TextStyle(
          color: AppColors.darkBrown,
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
            color: AppColors.darkBrown,
            size: 24,
          ),
          suffixIcon:
              searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.close_rounded,
                        color:
                            AppColors.burgundy,
                      ),
                    )
                  : const Icon(
                      Icons.tune_rounded,
                      color:
                          AppColors.burgundy,
                      size: 20,
                    ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 18,
          ),
        ),
      ),
    );
  }

  // CATEGORIES

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'وش تدور عليه؟',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkBrown,
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 43,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final selected =
                  selectedCategory == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(
                    milliseconds: 180,
                  ),
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.burgundy
                        : AppColors.cream,
                    borderRadius:
                        BorderRadius.circular(14),
                    border: Border.all(
                      color: selected
                          ? AppColors.burgundy
                          : const Color(
                              0xFFE9DFD8,
                            ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _categoryIcon(index),
                        size: 17,
                        color: selected
                            ? Colors.white
                            : AppColors
                                .darkBrown,
                      ),

                      const SizedBox(width: 6),

                      Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: selected
                              ? Colors.white
                              : AppColors
                                  .darkBrown,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _categoryIcon(int index) {
    switch (index) {
      case 1:
        return Icons.restaurant_outlined;
      case 2:
        return Icons.local_cafe_outlined;
      case 3:
        return Icons.local_activity_outlined;
      case 4:
        return Icons.park_outlined;
      case 5:
        return Icons.account_balance_outlined;
      default:
        return Icons.apps_rounded;
    }
  }

  // TODAY GLIMPSE

  Widget _buildTodayGlimpse() {
    final place = places.first;

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'لمحتك اليوم',
          subtitle:
              'مكان مختار لك مع أهم المعلومات قبل ما تروح',
        ),

        const SizedBox(height: 14),

        GestureDetector(
          onTap: () => openPlace(place),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(26),
              border: Border.all(
                color:
                    const Color(0xFFEDE5DF),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(
                    0.055,
                  ),
                  blurRadius: 18,
                  offset: const Offset(0, 7),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 175,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius
                                .vertical(
                          top:
                              Radius.circular(25),
                        ),
                        child: Image.asset(
                          place['image'],
                          fit: BoxFit.cover,
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius
                                  .vertical(
                            top: Radius.circular(
                              25,
                            ),
                          ),
                          gradient:
                              LinearGradient(
                            begin: Alignment
                                .topCenter,
                            end: Alignment
                                .bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black
                                  .withOpacity(
                                0.58,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 14,
                        left: 14,
                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration:
                              BoxDecoration(
                            color: Colors.white
                                .withOpacity(
                              0.92,
                            ),
                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons
                                    .auto_awesome_rounded,
                                color:
                                    AppColors
                                        .burgundy,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'اختيار لمحة',
                                style:
                                    TextStyle(
                                  color:
                                      AppColors
                                          .burgundy,
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        right: 16,
                        left: 16,
                        bottom: 14,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    place[
                                        'name'],
                                    style:
                                        const TextStyle(
                                      color: Colors
                                          .white,
                                      fontSize:
                                          19,
                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 3,
                                  ),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons
                                            .location_on_outlined,
                                        color:
                                            Colors
                                                .white,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        place[
                                            'city'],
                                        style:
                                            const TextStyle(
                                          color:
                                              Colors
                                                  .white,
                                          fontSize:
                                              12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal: 9,
                                vertical: 6,
                              ),
                              decoration:
                                  BoxDecoration(
                                color: Colors
                                    .black
                                    .withOpacity(
                                  0.38,
                                ),
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                  12,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons
                                        .star_rounded,
                                    color: Colors
                                        .amber,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    place[
                                        'rating'],
                                    style:
                                        const TextStyle(
                                      color: Colors
                                          .white,
                                      fontSize:
                                          12,
                                      fontWeight:
                                          FontWeight
                                              .bold,
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

                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(
                    15,
                    14,
                    15,
                    15,
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Expanded(
                            child: StatusItem(
                              icon: Icons
                                  .people_outline_rounded,
                              title: 'الزحمة',
                              value: 'خفيفة',
                              color:
                                  AppColors.green,
                            ),
                          ),

                          SizedBox(
                            height: 38,
                            child:
                                VerticalDivider(
                              color: Color(
                                0xFFEDE5DF,
                              ),
                            ),
                          ),

                          Expanded(
                            child: StatusItem(
                              icon: Icons
                                  .local_parking_rounded,
                              title: 'المواقف',
                              value: 'متوفرة',
                              color: AppColors
                                  .parkingBlue,
                            ),
                          ),

                          SizedBox(
                            height: 38,
                            child:
                                VerticalDivider(
                              color: Color(
                                0xFFEDE5DF,
                              ),
                            ),
                          ),

                          Expanded(
                            child: StatusItem(
                              icon: Icons
                                  .access_time_rounded,
                              title: 'الحالة',
                              value: 'مفتوح',
                              color:
                                  AppColors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              AppColors.cream,
                          borderRadius:
                              BorderRadius
                                  .circular(14),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .check_circle_outline_rounded,
                              color:
                                  AppColors.green,
                              size: 19,
                            ),

                            SizedBox(width: 7),

                            Expanded(
                              child: Text(
                                'الوقت مناسب للزيارة',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight:
                                      FontWeight
                                          .w600,
                                  color: AppColors
                                      .darkBrown,
                                ),
                              ),
                            ),

                            Text(
                              'شوف التفاصيل',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight
                                        .bold,
                                color: AppColors
                                    .burgundy,
                              ),
                            ),

                            SizedBox(width: 3),

                            Icon(
                              Icons
                                  .arrow_back_rounded,
                              color: AppColors
                                  .burgundy,
                              size: 17,
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
        ),
      ],
    );
  }

  // PLACES

  Widget _buildPlaces(double cardWidth) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'أماكن تستحق لمحة',
          subtitle:
              'اختيارات من مدن مختلفة حول المملكة',
          action: TextButton(
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
                color: AppColors.burgundy,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 12),

        if (filteredPlaces.isEmpty)
          _buildEmptySearch()
        else
          SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection:
                  Axis.horizontal,
              itemCount:
                  filteredPlaces.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 14),
              itemBuilder:
                  (context, index) {
                final place =
                    filteredPlaces[index];

                return PlaceCard(
                  image: place['image'],
                  name: place['name'],
                  city: place['city'],
                  category:
                      place['category'],
                  rating: place['rating'],
                  crowd: place['crowd'],
                  crowdColor:
                      place['crowdColor'],
                  width: cardWidth,
                  onTap: () =>
                      openPlace(place),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildEmptySearch() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFEDE5DF),
        ),
      ),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 29,
            backgroundColor: AppColors.cream,
            child: Icon(
              Icons.search_off_rounded,
              color: AppColors.burgundy,
              size: 28,
            ),
          ),

          SizedBox(height: 13),

          Text(
            'ما لقينا أماكن هنا حاليًا',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.darkBrown,
            ),
          ),

          SizedBox(height: 5),

          Text(
            'جرّب تبحث باسم ثاني أو اختر تصنيف مختلف',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.softBrown,
            ),
          ),
        ],
      ),
    );
  }


  // PLACES FROM API

  Widget _buildApiPlaces() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'اكتشف من حولك',
          subtitle: 'أماكن مقترحة في $userCity',
        ),

        const SizedBox(height: 12),

        BlocBuilder<PlacesCubit, PlacesState>(
          builder: (context, state) {
            if (state is PlacesLoading ||
                state is PlacesInitial) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFEDE5DF),
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.burgundy,
                  ),
                ),
              );
            }

            if (state is PlacesSuccess) {
              return SizedBox(
                height: 205,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.places.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final place = state.places[index];

                    return Container(
                      width: 230,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFFEDE5DF),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withOpacity(0.04),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundColor:
                                AppColors.cream,
                            child: Icon(
                              Icons.place_outlined,
                              color: AppColors.burgundy,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            place.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkBrown,
                            ),
                          ),

                          const SizedBox(height: 7),

                          Row(
                            children: [
                              const Icon(
                                Icons
                                    .location_on_outlined,
                                size: 16,
                                color:
                                    AppColors.softBrown,
                              ),

                              const SizedBox(width: 4),

                              Expanded(
                                child: Text(
                                  place.city.isEmpty
                                      ? userCity
                                      : place.city,
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color:
                                        AppColors.softBrown,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 7),

                          Text(
                            place.address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              height: 1.5,
                              color: AppColors.softBrown,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }

            if (state is PlacesError) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFEDE5DF),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.error_outline_rounded,
                      color: AppColors.burgundy,
                      size: 32,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.darkBrown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 12),

                    TextButton.icon(
                      onPressed: () {
                        context
                            .read<PlacesCubit>()
                            .getPlaces(userCity);
                      },
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                      label: const Text(
                        'إعادة المحاولة',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            AppColors.burgundy,
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }


  // NEARBY MAP

  Widget _buildNearbyMap() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'حولك',
          subtitle:
              'شوف أماكن قريبة وافتحها على الخريطة',
          action: TextButton.icon(
            onPressed: openGoogleMaps,
            icon: const Icon(
              Icons.open_in_new_rounded,
              size: 15,
            ),
            label:
                const Text('فتح الخريطة'),
            style: TextButton.styleFrom(
              foregroundColor:
                  AppColors.burgundy,
            ),
          ),
        ),

        const SizedBox(height: 10),

        GestureDetector(
          onTap: openGoogleMaps,
          child: Container(
            height: 145,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  const Color(0xFFF0EBE4),
              borderRadius:
                  BorderRadius.circular(24),
              border: Border.all(
                color:
                    const Color(0xFFE8DED7),
              ),
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(24),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      color: const Color(
                        0xFFF0EBE4,
                      ),
                    ),
                  ),

                  _mapRoad(
                    top: 30,
                    angle: -0.10,
                  ),

                  _mapRoad(
                    top: 92,
                    angle: 0.09,
                  ),

                  Positioned(
                    left: 110,
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
                    top: 25,
                    right: 70,
                    child: _MapPin(
                      icon:
                          Icons.restaurant,
                      color:
                          AppColors.burgundy,
                    ),
                  ),

                  const Positioned(
                    top: 78,
                    left: 65,
                    child: _MapPin(
                      icon:
                          Icons.local_cafe,
                      color: AppColors
                          .darkBrown,
                    ),
                  ),

                  const Positioned(
                    bottom: 15,
                    right: 120,
                    child: _MapPin(
                      icon: Icons
                          .local_parking,
                      color: AppColors
                          .parkingBlue,
                    ),
                  ),

                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors.white
                            .withOpacity(
                          0.95,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          13,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons
                                .location_on_outlined,
                            color: AppColors
                                .burgundy,
                            size: 16,
                          ),

                          SizedBox(width: 4),

                          Text(
                            'حول موقعك',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight:
                                  FontWeight
                                      .w600,
                              color: AppColors
                                  .darkBrown,
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
      ],
    );
  }

  Widget _mapRoad({
    required double top,
    required double angle,
  }) {
    return Positioned(
      top: top,
      left: -30,
      right: -30,
      child: Transform.rotate(
        angle: angle,
        child: Container(
          height: 7,
          color: Colors.white,
        ),
      ),
    );
  }

  // BOTTOM NAVIGATION

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _BottomItem(
            icon: Icons.home_rounded,
            title: 'الرئيسية',
            selected:
                selectedBottomIndex == 0,
            onTap: () {
              setState(() {
                selectedBottomIndex = 0;
              });
            },
          ),

          _BottomItem(
            icon: Icons.map_outlined,
            title: 'الخريطة',
            selected:
                selectedBottomIndex == 1,
            onTap: () {
              setState(() {
                selectedBottomIndex = 1;
              });

              openGoogleMaps();
            },
          ),

          _BottomItem(
            icon:
                Icons.favorite_border_rounded,
            title: 'المفضلة',
            selected:
                selectedBottomIndex == 2,
            onTap: () {
              setState(() {
                selectedBottomIndex = 2;
              });

              openFavorites();
            },
          ),

          _BottomItem(
            icon: Icons
                .calendar_month_outlined,
            title: 'حجوزاتي',
            selected:
                selectedBottomIndex == 3,
            onTap: () {
              setState(() {
                selectedBottomIndex = 3;
              });

              openBookings();
            },
          ),

          _BottomItem(
            icon:
                Icons.person_outline_rounded,
            title: 'حسابي',
            selected:
                selectedBottomIndex == 4,
            onTap: () {
              setState(() {
                selectedBottomIndex = 4;
              });

              openAccount();
            },
          ),
        ],
      ),
    );
  }
}

// خاص بالـ Home فقط
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
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.12,
            ),
            blurRadius: 8,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 18,
      ),
    );
  }
}

// خاص بالـ Home فقط
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              transform: Matrix4.translationValues(
                0,
                selected ? -4 : 0,
                0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: selected ? 14 : 5,
                vertical: selected ? 7 : 5,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.burgundy.withOpacity(0.10)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                  selected ? 16 : 13,
                ),
              ),
              child: AnimatedScale(
                scale: selected ? 1.12 : 1.0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: Icon(
                  icon,
                  size: 24,
                  color: selected
                      ? AppColors.burgundy
                      : AppColors.softBrown,
                ),
              ),
            ),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: selected ? 0 : 2,
            ),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: selected ? 10.5 : 10,
                fontWeight: selected
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: selected
                    ? AppColors.burgundy
                    : AppColors.softBrown,
              ),
              child: Text(title),
            ),
          ],
        ),
      ),
    );
  }
}