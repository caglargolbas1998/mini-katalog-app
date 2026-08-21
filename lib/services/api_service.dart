import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ApiResponse {
  List<ProductModel>? data;

  ApiResponse({this.data});
}

class ApiService {
  Future<ApiResponse> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    print('STATUS CODE: ${response.statusCode}');
    print('RESPONSE: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);

      final products = jsonData
          .map((item) => ProductModel.fromJson(item))
          .toList();

      print('PRODUCT COUNT: ${products.length}');

      return ApiResponse(data: products);
    } else {
      throw Exception('API Hatası: ${response.statusCode} - ${response.body}');
    }
  }
}
