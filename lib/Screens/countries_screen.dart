import 'package:covid_stat/Screens/details_screen.dart';
import 'package:covid_stat/Utils/states_api_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchFocusNode = FocusNode(); // Declare FocusNode

  @override
  void dispose() {
    // Dispose of the focus node and text controller when no longer needed
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Api calling
    StatesApiServices statesApiServices = StatesApiServices();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // Unfocus the text field when tapped outside
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05, vertical: height * 0.01),
                child: TextFormField(
                  controller: searchTextController,
                  focusNode: searchFocusNode, // Attach FocusNode
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: width * 0.05),
                    hintText: 'Search Country',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(width * 0.06),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: statesApiServices.countryListApi(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white),
                                  subtitle: Container(
                                      height: 10,
                                      width: 90,
                                      color: Colors.white),
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      color:
                                          Colors.white), // Display country flag
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          var country = snapshot.data?[index];
                          String countryName = country['country'];
                          String flagUrl = country['countryInfo']['flag'];

                          if (searchTextController.text.isEmpty) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    // Unfocus the search bar before navigation
                                    FocusScope.of(context).unfocus();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                        ),
                                      ),
                                    ).then((_) {
                                      // Unfocus again after returning from DetailsScreen
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  title: Text(
                                    countryName,
                                    style: GoogleFonts.suezOne(),
                                  ),
                                  subtitle: Text(
                                    'Affected: ${country['cases'].toString()}',
                                    style: GoogleFonts.cantataOne(fontSize: 13),
                                  ),
                                  leading: Image.network(
                                    flagUrl,
                                    height: 50,
                                    width: 50,
                                  ), // Display country flag
                                ),
                              ],
                            );
                          } else if (countryName.toLowerCase().contains(
                              searchTextController.text.toLowerCase())) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    // Unfocus the search bar before navigation
                                    FocusScope.of(context).unfocus();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          image: snapshot.data![index]
                                              ['countryInfo']['flag'],
                                          name: snapshot.data![index]
                                              ['country'],
                                          totalCases: snapshot.data![index]
                                              ['cases'],
                                          totalRecovered: snapshot.data![index]
                                              ['recovered'],
                                          totalDeaths: snapshot.data![index]
                                              ['deaths'],
                                          active: snapshot.data![index]
                                              ['active'],
                                          test: snapshot.data![index]['tests'],
                                          todayRecovered: snapshot.data![index]
                                              ['todayRecovered'],
                                          critical: snapshot.data![index]
                                              ['critical'],
                                        ),
                                      ),
                                    ).then((_) {
                                      // Unfocus again after returning from DetailsScreen
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  title: Text(
                                    countryName,
                                    style: GoogleFonts.suezOne(),
                                  ),
                                  subtitle: Text(
                                    'Affected: ${country['cases'].toString()}',
                                    style: GoogleFonts.cantataOne(fontSize: 13),
                                  ),
                                  leading: Image.network(
                                    flagUrl,
                                    height: 50,
                                    width: 50,
                                  ), // Display country flag
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
