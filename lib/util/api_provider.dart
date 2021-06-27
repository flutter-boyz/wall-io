import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ApiProvider {
  final String key = '22257204-46e4c1426de993ebfe28667d6';

  Future<ImageModel> getImages(int count) async {
    final response = await http.get(
      Uri.parse(
          'https://pixabay.com/api/?key=$key&editors_choice=true&per_page=$count&orientation=vertical'),
    );
    if (response.statusCode == 200) {
      return ImageModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get images');
    }
  }
}
