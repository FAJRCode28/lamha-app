import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../favorites/favorites_page.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/status_item.dart';
import '../../widgets/section_header.dart';

class PlaceDetailsPage extends StatefulWidget {
  final String name;
  final String category;
  final String rating;
  final String distance;

  const PlaceDetailsPage({
    super.key,
    required this.name,
    required this.category,
    required this.rating,
    required this.distance,
  });

  @override
  State<PlaceDetailsPage> createState() =>
      _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = isPlaceFavorite(widget.name);
  }

  // PLACE DATA

  String get placeImage {
    if (widget.name.contains('بوليفارد')) {
      return 'assets/images/riyadh.jpg';
    }

    if (widget.name.contains('السودة')) {
      return 'assets/images/abha.jpg';
    }

    return 'assets/images/jeddah.jpg';
  }

  String get city {
    if (widget.name.contains('بوليفارد')) {
      return 'الرياض';
    }

    if (widget.name.contains('السودة')) {
      return 'أبها';
    }

    return 'جدة';
  }

  String get crowd {
    if (widget.name.contains('بوليفارد')) {
      return 'متوسطة';
    }

    if (widget.name.contains('السودة')) {
      return 'هادئة';
    }

    return 'خفيفة';
  }

  Color get crowdColor {
    if (widget.name.contains('بوليفارد')) {
      return Colors.orange;
    }

    return AppColors.green;
  }

  String get workingHours {
    if (widget.name.contains('بوليفارد')) {
      return '4:00 م - 2:00 ص';
    }

    if (widget.name.contains('السودة')) {
      return 'مفتوحة طوال اليوم';
    }

    return '24 ساعة';
  }

  bool get hasPaidExperiences {
    return widget.name.contains('بوليفارد');
  }

  String get description {
    if (widget.name.contains('بوليفارد')) {
      return 'وجهة ترفيهية في الرياض تضم مجموعة من المطاعم '
          'والمقاهي والتجارب والفعاليات. الدخول العام مجاني، '
          'وبعض التجارب والفعاليات قد تتطلب تذاكر.';
    }

    if (widget.name.contains('السودة')) {
      return 'منطقة طبيعية في أبها تتميز بالأجواء الجبلية '
          'والمساحات المفتوحة، وتعد من الوجهات المناسبة '
          'للاستمتاع بالطبيعة والإطلالات.';
    }

    return 'واجهة بحرية في جدة مناسبة للمشي وقضاء الوقت '
        'بالقرب من البحر، وتضم مساحات مفتوحة ومرافق متنوعة '
        'للزوار.';
  }

  // FAVORITE

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        removeFavorite(widget.name);
        isFavorite = false;

        _showMessage(
          'تمت إزالة المكان من المفضلة',
        );
      } else {
        addFavorite(
          FavoritePlace(
            name: widget.name,
            category: widget.category,
            rating: widget.rating,
            city: city,
          ),
        );

        isFavorite = true;

        _showMessage(
          'تمت إضافة المكان إلى المفضلة',
        );
      }
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // GOOGLE MAPS

  Future<void> openGoogleMaps() async {
    final query = Uri.encodeComponent(
      '${widget.name} $city',
    );

    final url = Uri.parse(
      'https://www.google.com/maps/search/'
      '?api=1&query=$query',
    );

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      if (!mounted) return;

      _showMessage(
        'تعذر فتح خرائط Google',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHero(),

                Transform.translate(
                  offset: const Offset(0, -38),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      28,
                      20,
                      10,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(46),
                        topRight: Radius.circular(46),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLiveStatus(),

                        const SizedBox(height: 30),

                        _buildBeforeYouGo(),

                        const SizedBox(height: 30),

                        _buildAbout(),

                        const SizedBox(height: 30),

                        _buildLocation(),

                        if (hasPaidExperiences) ...[
                          const SizedBox(height: 28),
                          _buildExperiences(),
                        ],

                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
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
      height: 350,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            placeImage,
            fit: BoxFit.cover,
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.28),
                  Colors.transparent,
                  Colors.black.withOpacity(0.68),
                ],
              ),
            ),
          ),

          Positioned(
            top: 18,
            right: 18,
            child: _circleButton(
              icon: Icons.arrow_forward_rounded,
              onTap: () => Navigator.pop(context),
            ),
          ),

          Positioned(
            top: 18,
            left: 18,
            child: _circleButton(
              icon: isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              iconColor: AppColors.burgundy,
              onTap: toggleFavorite,
            ),
          ),

          Positioned(
            right: 22,
            left: 22,
            bottom: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.category,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.burgundy,
                    ),
                  ),
                ),

                const SizedBox(height: 9),

                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 17,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      city,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(width: 16),

                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 18,
                    ),

                    const SizedBox(width: 4),

                    Text(
                      widget.rating,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = AppColors.darkBrown,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
      ),
    );
  }

  // LIVE STATUS

  Widget _buildLiveStatus() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: const Color(0xFFEDE5DF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'وضع المكان الآن',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBrown,
                ),
              ),

              const Spacer(),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 3.5,
                      backgroundColor: AppColors.green,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'تحديث الآن',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          const Text(
            'كل اللي تحتاج تعرفه بلمحة',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.softBrown,
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: StatusItem(
                  icon: Icons.people_outline_rounded,
                  title: 'الزحمة',
                  value: crowd,
                  color: crowdColor,
                ),
              ),

              _verticalDivider(),

              const Expanded(
                child: StatusItem(
                  icon: Icons.local_parking_rounded,
                  title: 'المواقف',
                  value: 'متوفرة',
                  color: AppColors.parkingBlue,
                ),
              ),

              _verticalDivider(),

              const Expanded(
                child: StatusItem(
                  icon: Icons.access_time_rounded,
                  title: 'الحالة',
                  value: 'مفتوح',
                  color: AppColors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 17),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColors.green,
                  size: 19,
                ),

                SizedBox(width: 7),

                Text(
                  'الوقت مناسب للزيارة',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 48,
      color: const Color(0xFFEDE5DF),
    );
  }

  // BEFORE YOU GO

  Widget _buildBeforeYouGo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'قبل ما تروح',
          subtitle: 'تفاصيل تساعدك ترتب طلعتك',
        ),

        const SizedBox(height: 14),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
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
              const _DetailRow(
                icon: Icons.family_restroom_rounded,
                title: 'مناسب للعوائل',
                value: 'نعم',
                color: AppColors.burgundy,
              ),

              _divider(),

              const _DetailRow(
                icon: Icons.payments_outlined,
                title: 'الدخول',
                value: 'مجاني',
                color: AppColors.burgundy,
              ),

              if (hasPaidExperiences) ...[
                _divider(),

                const _DetailRow(
                  icon: Icons.confirmation_number_outlined,
                  title: 'التجارب والفعاليات',
                  value: 'بعضها مدفوع',
                  color: AppColors.burgundy,
                ),
              ],

              _divider(),

              _DetailRow(
                icon: Icons.schedule_rounded,
                title: 'ساعات العمل',
                value: workingHours,
                color: AppColors.darkBrown,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      height: 1,
      color: Color(0xFFF0E8E2),
    );
  }

  // ABOUT

  Widget _buildAbout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
          title: 'عن المكان',
          subtitle: 'نبذة سريعة عن الوجهة',
        ),

        const SizedBox(height: 12),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: AppColors.burgundy.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  color: AppColors.burgundy,
                  size: 19,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.8,
                    color: AppColors.softBrown,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // LOCATION

  Widget _buildLocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'الموقع',
          subtitle: '$city، المملكة العربية السعودية',
        ),

        const SizedBox(height: 13),

        GestureDetector(
          onTap: openGoogleMaps,
          child: Container(
            height: 145,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF0EBE4),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFE8DED7),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: -20,
                    right: -20,
                    child: Transform.rotate(
                      angle: -0.08,
                      child: Container(
                        height: 7,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    left: -20,
                    right: -20,
                    child: Transform.rotate(
                      angle: 0.10,
                      child: Container(
                        height: 7,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Positioned(
                    top: -25,
                    bottom: -25,
                    right: 90,
                    child: Transform.rotate(
                      angle: 0.15,
                      child: Container(
                        width: 7,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.burgundy,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.burgundy.withOpacity(0.20),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 10,
                    left: 10,
                    bottom: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.near_me_outlined,
                            size: 17,
                            color: AppColors.burgundy,
                          ),

                          SizedBox(width: 6),

                          Expanded(
                            child: Text(
                              'افتح الموقع في Google Maps',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkBrown,
                              ),
                            ),
                          ),

                          Icon(
                            Icons.open_in_new_rounded,
                            size: 15,
                            color: AppColors.burgundy,
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

  // EXPERIENCES

  Widget _buildExperiences() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.burgundy.withOpacity(0.055),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.burgundy.withOpacity(0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.burgundy.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.confirmation_number_outlined,
                  color: AppColors.burgundy,
                  size: 21,
                ),
              ),

              const SizedBox(width: 11),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'تجارب وفعاليات',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBrown,
                      ),
                    ),

                    SizedBox(height: 2),

                    Text(
                      'بعض التجارب تحتاج تذكرة',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.softBrown,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                _showMessage(
                  'حجز التجارب قريبًا',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.burgundy,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              icon: const Icon(
                Icons.confirmation_number_outlined,
                size: 19,
              ),
              label: const Text(
                'استعرض التجارب والتذاكر',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// هذا خاص بصفحة التفاصيل فقط
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _DetailRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 13,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.08),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              size: 19,
              color: color,
            ),
          ),

          const SizedBox(width: 11),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.darkBrown,
              ),
            ),
          ),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.softBrown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}