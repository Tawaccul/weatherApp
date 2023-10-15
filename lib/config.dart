class Config{
      Config._internal();

      static final Config _instance = Config._internal();

      factory Config() => _instance;

      String apiKey = 'c49f45de66dd44ba9c5194506230410';

      String baseUrl = 'http://api.weatherapi.com/v1';
      String currentUrl = 'current.json';
      String forecastUrl = 'forecast.json';
      
}