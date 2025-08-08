import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'utils.dart';

enum Flavor { development, staging, production }

class Environment {
  static String get fileName => Utils.getFlavor == Flavor.production
      ? '.env.production'
      : '.env.development';
  static String get apiUrl => dotenv.env['API_URL'] ?? 'MY_FALLBACK';
}
