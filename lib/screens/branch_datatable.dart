// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:offline_report_system/services/data_models.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BranchDataTable extends StatefulWidget {
  final String branchName;

  const BranchDataTable({Key? key, required this.branchName}) : super(key: key);

  @override
  State<BranchDataTable> createState() => _BranchDataTableState();
}

class _BranchDataTableState extends State<BranchDataTable> {
  List<FileChange> fileChanges = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is created
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    List<FileChange> data = await getDataTable();

    setState(() {
      fileChanges = data;
      isLoading = false;
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: AppText(text: 'ID')),
                        DataColumn(label: AppText(text: 'Name')),
                        //DataColumn(label: AppText(text: 'Path')),
                        DataColumn(label: AppText(text: 'Time')),
                        DataColumn(label: AppText(text: 'Type')),
                        DataColumn(label: AppText(text: 'Branch')),
                        //DataColumn(label: AppText(text: 'App')),
                      ],
                      // Update the rows section in the DataTable
                      rows: fileChanges.map((data) {
                        return DataRow(
                          cells: [
                            DataCell(AppText(text: data.id.toString())),
                            DataCell(GestureDetector(
                              onTap: () => _showDetailsModal(
                                  data), // Function to show modal sheet
                              child: Tooltip(
                                message: data.filename,
                                child: AppText(
                                    text: data.filename.length > 10
                                        ? '${data.filename.substring(0, 10)}...'
                                        : data.filename),
                              ),
                            )),
                            //DataCell(AppText(text: data.path)),
                            DataCell(AppText(text: data.timestamp)),
                            DataCell(AppText(text: data.type)),
                            DataCell(AppText(text: data.branch)),
                            //DataCell(AppText(text: data.app)),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<List<FileChange>> getDataTable() async {
    String link = 'http://192.168.1.36:3001/fileChanges';

    try {
      var response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['fileChanges'] is List) {
          List<FileChange> modelList = [];
          for (var eachData in jsonData['fileChanges']) {
            final change = FileChange.fromJson(eachData);
            modelList.add(change);
          }
          return modelList;
        } else {
          print('Unexpected data format: ${response.body}');
          AppSnackBar().showSnackBar(
            context,
            'Error: Data is not in the expected format',
          );
          return [];
        }
      } else {
        AppSnackBar().showSnackBar(
          context,
          'Error: ${response.statusCode}',
        );
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      AppSnackBar().showSnackBar(
        context,
        'Error fetching data: $e',
      );
      return [];
    }
  }

  void _showDetailsModal(FileChange data) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: AppText(
                  text: 'Details of the File',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: [
                  const AppText(
                    text: "ID: ",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(
                    text: data.id.toString(),
                  ),
                ],
              ),
              Row(
                children: [
                  const AppText(
                    text: "Name: \n",
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                  Expanded(child: AppText(text: data.filename)),
                ],
              ),
              Row(
                children: [
                  const AppText(
                    text: "Path: \n",
                    fontWeight: FontWeight.bold,
                  ),
                  Expanded(
                      child: AppText(
                    text: data.path,
                  )),
                ],
              ),
              Row(
                children: [
                  const AppText(
                    text: "Time: ",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(text: data.timestamp),
                ],
              ),
              Row(
                children: [
                  const AppText(
                    text: "Type: ",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(text: data.type),
                ],
              ),
              Row(
                children: [
                  const AppText(
                    text: "Branch: ",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(text: data.branch),
                ],
              ),
              Row(
                children: [
                  const AppText(
                    text: "App: ",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(text: data.app),
                ],
              ),
              const Spacer(),
              AppButton(
                onTap: () {
                  Navigator.pop(context);
                },
                buttonColor: AppColors.whiteColor,
                borderColor: AppColors.primaryColor,
                child: const AppText(text: 'Dismiss'),
              )
            ],
          ),
        );
      },
    );
  }
}
