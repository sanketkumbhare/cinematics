import 'package:envied/envied.dart';

part 'EnvironmentVariables.g.dart';

@Envied()
abstract class EnvironmentVariables {

  @EnviedField(varName: 'BASEURL',obfuscate: true)
  static final baseUrl = _EnvironmentVariables.baseUrl;

  @EnviedField(varName: 'dbApiKey',obfuscate: true)
  static final apiKey = _EnvironmentVariables.apiKey;
}
