// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:offline_report_system/services/data_models.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<FileChange> fileChanges = [];
  bool isLoading = false;
  final List<String> _branchList = [
    "All",
    "Head Office",
    "Lightfoot Boston Street",
    "Wilkinson Road",
    "Cline Town",
    "Kissy",
    "Waterloo",
    "Kenema",
    "Koidu",
    "Makeni",
    "Bo",
    "Port Loko",
    "Njala",
    "Mobimbi"
  ];
  final List<String> _fileTypeList = [
    "All",
    "PNL",
    "Balance Sheet",
    "Cash Flow"
  ];
  final List<String> _displayOrderList = [
    "Ascending Order",
    "Descending Order"
  ];

  String? _selectedBranchVal = "All";
  String? _selectedFileTypeVal = "All";
  String? _selectedDisplayOrderVal = "Ascending Order";
  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is created
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
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

  Future<void> _fetchData() async {
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
        title: const AppText(text: 'Offline Report System'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh screen',
            onPressed: () {
              _fetchData(); // Reload data
            },
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () {
              // Generate and display PDF
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
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
                              ],
                              rows: fileChanges.map((data) {
                                return DataRow(
                                  cells: [
                                    DataCell(AppText(text: data.id.toString())),
                                    DataCell(GestureDetector(
                                      onTap: () => _showDetailsModal(data),
                                      child: Tooltip(
                                        message: data.filename,
                                        child: AppText(
                                          text: data.filename.length > 20
                                              ? '${data.filename.substring(0, 30)}...'
                                              : data.filename,
                                        ),
                                      ),
                                    )),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showDropdownFilter();
        },
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        label: const AppText(
          text: 'Filter',
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Future<List<FileChange>> getDataTable() async {
    String link = 'http://192.168.1.36:3001/fileChanges';
    //String link = 'http://localhost:3001/fileChanges';

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
      isDismissible: true,
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const AppText(
                      text: 'Details of the File',
                      fontWeight: FontWeight.bold,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_outlined),
                    ),
                  ],
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
                    text: "Date: ",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(text: data.date),
                ],
              ),
              Row(
                children: [
                  const AppText(
                    text: "Time: ",
                    fontWeight: FontWeight.bold,
                  ),
                  AppText(text: data.time),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    onTap: () {},
                    width: MediaQuery.of(context).size.width * 0.4,
                    buttonColor: AppColors.whiteColor,
                    borderColor: AppColors.primaryColor,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.picture_as_pdf_outlined),
                        AppText(text: 'PDF'),
                      ],
                    ),
                  ),
                  AppButton(
                    onTap: () {},
                    width: MediaQuery.of(context).size.width * 0.4,
                    buttonColor: AppColors.whiteColor,
                    borderColor: AppColors.primaryColor,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.share_outlined),
                        AppText(text: 'Share'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _showDropdownFilter() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: AppColors.whiteColor,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03,
            right: MediaQuery.of(context).size.width * 0.03,
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // dropdown for branch
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: const AppText(
                  text: 'Select Branch',
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField(
                value: _selectedBranchVal,
                items: _branchList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: AppText(text: e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedBranchVal = val as String;
                  });
                },
                icon: const Icon(Icons.arrow_drop_down_circle),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              // dropdown for fileType
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: const AppText(
                  text: 'Select File Type',
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField(
                value: _selectedFileTypeVal,
                items: _fileTypeList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: AppText(text: e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedFileTypeVal = val as String;
                  });
                },
                icon: const Icon(Icons.arrow_drop_down_circle),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              // dropdown for display order
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: const AppText(
                  text: 'Select Display Order',
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField(
                value: _selectedDisplayOrderVal,
                items: _displayOrderList
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: AppText(text: e),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedDisplayOrderVal = val as String;
                  });
                },
                icon: const Icon(Icons.arrow_drop_down_circle),
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const Spacer(),
              // button for cancel/apply
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: MediaQuery.of(context).size.width * 0.4,
                    borderColor: AppColors.primaryColor,
                    buttonColor: AppColors.whiteColor,
                    child: const AppText(text: 'Cancel'),
                  ),
                  AppButton(
                    onTap: () {
                      _applyFilters();
                      Navigator.pop(context);
                    },
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: const AppText(text: 'Apply'),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _applyFilters() {
    List<FileChange> filteredData = List.from(fileChanges);

    // Apply branch filter
    if (_selectedBranchVal != "All") {
      filteredData = filteredData
          .where((data) => data.branch == _selectedBranchVal)
          .toList();
    }

    // Apply file type filter
    if (_selectedFileTypeVal != "All") {
      filteredData = filteredData
          .where((data) => data.type == _selectedFileTypeVal)
          .toList();
    }

    // Apply display order filter
    if (_selectedDisplayOrderVal == "Ascending Order") {
      filteredData.sort((a, b) => a.filename.compareTo(b.filename));
    } else {
      filteredData.sort((a, b) => b.filename.compareTo(a.filename));
    }

    setState(() {
      fileChanges = filteredData;
    });
  }
}
