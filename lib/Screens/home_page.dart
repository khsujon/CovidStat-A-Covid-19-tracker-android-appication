import 'package:covid_stat/Models/world_states_model.dart';
import 'package:covid_stat/Screens/countries_screen.dart';
import 'package:covid_stat/Utils/states_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //Animation Controller
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  //Custom Color
  final colorList = <Color>[
    const Color.fromARGB(255, 235, 139, 5),
    const Color.fromARGB(255, 16, 130, 75),
    const Color.fromARGB(255, 181, 29, 15),
  ];

  @override
  Widget build(BuildContext context) {
    StatesApiServices statesApiServices = StatesApiServices();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'World Wide Stats',
          style: GoogleFonts.candal(),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: height * 0.01),
            FutureBuilder(
              future: statesApiServices.fetchWorldStatedRecords(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: const Color.fromARGB(255, 60, 27, 193),
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total Case":
                              double.parse(snapshot.data!.cases!.toString()),
                          "Recovered": double.parse(
                              snapshot.data!.recovered!.toString()),
                          "Deaths":
                              double.parse(snapshot.data!.deaths!.toString()),
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true,
                            showChartValueBackground: false,
                            chartValueStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                        chartRadius: width * 0.32,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.right,
                            legendTextStyle: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                      ),

                      //Total Stats
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.06),
                        child: Card(
                          color: Colors.brown,
                          child: Column(
                            children: [
                              ReUsableRow(
                                  title: 'Total Case',
                                  value: snapshot.data!.cases.toString()),
                              ReUsableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              ReUsableRow(
                                  title: 'Recovered',
                                  value: snapshot.data!.recovered.toString()),
                              ReUsableRow(
                                  title: 'Active',
                                  value: snapshot.data!.active.toString()),
                              ReUsableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.critical.toString()),
                              ReUsableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReUsableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),

                      //Tracking Button
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesScreen(),
                              ));
                        },
                        child: Container(
                          height: height * 0.06,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 4, 122, 65),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            'Indiviual Countires',
                            style: GoogleFonts.asul(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          )),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style:
                    GoogleFonts.asul(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Text(
                value,
                style:
                    GoogleFonts.asul(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
