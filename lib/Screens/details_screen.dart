import 'package:covid_stat/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatefulWidget {
  String image;
  String name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailsScreen({
    super.key,
    required this.image,
    required this.name,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: GoogleFonts.candal(),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.067),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Card(
                    color: Colors.brown,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.06,
                        ),
                        ReUsableRow(
                            title: 'Total Cases',
                            value: widget.totalCases.toString()),
                        ReUsableRow(
                            title: 'Active Cases',
                            value: widget.active.toString()),
                        ReUsableRow(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        ReUsableRow(
                            title: 'Death',
                            value: widget.totalDeaths.toString()),
                        ReUsableRow(
                            title: 'Critical',
                            value: widget.critical.toString()),
                        ReUsableRow(
                            title: 'Today Recovered',
                            value: widget.todayRecovered.toString()),
                      ],
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
