import 'package:flutter/material.dart';
import 'package:machine_test/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class DataListScreen extends StatefulWidget {
  const DataListScreen({super.key});

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.read<HomeProvider>().getData(context));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (provider.dataList.isEmpty) {
        return Center(
          child: Text("No data", style: TextStyle()),
        );
      }
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(provider.dataList[index].name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(provider.dataList[index].email!, style: TextStyle(fontWeight: FontWeight.w500)),
                Text(provider.dataList[index].body!, style: TextStyle()),
              ],
            ),
          );
        },
      );
    });
  }
}
