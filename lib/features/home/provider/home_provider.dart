import 'package:flutter/material.dart';
import 'package:machine_test/features/home/models/data_model.dart';
import 'package:machine_test/services/api_services.dart';

class HomeProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DataItem> _dataList = [];
  List<DataItem> get dataList => _dataList;

  putLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  getData(BuildContext context) async {
    putLoading(true);
    var data = await ApiServices().getData();
    try {
      _dataList = data.map<DataItem>((e) => DataItem.fromJson(e)).toList();
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error"), backgroundColor: Colors.red));
    }
    putLoading(false);
  }
}
