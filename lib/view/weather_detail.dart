import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/logic/weather/bloc/weather_bloc.dart';

import 'witgets/dot_widget.dart';
import 'witgets/weather_widget.dart';

class WeatherDetail extends StatefulWidget {
  final String? city;
  const WeatherDetail({super.key, required this.city});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  int _currentPage = 0;
  String? backgroundImage;

  void _launchUrlWeb(String urlText) async {
    final Uri url = Uri.parse(urlText);

    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  _onPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          if (state is WeatherLoadedState) {
            switch (state.weathers.headline!.category) {
              case ('rain'):
                backgroundImage = 'assets/rainy.jpg';
                break;
              case ('cloudy'):
                backgroundImage = 'assets/cloudy.jpeg';
                break;
              case ('sun'):
                backgroundImage = 'assets/sunny.jpg';
                break;
              default:
                backgroundImage = 'assets/night.jpg';
            }

            return Stack(children: [
              Image.asset(
                backgroundImage ?? "'assets/night.jpg'",
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.black38),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100, left: 15),
                child: Row(children: [
                  for (int i = 0;
                      i < state.weathers.dailyForecasts!.length;
                      i++)
                    (i == _currentPage)
                        ? const DotWidget(isActive: true)
                        : const DotWidget(isActive: false),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PageView.builder(
                        onPageChanged: _onPageChange,
                        itemCount: state.weathers.dailyForecasts!.length,
                        itemBuilder: (context, index) {
                          return WeatherWidget(
                              city: widget.city,
                              value: state.weathers.dailyForecasts?[index]
                                  .temperature?.minimum?.value,
                              text: state.weathers.headline?.text,
                              date: state.weathers.dailyForecasts?[index].date);
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 40),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white38)),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          child: OutlinedButton(
                              style: ButtonStyle(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color(0xfff9aa33)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                )),
                              ),
                              onPressed: () {
                                _launchUrlWeb(state.weathers.headline!.link!);
                              },
                              child: const ListTile(
                                  leading: Icon(
                                    Icons.language,
                                    color: Color(0xff232f34),
                                  ),
                                  title: Center(
                                      child: Text(
                                    "See website for more detail",
                                    style: TextStyle(
                                        color: Color(0xff232f34), fontSize: 18),
                                  )))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ]);
          } else if (state is WeatherErrorState) {
            return Stack(
              children: [
                Image.asset(
                  'assets/night.jpg',
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.black38),
                ),
                Center(
                  child: Text(
                    'Error',
                    style: GoogleFonts.lato(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            );
          }
          return Stack(
            children: [
              Image.asset(
                'assets/night.jpg',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.black38),
              ),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        },
      ),
    );
  }
}
