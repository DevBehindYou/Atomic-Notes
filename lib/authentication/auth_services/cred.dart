// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class CredService {
  final String PROJECT_URL = dotenv.env['PROJECT_URL'] ?? '';
  final String API_KEY = dotenv.env['API_KEY'] ?? '';
}
