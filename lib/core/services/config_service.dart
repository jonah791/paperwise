import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import '../models/config.dart';

final _log = Logger('ConfigService');

class ConfigService {
  static const _secure = FlutterSecureStorage();
  static const _keyLlmApiKey = 'llm_api_key';
  static const _keyMineruApiKey = 'mineru_api_key';

  AppConfig _config = const AppConfig();
  bool _initialized = false;

  AppConfig get config => _config;

  Future<void> load() async {
    _config = const AppConfig();
    _initialized = true;
    _log.info('Config loaded with defaults');
  }

  Future<void> saveLlmApiKey(String key) async {
    await _secure.write(key: _keyLlmApiKey, value: key);
    _log.info('LLM API key saved');
  }

  Future<String?> readLlmApiKey() async {
    return await _secure.read(key: _keyLlmApiKey);
  }

  Future<void> saveMineruApiKey(String key) async {
    await _secure.write(key: _keyMineruApiKey, value: key);
    _log.info('MinerU API key saved');
  }

  Future<String?> readMineruApiKey() async {
    return await _secure.read(key: _keyMineruApiKey);
  }

  Future<void> updateConfig(AppConfig config) async {
    _config = config;
    _log.info('Config updated: provider=${config.defaultProvider}, '
        'model=${config.llmModel}, batchSize=${config.batchSize}');
  }

  bool get hasLlmKey => _config.llmApiBase.isNotEmpty;
}
