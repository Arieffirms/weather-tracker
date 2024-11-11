import 'package:flutter/material.dart';
import 'package:tracking_cuaca/services/weather_service.dart';

class ResultTracker extends StatefulWidget {
  final String place;
  const ResultTracker({super.key, required this.place});

  @override
  State<ResultTracker> createState() => _ResultTrackerState();
}

class _ResultTrackerState extends State<ResultTracker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Result All Tracker",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3),
            () => WeatherService().getApiWeather(widget.place)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Card(
                elevation: 10,
                color: Colors.blueAccent[100],
                child: ListTile(
                  title: Text(
                    "${data.weather!.first.main}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${widget.place} ${data.main!.temp} °C",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                  leading: Image.network(
                      "http://openweathermap.org/img/wn/${data.weather!.first.icon}@2x.png"),
                  trailing: Image.network(
                      "https://flagsapi.com/${data.sys!.country}/flat/64.png"),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
