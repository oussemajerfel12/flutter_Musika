import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Model/SearchResult.dart';
import '../Model/SongModel.dart';
import '../Provider/sqlconnection.dart';

class SqlServerApi {
  String baseUrl =
      "Data Source =192.168.3.1; Initial Catalog = DW_Musika;User Id=oussema;Password=12345689;";

  SqlServerApi();

  Future<List<Map<String, dynamic>>> Viewinsert1(String query) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: jsonEncode({"query": query}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        // Assuming the response is a JSON array of objects
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to fetch data from SQL Server');
      }
    } catch (e) {
      throw Exception('Failed to connect to SQL Server: $e');
    }
  }

  Future<void> viewInsert(String query) async {
    try {
      // Get the current date and time
      var conn = new SqlConnection(
          "SERVER=192.168.3.130,1433;Database=DW_Musika;User Id=oussema;Password=12345689;");
      // Send a POST request to the API to insert data
      await conn.open();
      await conn.execute(query);
    } catch (e) {
      print('Error: $e');
    }
  }
}
