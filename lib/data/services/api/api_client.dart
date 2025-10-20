import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../models/bunny.dart';

class ApiClient {
  ApiClient() {
    initialize();
  }
  late final client = Supabase.instance.client;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Supabase.initialize(
      url: "https://ilpqnzictscmxsjfawed.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlscHFuemljdHNjbXhzamZhd2VkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY3Nzg4OTUsImV4cCI6MjA3MjM1NDg5NX0.fFPlmKLkZYhPhAnMFsErdq8XV-8_RbqmM_zMw_6K8AY",
    );

    client.auth.onAuthStateChange.listen((data) {

    });
  }

  Future<List<Bunny>> fetchBunnies() async {
    final userId = client.auth.currentUser?.id;
    if (userId == null) {
      return List.empty();
    }
    final result = await client.from('user_bunny').select('''
    user_id,
    bunny_id,
    bunnies ( 
      id, type, color
    )
    ''').eq('user_id', userId);
    return result.map((bunny) => Bunny.fromJson(bunny)).toList();
  }

  Future<AuthResponse> signUp(String email, String password) async {
    try {
      return await client.auth.signUp(
        email: email,
        password: password,
      );
    }
    catch (e) {
      print(e);
      return AuthResponse();
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    try {
      return await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    }
    catch (e) {
      print(e);
      return AuthResponse();
    }
  }

  Future<void> logout() async {
    try {
      await client.auth.signOut();
    }
    catch (e) {
      return;
    }
  }
}