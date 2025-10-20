import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vacuum_bunnies/data/services/api/api_client.dart';

import '../../../../models/bunny.dart';

class HomeViewModel extends ChangeNotifier {
  List<Bunny?>? bunnies = List.empty();
  HomeViewModel();

  final client = GetIt.instance<ApiClient>();

  @override
  Future<void> init() async {
    client.fetchBunnies();
  }
}