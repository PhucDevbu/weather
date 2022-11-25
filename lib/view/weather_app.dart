import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/logic/city/bloc/city_bloc.dart';
import 'package:weather/logic/weather/bloc/weather_bloc.dart';
import 'package:weather/view/weather_detail.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  WeatherAppState createState() => WeatherAppState();
}

class WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
        leading: Container(
          padding: const EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/menu.svg',
              height: 30,
              width: 30,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: 
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/night.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
          child: Container(
            decoration: const BoxDecoration(color: Colors.black45),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    'City',
                    style: GoogleFonts.roboto(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocConsumer<CityBloc, CityState>(
                    listener: (context, state) {
                      if (state is CityErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is CityLoadingState) {
                        return Expanded(
                          child: ListView(
                            children: const [
                              ListTile(
                                leading: Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                ),
                                title:
                                    Center(child: CircularProgressIndicator()),
                              ),
                              SizedBox(
                                height: 8,
                              )
                            ],
                          ),
                        );
                      } else if (state is CityLoadedState) {
                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BlocProvider(
                                                create: (context) =>
                                                    WeatherBloc()
                                                      ..add(FetchWeatherEvent(
                                                          state.citys[index].key
                                                              .toString())),
                                                child: WeatherDetail(
                                                  city: state
                                                      .citys[index].englishName,
                                                ),
                                              )));
                                },
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    state.citys[index].englishName.toString(),
                                    style: GoogleFonts.lato(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              );
                            },
                            itemCount: state.citys.length,
                          ),
                        );
                      }
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Error',
                            style: GoogleFonts.lato(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
