import 'package:flutter/material.dart';

class SuggestPlacePage extends StatefulWidget {
  const SuggestPlacePage({super.key});

  @override
  State<SuggestPlacePage> createState() => _SuggestPlacePageState();
}

class _SuggestPlacePageState extends State<SuggestPlacePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    placeNameController.dispose();
    descriptionController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void submitPlace() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'تم إرسال اقتراحك بنجاح',
            textAlign: TextAlign.center,
          ),
        ),
      );

      placeNameController.clear();
      descriptionController.clear();
      cityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFFFCFAF8);
    const Color cream = Color(0xFFF8F3EC);
    const Color burgundy = Color(0xFF6D2536);
    const Color darkBrown = Color(0xFF49372E);
    const Color softBrown = Color(0xFF796A61);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'اقترح مكان',
            style: TextStyle(
              color: darkBrown,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: darkBrown,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 78,
                      height: 78,
                      decoration: const BoxDecoration(
                        color: cream,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_location_alt_outlined,
                        color: burgundy,
                        size: 38,
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Center(
                    child: Text(
                      'عندك مكان يستحق لمحة؟',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                  ),

                  const SizedBox(height: 7),

                  const Center(
                    child: Text(
                      'شاركنا اقتراحك وساعدنا نضيف أماكن جديدة',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: softBrown,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'اسم المكان',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: placeNameController,
                    decoration: InputDecoration(
                      hintText: 'مثال: حديقة الأمير ماجد',
                      hintStyle: const TextStyle(
                        color: Color(0xFFAA9D95),
                        fontSize: 13,
                      ),
                      prefixIcon: const Icon(
                        Icons.place_outlined,
                        color: burgundy,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9DFD8),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9DFD8),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: burgundy,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'اكتب اسم المكان';
                      }

                      if (value.trim().length < 3) {
                        return 'اسم المكان قصير جدًا';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'المدينة',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                      hintText: 'مثال: جدة',
                      hintStyle: const TextStyle(
                        color: Color(0xFFAA9D95),
                        fontSize: 13,
                      ),
                      prefixIcon: const Icon(
                        Icons.location_city_outlined,
                        color: burgundy,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9DFD8),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9DFD8),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: burgundy,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'اكتب اسم المدينة';
                      }

                      if (value.trim().length < 2) {
                        return 'اسم المدينة غير صحيح';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'وصف المكان',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: darkBrown,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'اكتب نبذة بسيطة عن المكان...',
                      hintStyle: const TextStyle(
                        color: Color(0xFFAA9D95),
                        fontSize: 13,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9DFD8),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: Color(0xFFE9DFD8),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: const BorderSide(
                          color: burgundy,
                          width: 1.5,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'اكتب وصف المكان';
                      }

                      if (value.trim().length < 10) {
                        return 'الوصف قصير، اكتب تفاصيل أكثر';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: submitPlace,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: burgundy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send_rounded,
                            size: 19,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'إرسال الاقتراح',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
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
      ),
    );
  }
}