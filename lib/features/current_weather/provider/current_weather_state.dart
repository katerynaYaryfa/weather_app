class CurrentWeatherState {
  final String cityName;
  final String searchCityName;
  final int temperature;
  final String temperatureDescription;
  final String weatherDescription;
  final String weatherIcon;
  final String mainImage;
  final String backgroundImage;
  final String sunriseFormatted;
  final String sunsetFormatted;
  final int tempMin;
  final int tempMax;
  final int pressure;
  final int humidity;
  final int windSpeed;
  final int clouds;

  CurrentWeatherState({
    this.cityName = '',
    this.searchCityName = '',
    this.temperature = 0,
    this.temperatureDescription = '',
    this.weatherDescription = '',
    this.weatherIcon = '',
    this.mainImage = '',
    this.backgroundImage = '',
    this.sunriseFormatted = '',
    this.sunsetFormatted = '',
    this.tempMin = 0,
    this.tempMax = 0,
    this.pressure = 0,
    this.humidity = 0,
    this.windSpeed = 0,
    this.clouds = 0,
  });

  CurrentWeatherState copyWith({
    String? cityName,
    String? searchCityName,
    int? temperature,
    String? temperatureDescription,
    String? weatherDescription,
    String? weatherIcon,
    String? mainImage,
    String? backgroundImage,
    String? sunriseFormatted,
    String? sunsetFormatted,
    int? tempMin,
    int? tempMax,
    int? pressure,
    int? humidity,
    int? windSpeed,
    int? clouds,
  }) {
    return CurrentWeatherState(
      cityName: cityName ?? this.cityName,
      searchCityName: searchCityName ?? this.searchCityName,
      temperature: temperature ?? this.temperature,
      temperatureDescription:
          temperatureDescription ?? this.temperatureDescription,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      weatherIcon: weatherIcon ?? this.weatherIcon,
      mainImage: mainImage ?? this.mainImage,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      sunriseFormatted: sunriseFormatted ?? this.sunriseFormatted,
      sunsetFormatted: sunsetFormatted ?? this.sunsetFormatted,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      clouds: clouds ?? this.clouds,
    );
  }
}
