import 'dart:convert';

import 'package:covid_stat/Models/world_states_model.dart';
import 'package:covid_stat/Utils/app_url.dart';
import 'package:http/http.dart' as http;

class StatesApiServices {
  //Fetch All data
  Future<WorldStatesModel> fetchWorldStatedRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error to Fetch from API');
    }
  }

  //Fetch Country Data
  Future<List<dynamic>> countryListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));

    if (response.statusCode == 200) {
      // Directly decode the JSON data as a List<dynamic>
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Error fetching data from API');
    }
  }
}
