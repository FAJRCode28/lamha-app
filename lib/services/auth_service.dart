import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  SupabaseClient get client => Supabase.instance.client;

  GoTrueClient get supa => client.auth;

  Future<void> login(String email, String pass) async {
    await supa.signInWithPassword(
      email: email,
      password: pass,
    );
  }

  Future<void> signup(
    String email,
    String pass,
    String name,
    String gender,
  ) async {
    final response = await supa.signUp(
      email: email,
      password: pass,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('تعذر إنشاء المستخدم');
    }

    await client.from('profiles').insert({
      'user_id': user.id,
      'name': name,
      'email': email,
      'gender': gender,
    });
  }

  Future<Map<String, dynamic>?> getProfile() async {
    final user = supa.currentUser;

    if (user == null) {
      return null;
    }

    final data = await client
        .from('profiles')
        .select()
        .eq('user_id', user.id)
        .maybeSingle();

    return data;
  }

  Future<void> updateProfile(
    String name,
    String gender,
  ) async {
    final user = supa.currentUser;

    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    await client
        .from('profiles')
        .update({
          'name': name,
          'gender': gender,
        })
        .eq('user_id', user.id);
  }

  Future<void> updateCity(String city) async {
    final user = supa.currentUser;

    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    await client
        .from('profiles')
        .update({
          'city': city,
        })
        .eq('user_id', user.id);
  }

  Future<void> updateInterests(String interests) async {
    final user = supa.currentUser;

    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    await client
        .from('profiles')
        .update({
          'interests': interests,
        })
        .eq('user_id', user.id);
  }

  Future<void> updateNotifications(bool enabled) async {
    final user = supa.currentUser;

    if (user == null) {
      throw Exception('المستخدم غير مسجل الدخول');
    }

    await client
        .from('profiles')
        .update({
          'notifications_enabled': enabled,
        })
        .eq('user_id', user.id);
  }

  Future<void> logout() async {
    await supa.signOut();
  }
}