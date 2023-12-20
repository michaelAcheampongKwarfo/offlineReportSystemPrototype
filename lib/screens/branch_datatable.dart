// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:offline_report_system/services/data_models.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BranchDataTable extends StatefulWidget {
  final String branchName;

  const BranchDataTable({super.key, required this.branchName});

  @override
  State<BranchDataTable> createState() => _BranchDataTableState();
}

class _BranchDataTableState extends State<BranchDataTable> {
  List<DataTableModel> dataTableModelList = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is created
  }

  Future<void> fetchData() async {
    List<DataTableModel> data = await getDataTable();
    setState(() {
      dataTableModelList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: AppText(text: widget.branchName),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.print,
              color: AppColors.blackColor,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenSize.width * 0.01),
        child: Material(
          elevation: 3.0,
          child: Container(
            width: screenSize.width,
            color: AppColors.whiteColor,
            padding: EdgeInsets.all(screenSize.width * 0.01),
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: AppText(text: 'ID')),
                    DataColumn(label: AppText(text: 'Name')),
                    DataColumn(label: AppText(text: 'Size')),
                    DataColumn(label: AppText(text: 'Created By')),
                  ],
                  rows: dataTableModelList.map((data) {
                    return DataRow(
                      cells: [
                        DataCell(AppText(text: data.id)),
                        DataCell(AppText(text: data.fileName)),
                        DataCell(AppText(text: data.fileSize)),
                        DataCell(AppText(text: data.createdBy)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<DataTableModel>> getDataTable() async {
    String link =
        'http://192.168.1.36:5000/achBankingTransfer'; // Replace with your actual API endpoint
    try {
      var response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        List<DataTableModel> modelList = [];
        for (var eachDataList in jsonData) {
          final list = DataTableModel(
            id: eachDataList['fileId'].toString(),
            fileName: eachDataList['fileName'].toString(),
            fileSize: eachDataList['size'].toString(),
            createdBy: eachDataList['createdBy'].toString(),
          );
          modelList.add(list);
        }
        return modelList;
      } else {
        AppSnackBar().showSnackBar(
          context,
          'Error: ${response.statusCode}',
        );
        return [];
      }
    } catch (e) {
      AppSnackBar().showSnackBar(
        context,
        'Error fetching data: $e',
      );
      //print(e);
      return [];
    }
  }
}
