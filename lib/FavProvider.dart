import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final favProvider = StateProvider<List<String>>((ref) => []);
