//https://api.coingecko.com/api/v3/coins

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    Uri url = Uri.parse('https://api.coingecko.com/api/v3/coins/' + id);
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    var value = json['market_data']['current_price']['inr'].toString();
    return double.parse(value);
  } catch (e) {
    print(e.toString());
    return 0;
  }
}

// Future<String> getDescription(String id) async {
//   try {
//     Uri url = Uri.parse('https://api.coingecko.com/api/v3/coins/' + id);
//     var response = await http.get(url);
//     var json = jsonDecode(response.body);
//     var description = json['description']['en'].toString();
//     return description;
//   } catch (e) {
//     return (e.toString());
//   }
// }
