import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../favorites/favorites_page.dart';

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
  State<PlaceDetailsPage> createState() => _PlaceDetailsPageState();
}

class _PlaceDetailsPageState extends State<PlaceDetailsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    isFavorite = isPlaceFavorite(widget.name);
  }

  String get placeImage {
    if (widget.name.contains('بوليفارد')) {
      return 'assets/images/riyadh.jpg';
    } else if (widget.name.contains('السودة')) {
      return 'assets/images/abha.jpg';
    } else {
      return 'assets/images/jeddah.jpg';
    }
  }

  String get city {
    if (widget.name.contains('بوليفارد')) {
      return 'الرياض';
    } else if (widget.name.contains('السودة')) {
      return 'أبها';
    } else {
      return 'جدة';
    }
  }

  String get crowd {
    if (widget.name.contains('بوليفارد')) {
      return 'متوسطة';
    } else if (widget.name.contains('السودة')) {
      return 'هادئة';
    } else {
      return 'خفيفة';
    }
  }

  Color get crowdColor {
    if (widget.name.contains('بوليفارد')) {
      return Colors.orange;
    }

    return const Color(0xFF3E4F3D);
  }

  String get entry {
    return 'مجاني';
  }

  String get workingHours {
    if (widget.name.contains('بوليفارد')) {
      return '4:00 م - 2:00 ص';
    } else if (widget.name.contains('السودة')) {
      return 'مفتوحة طوال اليوم';
    } else {
      return '24 ساعة';
    }
  }

  bool get hasPaidExperiences {
    return widget.name.contains('بوليفارد');
  }

  String get description {
    if (widget.name.contains('بوليفارد')) {
      return 'وجهة ترفيهية في الرياض تضم مجموعة من المطاعم والمقاهي '
          'والتجارب والفعاليات. الدخول العام مجاني، وبعض التجارب '
          'والفعاليات قد تتطلب تذاكر.';
    } else if (widget.name.contains('السودة')) {
      return 'منطقة طبيعية في أبها تتميز بالأجواء الجبلية والمساحات '
          'المفتوحة، وتعد من الوجهات المناسبة للاستمتاع بالطبيعة '
          'والإطلالات.';
    } else {
      return 'واجهة بحرية في جدة مناسبة للمشي وقضاء الوقت بالقرب من البحر، '
          'وتضم مساحات مفتوحة ومرافق متنوعة للزوار.';
    }
  }

  void toggleFavorite() {
    setState(() {
      if (isFavorite) {
        removeFavorite(widget.name);
        isFavorite = false;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              'تمت إزالة المكان من المفضلة',
              textAlign: TextAlign.center,
            ),
          ),
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 1),
            content: Text(
              'تمت إضافة المكان إلى المفضلة',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    });
  }

  Future<void> openGoogleMaps() async {
    final String query = Uri.encodeComponent(
      '${widget.name} $city',
    );

    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
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

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFFFCFAF8);
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);
    const Color green = Color(0xFF3E4F3D);
    const Color parkingBlue = Color(0xFF607D8B);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // صورة المكان
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 330,
                      child: Image.asset(
                        placeImage,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Container(
                      width: double.infinity,
                      height: 330,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.25),
                            Colors.transparent,
                            Colors.black.withOpacity(0.38),
                          ],
                        ),
                      ),
                    ),

                    // رجوع
                    Positioned(
                      top: 18,
                      right: 18,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.94),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            color: darkBrown,
                            size: 22,
                          ),
                        ),
                      ),
                    ),

                    // المفضلة
                    Positioned(
                      top: 18,
                      left: 18,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.94),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: toggleFavorite,
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: burgundy,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Transform.translate(
                  offset: const Offset(0, -42),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      27,
                      20,
                      35,
                    ),
                    decoration: const BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        topRight: Radius.circular(48),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // التصنيف
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: cream,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.category,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: burgundy,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 18,
                              color: burgundy,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              city,
                              style: const TextStyle(
                                fontSize: 14,
                                color: softBrown,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: darkBrown,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

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
                          'كل اللي يهمك عن المكان بلمحة',
                          style: TextStyle(
                            fontSize: 13,
                            color: softBrown,
                          ),
                        ),

                        const SizedBox(height: 15),

                        // الزحمة - المواقف - الحالة
                        Row(
                          children: [
                            Expanded(
                              child: _MainInfoCard(
                                icon: Icons.people_outline_rounded,
                                title: 'الزحمة',
                                value: crowd,
                                color: crowdColor,
                              ),
                            ),

                            const SizedBox(width: 10),

                            const Expanded(
                              child: _MainInfoCard(
                                icon: Icons.local_parking_rounded,
                                title: 'المواقف',
                                value: 'متوفرة',
                                color: parkingBlue,
                              ),
                            ),

                            const SizedBox(width: 10),

                            const Expanded(
                              child: _MainInfoCard(
                                icon: Icons.access_time_rounded,
                                title: 'الحالة',
                                value: 'مفتوح',
                                color: green,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        // التفاصيل
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
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
                                color: burgundy,
                              ),

                              const Divider(
                                height: 25,
                                color: Color(0xFFF0E8E2),
                              ),

                              _DetailRow(
                                icon: Icons.payments_outlined,
                                title: 'الدخول',
                                value: entry,
                                color: burgundy,
                              ),

                              if (hasPaidExperiences) ...[
                                const Divider(
                                  height: 25,
                                  color: Color(0xFFF0E8E2),
                                ),
                                const _DetailRow(
                                  icon:
                                      Icons.confirmation_number_outlined,
                                  title: 'التجارب والفعاليات',
                                  value: 'بعضها مدفوع',
                                  color: burgundy,
                                ),
                              ],

                              const Divider(
                                height: 25,
                                color: Color(0xFFF0E8E2),
                              ),

                              _DetailRow(
                                icon: Icons.schedule_rounded,
                                title: 'ساعات العمل',
                                value: workingHours,
                                color: darkBrown,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // عن المكان
                        const Text(
                          'عن المكان',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                          ),
                        ),

                        const SizedBox(height: 9),

                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1.8,
                            color: softBrown,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // الموقع
                        const Text(
                          'الموقع',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: darkBrown,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          '$city، المملكة العربية السعودية',
                          style: const TextStyle(
                            fontSize: 13,
                            color: softBrown,
                          ),
                        ),

                        const SizedBox(height: 13),

                        // شكل الخريطة
                        GestureDetector(
                          onTap: openGoogleMaps,
                          child: Container(
                            height: 115,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0EBE4),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: const Color(0xFFE8DED7),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 27,
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
                                  bottom: 25,
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

                                Center(
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: burgundy,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 3,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.location_on_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(11),
                                    ),
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.open_in_new_rounded,
                                          size: 14,
                                          color: burgundy,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Google Maps',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: burgundy,
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

                        const SizedBox(height: 15),

                        // فتح Google Maps
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton.icon(
                            onPressed: openGoogleMaps,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: burgundy,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            icon: const Icon(
                              Icons.near_me_outlined,
                              size: 20,
                            ),
                            label: const Text(
                              'افتح الموقع في Google Maps',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // التذاكر تظهر للبوليفارد
                        if (hasPaidExperiences) ...[
                          const SizedBox(height: 15),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'حجز التجارب قريبًا',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: burgundy,
                                side: const BorderSide(
                                  color: burgundy,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              icon: const Icon(
                                Icons.confirmation_number_outlined,
                              ),
                              label: const Text(
                                'استعرض التجارب والتذاكر',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 10),
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
}

// كرت المعلومات
class _MainInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _MainInfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return Container(
      height: 105,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFEDE5DF),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 33,
            height: 33,
            decoration: BoxDecoration(
              color: color.withOpacity(0.09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: color,
            ),
          ),

          const Spacer(),

          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: softBrown,
            ),
          ),

          const SizedBox(height: 1),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color == Colors.orange ? darkBrown : color,
            ),
          ),
        ],
      ),
    );
  }
}

// صف التفاصيل
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
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return Row(
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
              color: darkBrown,
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
              color: softBrown,
            ),
          ),
        ),
      ],
    );
  }
}