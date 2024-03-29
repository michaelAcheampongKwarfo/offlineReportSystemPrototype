// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:offline_report_system/services/data_models.dart';
import 'package:offline_report_system/services/firebase_services.dart';
import 'package:offline_report_system/widgets/app_button.dart';
import 'package:offline_report_system/widgets/app_colors.dart';
import 'package:offline_report_system/widgets/app_snackbar.dart';
import 'package:offline_report_system/widgets/app_text.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  State<TableScreen> createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List<FileChange> fileChanges = [];
  bool isLoading = false;
  final user = FirebaseAuth.instance.currentUser;
  final FirebaseServices _firebaseServices = FirebaseServices();
  bool _isLoading = false;

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
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: screenSize.width * 0.03),
        //     child: GestureDetector(
        //       onTap: () {
        //         Navigator.pushNamed(context, '/profileScreen');
        //       },
        //       child: const CircleAvatar(
        //         child: Icon(Icons.person_outline),
        //       ),
        //     ),
        //   )
        // ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.person,
                size: 50.0,
                color: AppColors.hintColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: user?.email ?? 'User Name',
                textOverflow: TextOverflow.ellipsis,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            ListTile(
              leading: const Icon(Icons.refresh_outlined),
              title: const AppText(text: 'Refresh Table'),
              onTap: () {
                // reload Screen
                _fetchData();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const AppText(text: 'Send Email'),
              onTap: () async {
                // Generate and send PDF
                File pdfFile = await _generatePdf(fileChanges);
                _sendPdfByEmail(pdfFile);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_outlined),
              title: const AppText(text: 'Show In PDF'),
              onTap: () {
                // Generate and display PDF
                _generatePdf(fileChanges);
              },
            ),
            SizedBox(
              height: screenSize.height * 0.1,
            ),
            const AppText(
              text: 'APP VERSION 1.0.0',
              fontSize: 13.0,
            ),
            _isLoading
                ? const CircularProgressIndicator()
                : AppButton(
                    onTap: () {
                      userSignOut();
                    },
                    width: screenSize.width * 0.5,
                    borderColor: AppColors.primaryColor,
                    buttonColor: AppColors.whiteColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(text: 'LOGOUT'),
                        SizedBox(
                          width: screenSize.width * 0.03,
                        ),
                        const Icon(Icons.logout_outlined),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(screenSize.width * 0.01 / 5),
                child: Material(
                  elevation: 3.0,
                  child: Container(
                    width: screenSize.width,
                    color: AppColors.whiteColor,
                    padding: EdgeInsets.all(screenSize.width * 0.05),
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: screenSize.width * 0.1,
                              columns: const [
                                DataColumn(
                                    label: AppText(
                                  text: 'ID',
                                  fontWeight: FontWeight.bold,
                                )),
                                DataColumn(
                                    label: AppText(
                                  text: 'Name',
                                  fontWeight: FontWeight.bold,
                                )),
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
                                              ? '${data.filename.substring(0, 20)}...'
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
          borderRadius: BorderRadius.circular(30.0),
        ),
        label: const Row(
          children: [
            Icon(
              Icons.filter_alt_outlined,
              color: AppColors.whiteColor,
            ),
            SizedBox(width: 05.0),
            AppText(
              text: 'Filter',
              color: AppColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }

  Future<List<FileChange>> getDataTable() async {
    //String link = 'http://192.168.32.233:3001/fileChanges';
    String link = 'http://192.168.1.159:3001/fileChanges';
    // String link = 'http://localhost:3001/fileChanges';

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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
              // Row(
              //   children: [
              //     const AppText(
              //       text: "Path: \n",
              //       fontWeight: FontWeight.bold,
              //     ),
              //     Expanded(
              //         child: AppText(
              //       text: data.path,
              //     )),
              //   ],
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
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
              // Row(
              //   children: [
              //     const AppText(
              //       text: "App: ",
              //       fontWeight: FontWeight.bold,
              //     ),
              //     AppText(text: data.app),
              //   ],
              // ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButton(
                    onTap: () {
                      _generateSinglePdfDetail(data);
                    },
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
                    onTap: () async {
                      File pdfFile = await _generatePdf(fileChanges);
                      _sendPdfByEmail(pdfFile);
                    },
                    width: MediaQuery.of(context).size.width * 0.4,
                    buttonColor: AppColors.whiteColor,
                    borderColor: AppColors.primaryColor,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.email_outlined),
                        AppText(text: 'Email'),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(
                      text: 'Select Branch',
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
              // buttons for cancel and apply
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

  Future<File> _generatePdf(List<FileChange> data) async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 7);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'ID';
    headerRow.cells[1].value = 'Name';
    headerRow.cells[2].value = 'Path';
    headerRow.cells[3].value = 'Date';
    headerRow.cells[4].value = 'Time';
    headerRow.cells[5].value = 'Path';
    headerRow.cells[6].value = 'Branch';

    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

    for (var item in data) {
      PdfGridRow row = grid.rows.add();
      row.cells[0].value = item.id.toString();
      row.cells[1].value = item.filename;
      row.cells[2].value = item.path;
      row.cells[3].value = item.date;
      row.cells[4].value = item.time;
      row.cells[5].value = item.path;
      row.cells[6].value = item.branch;
    }

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));

    final directory = await getExternalStorageDirectory();
    final path = directory?.path;
    final pdfFile = File('$path/PDFTable.pdf');
    final bytes = await document.save();
    await pdfFile.writeAsBytes(bytes);

    //_sendPdfByEmail(pdfFile);

    document.dispose();

    OpenFile.open('$path/PDFTable.pdf');

    return pdfFile; // return the pdfFile
  }

  Future<void> _generateSinglePdfDetail(FileChange data) async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();

    grid.columns.add(count: 7);
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.cells[0].value = 'ID';
    headerRow.cells[1].value = 'Name';
    headerRow.cells[2].value = 'Path';
    headerRow.cells[3].value = 'Date';
    headerRow.cells[4].value = 'Time';
    headerRow.cells[5].value = 'Path';
    headerRow.cells[6].value = 'Branch';

    headerRow.style.font =
        PdfStandardFont(PdfFontFamily.helvetica, 10, style: PdfFontStyle.bold);

    PdfGridRow row = grid.rows.add();
    row.cells[0].value = data.id.toString();
    row.cells[1].value = data.filename;
    row.cells[2].value = data.path;
    row.cells[3].value = data.date;
    row.cells[4].value = data.time;
    row.cells[5].value = data.path;
    row.cells[6].value = data.branch;

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));

    final directory = await getExternalStorageDirectory();
    final path = directory?.path;
    final bytes = await document.save();
    File('$path/PDFTable_${data.id}.pdf').writeAsBytes(bytes);

    document.dispose();

    OpenFile.open('$path/PDFTable_${data.id}.pdf');
  }

  Future<void> _sendPdfByEmail(File pdfFile) async {
    try {
      final directory = await getExternalStorageDirectory();
      final path = directory!.path;
      var attachment = File('$path/PDFTable.pdf').path;
      final Email email = Email(
        body: 'Offline Report System - PDF File',
        subject: 'Pdf DataTable',
        recipients: ['ofosucollins055@gmail.com'],
        attachmentPaths: [attachment],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
    } catch (e) {
      AppSnackBar().showSnackBar(context, e.toString());
    }
  }

  Future<File> _generatePdfFromDataTable(DataTable dataTable) async {
    final PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();
    final PdfGrid grid = PdfGrid();

    // Add columns to the grid
    grid.columns.add(count: dataTable.columns.length);

    // Add headers to the grid
    final PdfGridRow headerRow = grid.headers.add(1)[0];
    for (int i = 0; i < dataTable.columns.length; i++) {
      headerRow.cells[i].value = dataTable.columns[i].label;
    }

    // Add rows to the grid
    for (var row in dataTable.rows) {
      PdfGridRow pdfRow = grid.rows.add();
      for (int i = 0; i < row.cells.length; i++) {
        pdfRow.cells[i].value = row.cells[i].child.runtimeType == Text
            ? (row.cells[i].child as Text).data
            : '';
      }
    }

    grid.style.cellPadding = PdfPaddings(left: 5, top: 5);
    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height));

    final directory = await getExternalStorageDirectory();
    final path = directory?.path;
    final pdfFile = File('$path/PDFTable.pdf');
    final bytes = await document.save();
    await pdfFile.writeAsBytes(bytes);

    document.dispose();

    OpenFile.open('$path/PDFTable.pdf');

    return pdfFile; // return the pdfFile
  }

  void _generateAndDisplayPdfFromFilteredData() async {
    _applyFilters();
    await _generatePdfFromDataTable(DataTable(
      columns: const [
        DataColumn(label: AppText(text: 'ID')),
        DataColumn(label: AppText(text: 'Name')),
        // Add other columns as needed
      ],
      rows: fileChanges.map((data) {
        return DataRow(
          cells: [
            DataCell(AppText(text: data.id.toString())),
            DataCell(AppText(text: data.filename)),
            // Add other cells as needed
          ],
        );
      }).toList(),
    ));
  }

  void userSignOut() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _firebaseServices.userSignOutMethod(context);
      Navigator.pushReplacementNamed(context, '/welcomeScreen');
      //Navigator.pushNamed(context, '/welcomeScreen');
    } catch (e) {
      //AppSnackBar().showSnackBar(context, e.toString());
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
