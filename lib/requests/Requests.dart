import 'package:http/http.dart' as http;
import 'dart:convert'; // To decode the JSON response

class Requests {
  static Future<List<Object>> get(String url) async {
    final response = await http.get(Uri.parse(url)); // Send GET request

    if (response.statusCode == 200) {
      // If the server returns a successful response, parse the JSON
      var data = jsonDecode(response.body); // Decode the response body
      print('GET Response: $data'); // Just printing the data for now
      return data; // Return the parsed data
    } else {
      // If the request failed, throw an error
      throw Exception('Failed to perform GET request');
    }
  }

  static Future<Object> post(String url, String json_body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json_body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // If the server returns a successful response, parse the JSON
      var data = jsonDecode(response.body); // Decode the response body
      print('POST Response: $data'); // Just printing the data for now
      return data; // Return the parsed data
    } else {
      // If the request failed, throw an error
      throw Exception('Failed to perform POST request');
    }
  }
}
