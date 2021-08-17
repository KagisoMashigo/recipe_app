enum Environment { dev, test, prod }

class Env {
  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _Config.development;
        break;
      case Environment.test:
        _config = _Config.test;
        break;
      case Environment.prod:
        _config = _Config.production;
        break;

      default:
        _config = _Config.development;
        break;
    }
  }

  static String get apiRoot => _config['API_ROOT'];

  static String get apiTarget => _config['API_TARGET'];

  static String get apiUrl {
    String _apiRoot = _config['API_ROOT'];
    String _apiTarget = _config['API_TARGET'];

    return 'https://$_apiRoot/$_apiTarget';
  }

  static get buildEnv {
    return _config['BUILD_ENV'];
  }
}

class _Config {
  static const API_ROOT = 'API_ROOT';
  static const API_TARGET = 'API_TARGET';
  static const BUILD_ENV = 'BUILD_ENV';

  static Map<String, String> development = {
    API_ROOT: '',
    API_TARGET: '',
    BUILD_ENV: 'development',
  };

  static Map<String, String> production = {
    API_ROOT: '',
    API_TARGET: '',
    BUILD_ENV: 'production',
  };

  static Map<String, String> test = {
    API_ROOT: '',
    API_TARGET: '',
    BUILD_ENV: 'test',
  };
}
