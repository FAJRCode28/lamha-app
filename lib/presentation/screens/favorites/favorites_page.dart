import 'package:flutter/material.dart';
import '../details/place_details_page.dart';

class FavoritePlace {
  final String name;
  final String category;
  final String rating;
  final String city;

  FavoritePlace({
    required this.name,
    required this.category,
    required this.rating,
    required this.city,
  });
}

List<FavoritePlace> favoritePlaces = [];

bool isPlaceFavorite(String name) {
  return favoritePlaces.any((place) => place.name == name);
}

void addFavorite(FavoritePlace place) {
  if (!isPlaceFavorite(place.name)) {
    favoritePlaces.add(place);
  }
}

void removeFavorite(String name) {
  favoritePlaces.removeWhere((place) => place.name == name);
}

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String getImage(String name) {
    if (name.contains('بوليفارد')) {
      return 'assets/images/riyadh.jpg';
    } else if (name.contains('السودة')) {
      return 'assets/images/abha.jpg';
    } else {
      return 'assets/images/jeddah.jpg';
    }
  }

  String getCrowd(String name) {
    if (name.contains('بوليفارد')) {
      return 'متوسطة';
    } else if (name.contains('السودة')) {
      return 'هادئة';
    } else {
      return 'خفيفة';
    }
  }

  Color getCrowdColor(String name) {
    if (name.contains('بوليفارد')) {
      return Colors.orange;
    } else {
      return const Color(0xFF3E4F3D);
    }
  }

  void deleteFavorite(String name) {
    setState(() {
      removeFavorite(name);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          'تمت إزالة المكان من المفضلة',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFFFCFAF8);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);
    const Color parkingBlue = Color(0xFF607D8B);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFEDE5DF),
                    ),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: darkBrown,
                    size: 21,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'المفضلة',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: darkBrown,
                ),
              ),
            ],
          ),
        ),

        // إذا ما فيه أماكن محفوظة
        body: favoritePlaces.isEmpty
            ? const _EmptyFavorites()

            // إذا فيه أماكن محفوظة
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'الأماكن اللي حفظتها عشان ترجع لها بسهولة',
                      style: TextStyle(
                        fontSize: 13,
                        color: softBrown,
                      ),
                    ),
                    const SizedBox(height: 24),

                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: favoritePlaces.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 15);
                      },
                      itemBuilder: (context, index) {
                        final place = favoritePlaces[index];

                        return _FavoriteCard(
                          image: getImage(place.name),
                          name: place.name,
                          city: place.city,
                          category: place.category,
                          rating: place.rating,
                          crowd: getCrowd(place.name),
                          crowdColor: getCrowdColor(place.name),
                          parkingColor: parkingBlue,

                          // حذف من المفضلة
                          onDelete: () {
                            deleteFavorite(place.name);
                          },

                          // فتح تفاصيل المكان
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlaceDetailsPage(
                                  name: place.name,
                                  category: place.category,
                                  rating: place.rating,
                                  distance: place.city,
                                ),
                              ),
                            );

                            setState(() {});
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

// الصفحة الفاضية
class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);
    const Color cream = Color(0xFFF8F3EC);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 95,
              height: 95,
              decoration: const BoxDecoration(
                color: cream,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: burgundy,
                size: 43,
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'ما عندك أماكن مفضلة للحين',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'إذا عجبك مكان اضغط على القلب، وبيظهر لك هنا.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.6,
                color: softBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// كرت المكان
class _FavoriteCard extends StatelessWidget {
  final String image;
  final String name;
  final String city;
  final String category;
  final String rating;
  final String crowd;
  final Color crowdColor;
  final Color parkingColor;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _FavoriteCard({
    required this.image,
    required this.name,
    required this.city,
    required this.category,
    required this.rating,
    required this.crowd,
    required this.crowdColor,
    required this.parkingColor,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);
    const Color green = Color(0xFF3E4F3D);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFEDE5DF),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
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
                    top: Radius.circular(24),
                  ),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    height: 155,
                    fit: BoxFit.cover,
                  ),
                ),

                // القلب
                Positioned(
                  top: 12,
                  left: 12,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      width: 39,
                      height: 39,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.94),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: burgundy,
                        size: 22,
                      ),
                    ),
                  ),
                ),

                // التقييم
                Positioned(
                  bottom: 11,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
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
                          size: 17,
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
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Text(
                        category,
                        style: const TextStyle(
                          fontSize: 12,
                          color: softBrown,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '•',
                        style: TextStyle(
                          color: softBrown,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.location_on_outlined,
                        color: burgundy,
                        size: 15,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        city,
                        style: const TextStyle(
                          fontSize: 12,
                          color: softBrown,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 13),

                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      const _FavoriteTag(
                        icon: Icons.access_time_rounded,
                        text: 'مفتوح',
                        color: green,
                      ),
                      _FavoriteTag(
                        icon: Icons.local_parking_rounded,
                        text: 'مواقف',
                        color: parkingColor,
                      ),
                      _FavoriteTag(
                        icon: Icons.people_outline_rounded,
                        text: crowd,
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

// التاقات الصغيرة
class _FavoriteTag extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _FavoriteTag({
    required this.icon,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color,
          ),
          const SizedBox(width: 4),
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