abstract class BaseConfig {
  String get baseUrl;
  // bool get useHttps;
}

class StagingConfig implements BaseConfig {
  @override
  String get baseUrl => "https://staging-api.skiipe.com/api";
}

class ProdConfig implements BaseConfig {
  @override
  String get baseUrl => "https://api.skiipe.com/api";
}
