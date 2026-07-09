class weathermodel {
  late final String city;
  late final double temp;
  late final String description;
  late final int humidity;

  weathermodel({
    required this.city,
    required this.temp,
    required this.description,
    required this.humidity,
  });

  factory weathermodel.fromJson(Map<String, dynamic> json){
    return weathermodel(
      city: json['name'],
      temp: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
    );
  }
}